//
//  IdentifyViewController.m
//  Yi_Fei
//
//  Created by maquanhong on 2016/11/28.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "IdentifyViewController.h"
#import "PureLayout.h"
#import "HMScannerController.h"
#import "BUYButton.h"
#import "UserDefaultManager.h"

@interface IdentifyViewController ()
{
    UIView *_backView ;
}

@property (nonatomic,strong)UIImageView *imageVIew ;

@property (nonatomic,strong)NSString *infoStr ;

@end

@implementation IdentifyViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    [self  setNav];
   [self createQrCodeImage];

    _infoStr = [UserDefaultManager getDataByKey:@"info"];
    NSLog(@"%@",_infoStr);
    
}

#pragma mark 设置导航栏
-(void)setNav{
    
    _backView = [[UIView alloc] init];
    _backView.backgroundColor =  UIColorFromRGB(0x4fc2f9);
    [self.view addSubview:_backView];
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.view);
        make.trailing.equalTo(self.view);
        make.top.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    
    BackButton *btn = [[BackButton alloc] init];
    [btn setImage:[UIImage imageNamed:@"fanhui_icon"] forState:UIControlStateNormal];
    btn.frame = CGRectMake(10, 30, 25, 25);
    [_backView addSubview:btn];
    [btn addTarget:self action:@selector(leftButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"我的二维码";
    titleLabel.font = [UIFont systemFontOfSize:16];
    [_backView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).offset(30);
        make.centerX.equalTo(self.view);
        make.height.mas_equalTo(20);
    }];
    
    UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    saveBtn.backgroundColor = BACKCOLOR;
    saveBtn.layer.cornerRadius = 10;
    [saveBtn setTitle:@"保存二维码" forState:UIControlStateNormal];
    [saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_backView addSubview:saveBtn];
    [saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-50);
        make.centerX.equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(WIDTH - 100 , 50));
    }];
    [saveBtn addTarget:self action:@selector(saveImageView) forControlEvents:UIControlEventTouchUpInside];

}

- (void)leftButtonClick {
    [self.navigationController popViewControllerAnimated:YES];
}



#pragma mark 创建二维码
-(void)createQrCodeImage{
    
   UIView * view = [[UIView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    [_backView addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
    make.center.equalTo(_backView);
    make.size.mas_equalTo(CGSizeMake(WIDTH - 40, WIDTH - 40));
    }];
    
   UIImageView *imageVIew = [[UIImageView alloc] init];
    [view addSubview:imageVIew];
    [imageVIew mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(view);
        make.size.mas_equalTo(CGSizeMake(200 ,200));
    }];

    NSString *cardName = @"易非";
    UIImage *avatar = [UIImage imageNamed:@"erwei"];
    [HMScannerController cardImageWithCardName:cardName avatar:avatar scale:0.2 completion:^(UIImage *image) {
        imageVIew.image = image;
    }];
}

-(void)saveImageView{
    if (self.imageVIew.image) {
UIImageWriteToSavedPhotosAlbum(self.imageVIew.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    }
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    if(!error){
        [self showMessage:@"成功保存到相册"];
    }else{
        [self showMessage:[NSString stringWithFormat:@"%@",error]];
    }
}

-(void)showMessage:(NSString*)str{
    
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:str preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:nil];
}

-(BOOL)isOK:(NSString *)str{
    
    if (str==nil || [str isEqualToString:@""]) {
        [self showMessage:@"未保存成功"];
        return NO;
    }
    return YES;
}




-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}








@end













