//
//  EditPassWordViewController.m
//  Yi_Fei
//
//  Created by 徐友明 on 16/12/28.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "EditPassWordViewController.h"
#import "UIBarButtonItem+AllWork.h"
#import "DataSecurity.h"
@interface EditPassWordViewController ()


@property (nonatomic,strong) NSString *oldWord;
@property (nonatomic,strong) NSString *neWord;
@property (nonatomic,strong) NSString *tureWord;


@end

@implementation EditPassWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavigationView];
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(inputTextold:) name:UITextFieldTextDidChangeNotification object:self.oldPassWord];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(inputTextnew:) name:UITextFieldTextDidChangeNotification object:self.neWPassWord];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(inputTextture:) name:UITextFieldTextDidChangeNotification object:self.TurePassword];
    
    // Do any additional setup after loading the view from its nib.
}


// xym
- (void)inputTextold:(NSNotification *)obj{
    UITextField *textField = (UITextField *)obj.object;
    self.oldWord = textField.text;
}


- (void)inputTextnew:(NSNotification *)obj{
    UITextField *textField = (UITextField *)obj.object;
    self.neWord = textField.text;
}


- (void)inputTextture:(NSNotification *)obj{
    UITextField *textField = (UITextField *)obj.object;
    self.tureWord = textField.text;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 设置导航条
-(void)createNavigationView
{
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 20)];
    titleLabel.text = @"密码修改";
    titleLabel.font = [UIFont systemFontOfSize:17];
    titleLabel.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = titleLabel;
    
    BackButton *leftBtn = [[BackButton alloc] initWithFrame:CGRectMake(0, 0, 12, 20)];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"fanhui_icon"] forState:UIControlStateNormal];
    UIBarButtonItem * barItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    
    UIBarButtonItem *item = [UIBarButtonItem itemWithImageBJName:@"确认修改" target:self action:@selector(nextClicked)];
    self.navigationItem.rightBarButtonItem = item;
    
    self.navigationItem.leftBarButtonItem = barItem;
    [leftBtn addTarget:self action:@selector(leftButtonClick) forControlEvents:UIControlEventTouchUpInside];
}


-(void)leftButtonClick{
    
    UIAlertController *actro = [UIAlertController alertControllerWithTitle:@"提示" message:@"确认退出密码修改" preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleDefault) handler:nil];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popViewControllerAnimated:YES];

        
    }];
    [actro addAction:action1];
    [actro addAction:action2];
    [self presentViewController:actro animated:YES completion:nil];

    
}



//修改密码
-(void)nextClicked{
    
    UIAlertController *actro = [UIAlertController alertControllerWithTitle:@"提示" message:@"确认密码修改" preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleDefault) handler:nil];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
        
        NSString *str=@"/easyfair-webservice/user/updatePassword";
        NSString *urlStrinx=[NSString stringWithFormat:@"%@%@",Website,str];
        
        //     获取token
        NSUserDefaults *tokenDeful = [NSUserDefaults standardUserDefaults];
        NSString *token = [tokenDeful objectForKey:@"token"];
        
        // 对输入框的文本进行加密
        self.oldWord = [[DataSecurity shareInstance]MD5WithString:self.oldWord];
        
        //全部回复
        NSDictionary  *dicDay=@{
                                @"token": token,
                                @"userType": @"ch",
                                @"oldPassword":self.oldWord,
                                @"newPassword1": self.neWord,
                                @"newPassword2": self.tureWord
                                };
        NSLog(@"%@",dicDay);
        
        [[NetWorkingManager getManager]POST:urlStrinx parameters:dicDay success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            if ([responseObject[@"code"] isEqualToString:@"200"]) {
                
                UIAlertController *actro = [UIAlertController alertControllerWithTitle:@"提示" message: @"密码修改成功" preferredStyle:(UIAlertControllerStyleAlert)];
                [self presentViewController:actro animated:YES completion:nil];

                [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(creatAlerts:) userInfo:actro repeats:NO];
                

                
                
            }else{
                
                UIAlertController *actro = [UIAlertController alertControllerWithTitle:@"提示" message: responseObject[@"message"] preferredStyle:(UIAlertControllerStyleAlert)];
                
                
                [self presentViewController:actro animated:YES completion:nil];
                [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(creatAlerts:) userInfo:actro repeats:NO];
                
            }
            
        }
        failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                        
                                        
             }];

        
        
        
    }];
    [actro addAction:action1];
    [actro addAction:action2];
    [self presentViewController:actro animated:YES completion:nil];
    
    
    
    
    
}



- (void)creatAlerts:(NSTimer *)timer{
    UIAlertController *alert = [timer userInfo];
    [alert dismissViewControllerAnimated:YES completion:nil];
    alert = nil;
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
