//
//  ScanViewController.m
//  Yi_Fei
//
//  Created by yons on 16/12/14.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "ScanViewController.h"
#import "ScanQrcodeController.h"
#import "EditCustomerController.h"
#import "PackageAPI.h"


@interface ScanViewController ()

@property (nonatomic, strong) UIButton  *btnOne;

@property (nonatomic, strong) UIButton  *btnTwo;


@property (strong, nonatomic) UIImage *image;

@property (strong, nonatomic) UIImagePickerController *pick;

@end

@implementation ScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  self.view.backgroundColor  = INTERFACECOLOR;
     [self setNav];
    [self createBtn];
    
}

- (void)setNav {
    self.navigationItem.title = @"扫描";
    UIButton* leftBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setImage:[UIImage imageNamed:@"fanhui_icon"] forState:UIControlStateNormal];
    leftBtn.frame = CGRectMake(0, 0, 25, 25);
    UIBarButtonItem* leftBtnItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    [leftBtn addTarget:self action:@selector(leftButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem =  leftBtnItem ;
}

-(void)leftButtonClick{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)createBtn{
    
    NSArray *strs = @[@"扫描二维码",@"扫描名片"];
    _btnOne = [[UIButton alloc] init];
    [_btnOne setTitle:strs[0] forState:UIControlStateNormal];
    _btnOne.backgroundColor = [UIColor whiteColor];
    _btnOne.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _btnOne.layer.borderWidth = 1.0;
    _btnOne.layer.cornerRadius = 5;
    _btnOne.layer.masksToBounds = YES;
    _btnOne.titleLabel.font = [UIFont systemFontOfSize:18];
    [_btnOne setTitleColor:COLOR forState:UIControlStateNormal];
    [self.view addSubview:_btnOne];
    [_btnOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).offset(74);
        make.leading.mas_equalTo(self.view).offset(20);
        make.trailing.mas_equalTo(self.view).offset(-20);
        make.height.mas_equalTo(50);
    }];
    _btnOne.tag = 1870;
    [_btnOne addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    _btnTwo = [[UIButton alloc] init];
    [_btnTwo setTitle:strs[1] forState:UIControlStateNormal];
    _btnTwo.titleLabel.font = [UIFont systemFontOfSize:18];
    [_btnTwo setTitleColor:COLOR forState:UIControlStateNormal];
    _btnTwo.backgroundColor = [UIColor whiteColor];
    _btnTwo.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _btnTwo.layer.borderWidth = 1.0;
    _btnTwo.layer.cornerRadius = 5;
    _btnTwo.layer.masksToBounds = YES;
    [self.view addSubview:_btnTwo];
    [_btnTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_btnOne.mas_bottom).offset(10);
        make.leading.mas_equalTo(self.view).offset(20);
        make.trailing.mas_equalTo(self.view).offset(-20);
        make.height.mas_equalTo(50);
    }];
    _btnTwo.tag = 1871;
    [_btnTwo addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
}


- (void)btnClick:(UIButton *)sender
{
    ScanQrcodeController *scanVC  = [[ScanQrcodeController alloc] init];
    scanVC.style = [self setQRCode];
    scanVC.isQQSimulator = YES;
    scanVC.isVideoZoom = YES;

    
    switch (sender.tag) {
        case 1870:
            [self.navigationController pushViewController:scanVC animated:YES];
            break;
        case 1871:
            {
     [self callSystemCamral];
            };
            break;
        default:
            break;
    }
}




-(LBXScanViewStyle*)setQRCode{
    
    //设置扫码区域参数设置
    //创建参数对象
    LBXScanViewStyle *style = [[LBXScanViewStyle alloc]init];
    
    //矩形区域中心上移，默认中心点为屏幕中心点
    style.centerUpOffset = 44;
    
    //扫码框周围4个角的类型,设置为外挂式
    style.photoframeAngleStyle = LBXScanViewPhotoframeAngleStyle_Outer;
    
    //扫码框周围4个角绘制的线条宽度
    style.photoframeLineW = 6;
    
    //扫码框周围4个角的宽度
    style.photoframeAngleW = 24;
    
    //扫码框周围4个角的高度
    style.photoframeAngleH = 24;
    
    //扫码框内 动画类型 --线条上下移动
    style.anmiationStyle = LBXScanViewAnimationStyle_LineMove;
    
    //线条上下移动图片
    style.animationImage = [UIImage imageNamed:@"CodeScan.bundle/qrcode_scan_light_green"];
    return style;
}


-(void)callSystemCamral{
    _pick = [[UIImagePickerController alloc]init];
    _pick.sourceType = UIImagePickerControllerSourceTypeCamera;
    _pick.delegate = self;
    [self presentViewController:_pick animated:YES completion:nil];
    
}

#pragma mark 代理方法
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *image =  [info objectForKey:UIImagePickerControllerOriginalImage];
    if (image) {
        _image = image;
        [self startRec:image];
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(void)startRec:(UIImage*)image{
    NSData *sendImageData = UIImageJPEGRepresentation(image, 0.75);
    NSUInteger sizeOrigin = [sendImageData length];
    NSUInteger sizeOriginKB = sizeOrigin / 1024;
    if (sizeOriginKB > 5*1024)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"图片大小超过5M，请重试"
                                                       delegate:nil
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"确定", nil];
        
        [alert show];
        return;
    }
    
    dispatch_source_t timer=dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
    
    dispatch_source_set_timer(timer, dispatch_time(DISPATCH_TIME_NOW, 0ull*NSEC_PER_SEC), DISPATCH_TIME_FOREVER, 1ull*NSEC_PER_SEC);
    
    dispatch_source_set_event_handler(timer, ^{
        PackageAPI *package = [[PackageAPI alloc] init];
        
        self.resultStr = [package uploadPackage:sendImageData andindexPath:0];
        [self performSelectorOnMainThread:@selector(recongnitionResult:) withObject:self.resultStr waitUntilDone:YES];
        dispatch_source_cancel(timer);
    });
    
    dispatch_source_set_cancel_handler(timer, ^{
        
    });
    //启动
    dispatch_resume(timer);
}


-(void)recongnitionResult:(id)sender
{
    _dataStr= sender;
    if ([_dataStr length])
    {
        if ([_dataStr isEqualToString:ERROR_SERVER]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:ERROR_SERVER
                                                           delegate:nil
                                                  cancelButtonTitle:nil
                                                  otherButtonTitles:@"确定", nil];
            
            [alert show];
            return;
        }
        if ([_dataStr isEqualToString:ERROR_TIMEOUT]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:ERROR_TIMEOUT
                                                           delegate:nil
                                                  cancelButtonTitle:nil
                                                  otherButtonTitles:@"确定", nil];
            
            [alert show];
            return;
        }
        if ([_dataStr isEqualToString:ERROR_NULL]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:ERROR_NULL
                                                           delegate:nil
                                                  cancelButtonTitle:nil
                                                  otherButtonTitles:@"确定", nil];
            [alert show];
            return;
        }
        EditCustomerController *edit = [[EditCustomerController alloc] init];
        edit.str = _dataStr;
        edit.image = _image;
        [self.navigationController pushViewController:edit animated:YES];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:ERROR_NULL
                                                       delegate:nil
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"确定", nil];
        
        [alert show];
        return;
    }
}



-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}




































@end



















