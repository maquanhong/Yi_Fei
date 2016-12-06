//
//  PeripheralBlueTooth.m
//  BlueToothText
//
//  Created by yons on 16/12/5.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "PeripheralBlueTooth.h"
#import <CoreBluetooth/CoreBluetooth.h>

#define TRANSFER_SERVICE_UUID    @"E20A39F4-73F5-4BC4-A12F-17D1AD07A961"
#define TRANSFER_CHARACTERISTIC_UUID    @"08590F7E-DB05-467E-8757-72F6FAEB13D4"
#define NOTIFY_MTU      20

@interface PeripheralBlueTooth ()<CBPeripheralManagerDelegate>

@property (strong, nonatomic) CBPeripheralManager       *peripheralManager;
@property (strong, nonatomic) CBMutableCharacteristic   *transferCharacteristic;
@property (strong, nonatomic) NSData                    *dataToSend;
@property (nonatomic, readwrite) NSInteger              sendDataIndex;

@end

@implementation PeripheralBlueTooth

//初始化单例对象
+ (instancetype)shareManager
{
    static PeripheralBlueTooth *peripheralBLue = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        peripheralBLue = [[PeripheralBlueTooth alloc] init];
    });
    return peripheralBLue;
}


#pragma mark 初始化类
- (instancetype)init
{
    if(self = [super init]){
        NSLog(@"单例实例化");
        // 初始化周边设备
    _peripheralManager = [[CBPeripheralManager alloc] initWithDelegate:self queue:nil];
    [self startAdvertising];
    }
    return self;
}


#pragma mark 发送广播
-(void)startAdvertising{
    // 发送对应UUID的服务广播
    [self.peripheralManager startAdvertising:@{ CBAdvertisementDataServiceUUIDsKey : @[[CBUUID UUIDWithString:TRANSFER_SERVICE_UUID]] }];
}


#pragma mark - Peripheral Delegate Methods

#pragma mark 确保蓝牙打开，支持BLE蓝牙
- (void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral
{
    // 应该处理各种状态
    if (peripheral.state != CBManagerStatePoweredOn) {
        return;
    }
    // 周边设备已准备好了
    NSLog(@"self.peripheralManager powered on.");
    // 创建特征
    self.transferCharacteristic = [[CBMutableCharacteristic alloc] initWithType:[CBUUID UUIDWithString:TRANSFER_CHARACTERISTIC_UUID]
                                                                     properties:CBCharacteristicPropertyNotify
                                                                          value:nil
                                                                    permissions:CBAttributePermissionsReadable];
    // 创建服务
    CBMutableService *transferService = [[CBMutableService alloc] initWithType:[CBUUID UUIDWithString:TRANSFER_SERVICE_UUID]
                                                                       primary:YES];
    
    // 把特征添加到服务中
    transferService.characteristics = @[self.transferCharacteristic];
    
    // 把服务添加到周边设备中
    [self.peripheralManager addService:transferService];
}


#pragma mark 当有人订阅我们的特征时发送数据

- (void)peripheralManager:(CBPeripheralManager *)peripheral central:(CBCentral *)central didSubscribeToCharacteristic:(CBCharacteristic *)characteristic
{
    NSLog(@"Central subscribed to characteristic");
    
    // 准备数据

    
    
    
    // 发送标记至0
    self.sendDataIndex = 0;
    // 发送数据
    [self sendData];
}


#pragma mark 当中心设备取消订阅特征时调用
- (void)peripheralManager:(CBPeripheralManager *)peripheral central:(CBCentral *)central didUnsubscribeFromCharacteristic:(CBCharacteristic *)characteristic
{
    NSLog(@"Central unsubscribed from characteristic");
}



#pragma mark 发送下一批数据
- (void)sendData
{
    // 设置标记，确认是否要发送结束标记“EOM”
    static BOOL sendingEOM = NO;
    
    if (sendingEOM) {
        
        // 发送结束标记
        BOOL didSend = [self.peripheralManager updateValue:[@"EOM" dataUsingEncoding:NSUTF8StringEncoding] forCharacteristic:self.transferCharacteristic onSubscribedCentrals:nil];
        
        // 如果结束标记发送成功
        if (didSend) {
            // 还原标记
            sendingEOM = NO;
            
            NSLog(@"Sent: EOM");
        }
        
    // 如果没有成功发送结束标记, 返回并等待 peripheralManagerIsReadyToUpdateSubscribers（准备好更新订阅代理方法） 被调用，然后再次发送数据
        return;
    }
    
    // 不发送结束标记的，就发送数据
    // 判断是否还有数据没有发送
    
    if (self.sendDataIndex >= self.dataToSend.length) {
        
        // 没有数据了返回
        return;
    }
    
    // 如果还有数据，我们就一直发送到回到失败为止
    
    BOOL didSend = YES;
    
    while (didSend) {
        
        // 准备下一个数据块
        // 计算发送的尺寸
        NSInteger amountToSend = self.dataToSend.length - self.sendDataIndex;
        
        // 不能超过 20 bytes
        if (amountToSend > NOTIFY_MTU) amountToSend = NOTIFY_MTU;
        
        // 复制我们需要的数据
        NSData *chunk = [NSData dataWithBytes:self.dataToSend.bytes+self.sendDataIndex length:amountToSend];
        // 发送
        didSend = [self.peripheralManager updateValue:chunk forCharacteristic:self.transferCharacteristic onSubscribedCentrals:nil];
        // 如果失败，就放弃这次数据，等待回调
        if (!didSend) {
            return;
        }

        NSString *stringFromData = [[NSString alloc] initWithData:chunk encoding:NSUTF8StringEncoding];
        NSLog(@"Sent: %@", stringFromData);
        
        // 更新发送标记
        self.sendDataIndex += amountToSend;
        
        // 判断是否是最后的数据
        if (self.sendDataIndex >= self.dataToSend.length) {
            
            // 如果是，发送结束
            
            // 标记要发送结束，因为每次发送可能失败，必须确保结束标记可以发出去
            sendingEOM = YES;
            
            // 发送结束
            BOOL eomSent = [self.peripheralManager updateValue:[@"EOM" dataUsingEncoding:NSUTF8StringEncoding] forCharacteristic:self.transferCharacteristic onSubscribedCentrals:nil];
            
            if (eomSent) {
                // 如果发送出去，还原结束标记
                sendingEOM = NO;
                
                NSLog(@"Sent: EOM");
            }
            
            return;
        }
    }
}


/** 当周边设备准备好发送下次数据的时候呢被调用
 *  这可以确保数据传递的及时性
 */
- (void)peripheralManagerIsReadyToUpdateSubscribers:(CBPeripheralManager *)peripheral
{
    // 开始发送数据
    [self sendData];
}






















@end





















































