//
//  BUYLoginControl.m
//  YiFei
//
//  Created by yons on 16/8/26.
//  Copyright © 2016年 yous. All rights reserved.
//

#import "BUYLoginControl.h"
#import "BUYImportView.h"
#import "ZMJTotleHomeController.h"
#import "BUYButton.h"
#import "PureLayout.h"

@interface BUYLoginControl ()

@property (nonatomic,strong) UIImageView *logoImgView;
@property (nonatomic, strong) UILabel  *versionLabel;
@property (nonatomic,strong) NSMutableArray *btns;
@property (nonatomic, strong) BUYButton *loginBtn;
@end

@implementation BUYLoginControl

-(NSMutableArray *)btns
{
    if (!_btns) {
        _btns = [NSMutableArray array];
    }
    return _btns;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = COLOR;
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    //添加控件1
    [self addLogo];
    
    //添加控件2
    [self addBtn];
    
    //添加登录按钮
    [self addLoginBtn];
    
    //添加最下面版本号
    [self addVersion];
    [self addViewConstraints];
}

- (void)addViewConstraints {
    [self.logoImgView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:120];
    [self.logoImgView autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:50];
    [self.logoImgView autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:50];
    UIImage *logoImage = [UIImage imageNamed:@"logo.png"];
    [self.logoImgView autoSetDimension:ALDimensionHeight toSize:logoImage.size.height];
    
    BUYImportView *import = [self.btns firstObject];
    [import autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.logoImgView withOffset:50];
    [import autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:20];
    [import autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:20];
    
    [import autoSetDimension:ALDimensionHeight toSize:40];
    BUYImportView *import2 = [self.btns lastObject];
    
    [import2 autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:import withOffset:6];
    [import2 autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:20];
    [import2 autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:20];
    [import2 autoSetDimension:ALDimensionHeight toSize:30];
    
    [self.loginBtn autoPinEdge:ALEdgeLeading toEdge:ALEdgeLeading ofView:import2];
    [self.loginBtn autoPinEdge:ALEdgeTrailing toEdge:ALEdgeTrailing ofView:import2];
    [self.loginBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:import2 withOffset:40];
    [self.loginBtn autoSetDimension:ALDimensionHeight toSize:40];
    
    [self.versionLabel autoPinEdgeToSuperviewEdge:ALEdgeLeading];
    [self.versionLabel autoPinEdgeToSuperviewEdge:ALEdgeTrailing];
    [self.versionLabel autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:5];
    [self.versionLabel autoSetDimension:ALDimensionHeight toSize:20];
}

- (void) viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

#pragma mark - 添加logo
- (void)addLogo
{
    UIImageView *img = [[UIImageView alloc] initForAutoLayout];
    _logoImgView = img;
    img.contentMode = UIViewContentModeCenter;
    UIImage *logoImage = [UIImage imageNamed:@"logo.png"];
    img.image = logoImage;
    [self.view addSubview:img];
}

#pragma makr - 添加两个按钮去
- (void)addBtn
{
    NSArray *arrs = @[@"请输入邮箱账号",@"请输入密码"];
    NSArray *imgs = @[@"zhanghao.png",@"mima.png"];
    for (int i = 0; i < 2; i++) {
        NSString *str = arrs[i];
        NSString *img = imgs[i];
        BUYImportView *import = [BUYImportView creatImportViewWithStr:str flag:NO leftImg:img];
        import.field.textColor = [UIColor whiteColor];
        if (i == 1) {
            import.field.secureTextEntry = YES;
        }
        import.field.attributedPlaceholder = [[NSAttributedString alloc] initWithString:str attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
        import.borderColor = [UIColor whiteColor];
        [self.btns addObject:import];
        [self.view addSubview:import];
    }
}

#pragma mark - 添加登录按钮
- (void)addLoginBtn
{
    BUYButton *btn = [BUYButton creatBtnWithBgColor:[UIColor whiteColor] borderColor:nil borderWidth:0 titleColor:COLOR text:@"登录"];
    _loginBtn = btn;
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}


#pragma mark - 添加版本号
- (void) addVersion
{
    UILabel *label = [[UILabel alloc] initForAutoLayout];
    NSString *version = (NSString *)[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    NSString *str = [NSString stringWithFormat:@"V %@",version];
    label.text=str;
    label.font = [UIFont systemFontOfSize:11];
    label.textAlignment = NSTextAlignmentCenter;
    _versionLabel = label;
    label.textColor = [UIColor whiteColor];
    [self.view addSubview:label];
}


- (void)btnClick
{
    NSLog(@"登录");
    ZMJTotleHomeController *vc = [[ZMJTotleHomeController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

@end
