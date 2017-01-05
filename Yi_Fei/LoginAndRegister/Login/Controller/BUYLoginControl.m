//
//  BUYLoginControl.m
//  YiFei
//
//  Created by yons on 16/8/26.
//  Copyright © 2016年 yous. All rights reserved.
//

#import "BUYLoginControl.h"
#import "ZMJTotleHomeController.h"
#import "LogonView.h"
#import "DataSecurity.h"

static NSString *isLogin;
@interface BUYLoginControl ()<UITextFieldDelegate>

@property (nonatomic,strong) UIImageView *logoImgView;

@property (nonatomic, strong) UILabel  *versionLabel;

@property (nonatomic, strong) UIButton *loginBtn;

@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *passWord;

@end

@implementation BUYLoginControl

- (void) viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLOR;
    [self setNav];
    //添加最下面版本号
    [self addVersion];
    [self createLogon];
}


-(void)setNav{

    BackButton *btn = [[BackButton alloc] init];
    [btn setImage:[UIImage imageNamed:@"fanhui_icon"] forState:UIControlStateNormal];
    btn.layer.cornerRadius = 15;
    btn.layer.masksToBounds = YES;
    btn.backgroundColor = [UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:0.5];
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.view).offset(10);
        make.top.mas_equalTo(self.view.mas_top).offset(25);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
  [btn addTarget:self action:@selector(leftButtonClick) forControlEvents:UIControlEventTouchUpInside];
}


- (void)leftButtonClick {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 添加版本号
- (void) addVersion
{
    _versionLabel = [[UILabel alloc] init];
    NSString *version = (NSString *)[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    NSString *str = [NSString stringWithFormat:@"V %@",version];
    _versionLabel.text=str;
    _versionLabel.font = [UIFont systemFontOfSize:14];
    _versionLabel.textAlignment = NSTextAlignmentCenter;
    _versionLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:_versionLabel];
    [_versionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-20);
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(40, 20));
    }];
}


#pragma makr - 添加两个按钮去
-(void)createLogon{
    
    _logoImgView = [[UIImageView alloc] init];
    _logoImgView.contentMode = UIViewContentModeCenter;
    _logoImgView.image = [UIImage imageNamed:NSLocalizedString(@"Login", nil)];
    [self.view addSubview:_logoImgView];
    [_logoImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).offset(100);
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
    
    NSArray *arrs = @[NSLocalizedString(@"account", nil),NSLocalizedString(@"password", nil)];
    NSArray *imgs = @[@"zhanghao.png",@"mima.png"];
    LogonView *oneView = [[LogonView alloc] init];
    oneView.logoImage.image = [UIImage imageNamed:imgs[0]];
    oneView.textFiled.placeholder = arrs[0];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(inputTextName:) name:UITextFieldTextDidChangeNotification object:oneView.textFiled];
    oneView.textFiled.delegate = self;
    oneView.textFiled.tag = 8;
    
    //    记住用户名 xym
    if ([isLogin isEqualToString:@"1"]) {
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        NSString *username = [ user objectForKey:@"usname"];
        oneView.textFiled.text = username;
        self.userName = username;
    }
    oneView.textFiled.text = @"904178767@qq.com";
    self.userName = @"904178767@qq.com";
    
    oneView.layer.cornerRadius = 5;
    oneView.layer.masksToBounds = YES;
    oneView.layer.borderWidth = 1.0 ;
    oneView.layer.borderColor = [UIColor whiteColor].CGColor;
    [self.view addSubview:oneView];
    [oneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_logoImgView.mas_bottom).offset(70);
        make.leading.mas_equalTo(self.view).offset(50);
        make.trailing.mas_equalTo(self.view).offset(-50);
        make.height.mas_equalTo(40);
    }];
    
    LogonView *twoView = [[LogonView alloc] init];
    twoView.logoImage.image = [UIImage imageNamed:imgs[1]];
    twoView.textFiled.placeholder = arrs[1];
    
    twoView.textFiled.delegate = self;
    twoView.textFiled.tag = 7;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(inputTextPassword:) name:UITextFieldTextDidChangeNotification object:twoView.textFiled];
    
    
    twoView.layer.cornerRadius = 5;
    twoView.layer.masksToBounds = YES;
    twoView.layer.borderWidth = 1.0 ;
    twoView.layer.borderColor = [UIColor whiteColor].CGColor;
    [self.view addSubview:twoView];
    [twoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(oneView.mas_bottom).offset(25);
        make.leading.mas_equalTo(self.view).offset(50);
        make.trailing.mas_equalTo(self.view).offset(-50);
        make.height.mas_equalTo(40);
    }];
    
    _loginBtn  = [[UIButton alloc] init];
    [_loginBtn setTitle:NSLocalizedString(@"Login", nil) forState:UIControlStateNormal];
    [_loginBtn setTitleColor:BACKCOLOR forState:UIControlStateNormal];
    _loginBtn.layer.cornerRadius = 5;
    _loginBtn.layer.masksToBounds = YES;
    _loginBtn.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_loginBtn];
    [_loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(twoView.mas_bottom).offset(35);
        make.leading.mas_equalTo(self.view).offset(50);
        make.trailing.mas_equalTo(self.view).offset(-50);
        make.height.mas_equalTo(40);
    }];
    [_loginBtn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
}



- (void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = NO;
}


//账号
- (void)inputTextName:(NSNotification *)obj{
    UITextField *textField = (UITextField *)obj.object;
    self.userName = textField.text;
    
}
//密码
- (void)inputTextPassword:(NSNotification *)obj{
    UITextField *textField = (UITextField *)obj.object;
    self.passWord = textField.text;
    
}





//登录按钮事件xym
- (void)btnClick
{
    
    if (self.passWord.length != 0) {
        // 对输入框的文本进行加密
        self.passWord = [[DataSecurity shareInstance]MD5WithString:self.passWord];
        // 将加密之后的字符串 显示在输入框内
        NSLog(@"%@",self.passWord);
    }
    if (self.passWord.length == 0) {
        self.passWord = @"";
    }
    if (self.userName.length == 0) {
        self.userName = @"";
    }
    
    NSString *str=@"/easyfair-webservice/user/login";
    NSString *urlStrinx=[NSString stringWithFormat:@"%@%@",Website,str];
    
    
    //全部回复
    NSDictionary  *dicDay=@{
                            @"username": self.userName,
                            @"password": self.passWord
                            };
    
    NSLog(@"%@",dicDay);
    
    [[NetWorkingManager getManager]POST:urlStrinx parameters:dicDay success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        NSLog(@"%@",responseObject);
        
        if ([responseObject[@"code"]isEqualToString:@"200"]) {
            
            NSString *token = responseObject[@"token"];
            //存储 token 唯一标识别
            [[NSUserDefaults standardUserDefaults]setObject:token forKey:@"token"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
            //存储  用户名
            NSString *usname = self.userName;
            //存储 token 唯一标识别
            [[NSUserDefaults standardUserDefaults]setObject:usname forKey:@"usname"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
            isLogin = @"1";
            
            ZMJTotleHomeController *vc = [[ZMJTotleHomeController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            
            
            
            
        }else{
            isLogin = @"2";
            
            UIAlertController *actro = [UIAlertController alertControllerWithTitle:@"提示" message:responseObject[@"message"] preferredStyle:(UIAlertControllerStyleAlert)];
            UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleDefault) handler:nil];
            UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:nil];
            [actro addAction:action1];
            [actro addAction:action2];
            [self presentViewController:actro animated:YES completion:nil];
        }
        
        
        
        
    }
                                failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                    
                                    
                                    
                                }];
    
    
    
    
    
    
}






















@end





