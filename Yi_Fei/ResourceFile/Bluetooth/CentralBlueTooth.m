//
//  CentralBlueTooth.m
//  BlueToothText
//
//  Created by yons on 16/12/5.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "CentralBlueTooth.h"
#import <CoreBluetooth/CoreBluetooth.h>

#define TRANSFER_SERVICE_UUID           @"E20A39F4-73F5-4BC4-A12F-17D1AD07A961"
#define TRANSFER_CHARACTERISTIC_UUID    @"08590F7E-DB05-467E-8757-72F6FAEB13D4"

static NSString * const kFileExtension = @"xlsx";

@interface CentralBlueTooth ()<CBCentralManagerDelegate, CBPeripheralDelegate>

/** 系统蓝牙管理对象 */
@property (strong, nonatomic, readonly) CBCentralManager *centralManager;
@property (strong, nonatomic) CBPeripheral          *discoveredPeripheral;
@property (strong, nonatomic) NSMutableData         *data;
//外围设备的数量
@property (strong, nonatomic) NSMutableArray *peripherals;

@end


@implementation CentralBlueTooth

//初始化单例对象
+ (instancetype)shareManager
{
    static CentralBlueTooth *centralBLue = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        centralBLue = [[CentralBlueTooth alloc] init];
    });
    return centralBLue;
}


#pragma mark 初始化类
- (instancetype)init
{
    if(self = [super init]){
        NSLog(@"单例实例化");
        _centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:dispatch_get_global_queue(0, 0)];
        // 初始化保存信息的对象
        _data = [[NSMutableData alloc] init];
        _peripherals = [[NSMutableArray alloc]init];
    }
    return self;
}


#pragma mark - <CBCentralManagerDelegate>
//检查设备蓝牙开关的状态
- (void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    if (central.state != CBManagerStatePoweredOn) {
        return;
    }
    [self scan];
}


//搜索设备
- (void)scan
{
    [self.centralManager scanForPeripheralsWithServices:@[[CBUUID UUIDWithString:TRANSFER_SERVICE_UUID]]
                                                options:@{ CBCentralManagerScanOptionAllowDuplicatesKey : @YES }];
}

#pragma mark 搜索到设备之后会进入下面的方法
- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI
{
    // 拒绝不可能的信号强度，规定的最大信号强度是－15db
    if (RSSI.integerValue > -15) {
        return;
    }
    // 拒绝太弱的信号 (正常值在 -22dB左右)
    if (RSSI.integerValue < -35) {
        return;
    }
   NSLog(@"Discovered %@ at %@", peripheral.name, RSSI);
    // 判断是否已经发现过
    if (self.discoveredPeripheral != peripheral) {
        // 把这个设备保存在起来
        self.discoveredPeripheral = peripheral;
        //连接设备
        [self.centralManager connectPeripheral:peripheral options:nil];
    }
}

#pragma mark 连接失败后清空之前的操作
- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
    [self cleanup];
}


#pragma mark 连接成功后 我们要确认这个周边设备提供我们需要的服务和特征
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral
{
    // 停止扫描周边设备
    [self.centralManager stopScan];

    // 清空之前收到的数据
    [self.data setLength:0];
    // 设置周边设备代理
    peripheral.delegate = self;
    
    // 搜索我们期望的服务
[peripheral discoverServices:@[[CBUUID UUIDWithString:TRANSFER_SERVICE_UUID]]];
}


#pragma mark 服务和特征找到了
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error
{
    if (error) {
        NSLog(@"Error discovering services: %@", [error localizedDescription]);
        [self cleanup];
        return;
    }
    // 便利这个设备提供的服务，在我们期望的服务中，搜索我们关心的特征
    for (CBService *service in peripheral.services) {
        [peripheral discoverCharacteristics:@[[CBUUID UUIDWithString:TRANSFER_CHARACTERISTIC_UUID]] forService:service];
    }
}


#pragma mark 订阅这个特征
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error
{
    // 如果有错误，处理
    if (error) {
        NSLog(@"Error discovering characteristics: %@", [error localizedDescription]);
        [self cleanup];
        return;
    }
    // 遍历特征寻找我们要的（只是以防万一）
    for (CBCharacteristic *characteristic in service.characteristics) {
        // And check if it's the right one
        if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:TRANSFER_CHARACTERISTIC_UUID]]) {
            
            // 只订阅我们要的
            [peripheral setNotifyValue:YES forCharacteristic:characteristic];
        }
    }
    // 完成后，我们就等待接受数据了
}


#pragma mark 获取特征的数据
- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    if (error) {
        NSLog(@"Error discovering characteristics: %@", [error localizedDescription]);
        return;
    }
    
    NSString *stringFromData = [[NSString alloc] initWithData:characteristic.value encoding:NSUTF8StringEncoding];
    
    // 判断是否收到足够的数据（EOM代表数据结尾）
    if ([stringFromData isEqualToString:@"EOM"]) {

        NSString *documentsFolderPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
        NSString *filePath = [[documentsFolderPath stringByAppendingPathComponent:@"单个商品报价"] stringByAppendingPathExtension:kFileExtension];
        [self.data writeToFile:filePath atomically:YES];
        
        
        // 取消订阅
        [peripheral setNotifyValue:NO forCharacteristic:characteristic];
        
        // 断开与周边设备的连接
        [self.centralManager cancelPeripheralConnection:peripheral];
    }
    // 还有没有收到足够的数据，我们把收到的数据拼接起来
    [self.data appendData:characteristic.value];
    
}


#pragma mark 通知我们是否要在订阅这个特征
- (void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    if (error) {
        NSLog(@"Error changing notification state: %@", error.localizedDescription);
    }
    // Exit if it's not the transfer characteristic
    if (![characteristic.UUID isEqual:[CBUUID UUIDWithString:TRANSFER_CHARACTERISTIC_UUID]]) {
        return;
    }
    // 通知开始了
    if (characteristic.isNotifying) {
        NSLog(@"Notification began on %@", characteristic);
    }
    // 通知已经停止了
    else {
        // 断开与周边设备的连接
        NSLog(@"Notification stopped on %@.  Disconnecting", characteristic);
        [self.centralManager cancelPeripheralConnection:peripheral];
    }
}



//断开连接
- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
    NSLog(@"Peripheral Disconnected");
    self.discoveredPeripheral = nil;
    // 我们重新搜寻周边设备
    [self scan];
}

#pragma mark 连接失败后，清空之前的操作
- (void)cleanup
{
    // 没有连接，我们不用做什么
    if (self.discoveredPeripheral.state != CBPeripheralStateConnected) {
        return;
    }
    // 如果我们订阅了通知
    if (self.discoveredPeripheral.services != nil) {
        for (CBService *service in self.discoveredPeripheral.services) {
            if (service.characteristics != nil) {
                for (CBCharacteristic *characteristic in service.characteristics) {
                    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:TRANSFER_CHARACTERISTIC_UUID]]) {
                        if (characteristic.isNotifying) {
                            // 如果特征正在通知，停止通知
                            [self.discoveredPeripheral setNotifyValue:NO forCharacteristic:characteristic];
                            
                            return;
                        }
                    }
                }
            }
        }
    }
    // 取消所有订阅后断开已经的连接
    [self.centralManager cancelPeripheralConnection:self.discoveredPeripheral];
}







@end


































