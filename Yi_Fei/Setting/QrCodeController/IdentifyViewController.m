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

@interface IdentifyViewController ()
@property (nonatomic, strong) UIView *bgImageView;
@property (nonatomic, strong) UIView  *bgView;
@property (nonatomic, strong) UIImage  *navBackgroundImage;
@property (nonatomic, strong) UIImageView * headimageVIew;
@end

@implementation IdentifyViewController

- (void)setNav {
    
    UIButton* leftBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    
    [leftBtn setImage:[UIImage imageNamed:@"fanhui_icon"] forState:UIControlStateNormal];
    leftBtn.frame = CGRectMake(0, 0, 25, 25);
    UIBarButtonItem* leftBtnItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    
    [leftBtn addTarget:self action:@selector(leftButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem=leftBtnItem;
}

- (void)leftButtonClick {
    
    [self.navigationController.navigationBar setBackgroundImage:self.navBackgroundImage forBarMetrics:UIBarMetricsDefault];
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNav];
    self.title = @"我的二维码";
    self.navBackgroundImage = [self.navigationController.navigationBar backgroundImageForBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    _bgImageView = [[UIView alloc] initForAutoLayout];
    _bgImageView.backgroundColor = UIColorFromRGB(0x4fc2f9);
    [self.view addSubview:self.bgImageView];
    [self addViewConstraints];
    [self createQrCodeImage];
    
    UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    saveBtn.backgroundColor = BACKCOLOR;
    saveBtn.layer.cornerRadius = 10;
    [saveBtn setTitle:@"保存二维码" forState:UIControlStateNormal];
    [saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_bgImageView addSubview:saveBtn];
    [saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-50);
        make.centerX.equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(WIDTH - 100 , 50));
    }];
    [saveBtn addTarget:self action:@selector(saveImageView) forControlEvents:UIControlEventTouchUpInside];
}

- (void)addViewConstraints {
    
    [self.bgImageView autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [self.bgImageView autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    [self.bgImageView autoPinEdgeToSuperviewEdge:ALEdgeLeading];
    [self.bgImageView autoPinEdgeToSuperviewEdge:ALEdgeTrailing];

}


-(void)createQrCodeImage{
    
    _bgView = [[UIView alloc] init];
    _bgView.backgroundColor = [UIColor whiteColor];
    [_bgImageView addSubview:_bgView];
    [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.center.equalTo(_bgImageView);
    make.size.mas_equalTo(CGSizeMake(WIDTH - 30, WIDTH - 30));
    }];
    
    _headimageVIew = [[UIImageView alloc] init];
    [_bgView addSubview:_headimageVIew];
    [_headimageVIew mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(_bgView);
        make.size.mas_equalTo(CGSizeMake(WIDTH - 60 ,WIDTH - 60));
    }];

    NSString *cardName = @"易非";
    UIImage *avatar = [UIImage imageNamed:@"erwei"];
    [HMScannerController cardImageWithCardName:cardName avatar:avatar scale:0.2 completion:^(UIImage *image) {
        _headimageVIew.image = image;
    }];
}

-(void)saveImageView{
    if (self.headimageVIew.image) {
UIImageWriteToSavedPhotosAlbum(self.headimageVIew.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
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
























@end













