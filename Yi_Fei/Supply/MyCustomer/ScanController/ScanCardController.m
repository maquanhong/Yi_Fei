
//
//  ScanCardController.m
//  Yi_Fei
//
//  Created by yons on 16/12/26.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "ScanCardController.h"
#import "PackageAPI.h"
#import "EditSupplyCardController.h"

@interface ScanCardController ()

@property (strong, nonatomic) UIImage *image;


@end

@implementation ScanCardController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =INTERFACECOLOR;
    [self setNav];
    [self callSystemCamral];
    
}

- (void)setNav {
    self.navigationItem.title = @"扫描名片";
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

#pragma mark 调用系统的相机
-(void)callSystemCamral{
    
  UIImagePickerController *pick = [[UIImagePickerController alloc]init];
    pick.sourceType = UIImagePickerControllerSourceTypeCamera;
    pick.delegate = self;
    [self presentViewController:pick animated:YES completion:nil];
    
}


#pragma mark 代理方法
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
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
        EditSupplyCardController *edit = [[EditSupplyCardController alloc] init];
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





































@end













