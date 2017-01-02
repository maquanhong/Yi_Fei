//
//  BUYRegisterControl.m
//  YiFei
//
//  Created by yons on 16/8/26.
//  Copyright © 2016年 yous. All rights reserved.
//

#import "BUYRegisterControl.h"
#import "BUYTypeView.h"
#import "BUYAgreementController.h"
#import "BUYLoginControl.h"
#import "BUYButton.h"
#import "IndustryModel.h"
#import "AcceptView.h"



@interface BUYRegisterControl () <UITextFieldDelegate,BUYTypeViewDelegate,SSPopupDelegate,AcceptViewDelegate>
{
    UITextField *_textOne;
    UITextField *_textTwo;
    UITextField *_textThree;
    UIButton *_getBtn;
    UIView *_viewOne;
    NSInteger _indexOne;
    NSInteger _indexTwo;
    AcceptView  *_tapView;
}
@property (nonatomic,strong)NSMutableArray *arrs;
@property (nonatomic,strong)BUYTypeView *nextView;
@property (nonatomic,strong)IndustryModel *industryModel;

@end

@implementation BUYRegisterControl

- (void) viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =INTERFACECOLOR;
    //输入框
    [self createNavigationView];
    [self createTextFiled];
    [self createtypeView];
 
}

#pragma mark 创建navgationView
-(void)createNavigationView
{
    self.navigationItem.title = NSLocalizedString(@"registered", nil);
    BackButton *leftBtn = [[BackButton alloc] initWithFrame:CGRectMake(0, 0, 12, 20)];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"fanhui_icon"] forState:UIControlStateNormal];
    UIBarButtonItem * barItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = barItem;
    [leftBtn addTarget:self action:@selector(leftButtonClick) forControlEvents:UIControlEventTouchUpInside];
}

-(void)leftButtonClick{
    [self.navigationController popViewControllerAnimated:YES];
}



#pragma mark 创建输入框
-(void)createTextFiled{
    
    UIView *view =[[UIView alloc] init];
    view.layer.borderWidth = 1.0;
    view.layer.borderColor = [UIColor lightGrayColor].CGColor;
    view.layer.cornerRadius = 5;
    view.layer.masksToBounds = YES;
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.view).offset(30);
        make.trailing.mas_equalTo(self.view).offset(-30);
        make.top.mas_equalTo(self.view.mas_top).offset(84);
        make.height.mas_equalTo(35);
    }];

    _textOne =[[UITextField alloc] init];
    _textOne.placeholder = NSLocalizedString(@"phone", nil);
    _textOne.font = [UIFont systemFontOfSize:14];
    [view addSubview:_textOne];
    [_textOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(view).offset(5);
        make.trailing.equalTo(view);
        make.centerY.mas_equalTo(view.mas_centerY);
        make.height.mas_equalTo(35);
    }];
    
    UIView *backView = [[UIView alloc] init];
    backView.layer.borderWidth = 1.0;
    backView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    backView.layer.cornerRadius = 5;
    backView.layer.masksToBounds = YES;
    [self.view addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.view).offset(30);
        make.trailing.mas_equalTo(self.view).offset(-30);
        make.top.mas_equalTo(_textOne.mas_bottom).offset(20);
        make.height.mas_equalTo(35);
    }];
    

    _textTwo =[[UITextField alloc] init];
    _textTwo.placeholder =NSLocalizedString(@"Verification", nil);
    _textTwo.font = [UIFont systemFontOfSize:14];
    [backView addSubview:_textTwo];

    
    _getBtn  =[[UIButton alloc] init];
    [_getBtn setTitle:NSLocalizedString(@"getpassword", nil) forState:UIControlStateNormal];
    [_getBtn setTitleColor:BACKCOLOR forState:UIControlStateNormal];
    _getBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    _getBtn.layer.borderWidth = 1.0;
    _getBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [backView addSubview:_getBtn];
    [_getBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(backView);
        make.centerY.equalTo(backView);
        make.size.mas_equalTo(CGSizeMake(100, 35));
    }];



    [_textTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(backView).offset(5);
        make.centerY.equalTo(backView);
        make.height.mas_equalTo(35);
        make.right.mas_equalTo(_getBtn.mas_left);
    }];
    
    
    _viewOne =[[UIView alloc] init];
    _viewOne.layer.borderWidth = 1.0;
    _viewOne.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _viewOne.layer.cornerRadius = 5;
    _viewOne.layer.masksToBounds = YES;
    [self.view addSubview:_viewOne];
    [_viewOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.view).offset(30);
        make.trailing.mas_equalTo(self.view).offset(-30);
        make.top.mas_equalTo(backView.mas_bottom).offset(20);
        make.height.mas_equalTo(35);
    }];
    
    _textThree =[[UITextField alloc] init];
    _textThree.placeholder = NSLocalizedString(@"Pleasepassword", nil);
    _textThree.font = [UIFont systemFontOfSize:14];
    [_viewOne addSubview:_textThree];
    [_textThree mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(_viewOne).offset(5);
        make.trailing.equalTo(_viewOne);
        make.centerY.mas_equalTo(_viewOne.mas_centerY);
        make.height.mas_equalTo(35);
    }];
}

#pragma mark 创建行业类型
-(void)createtypeView{

    _nextView  = [[BUYTypeView alloc] init];
    _nextView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _nextView.layer.borderWidth  = 1.0;
    _nextView.layer.cornerRadius = 8;
    _nextView.layer.masksToBounds = YES;
    _nextView.delegate = self;
    [self.view addSubview:_nextView];
    [_nextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.view).offset(30);
        make.trailing.mas_equalTo(self.view).offset(-30);
        make.top.mas_equalTo(_viewOne.mas_bottom).offset(20);
        make.height.mas_equalTo(100);
    }];
    
    
    _tapView  = [[AcceptView alloc] init];
    _tapView.userInteractionEnabled = YES;
    _tapView.delegate = self;
    [self.view addSubview:_tapView];
    [_tapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(_nextView).offset(15);
        make.trailing.mas_equalTo(_nextView).offset(15);
        make.top.mas_equalTo(_nextView.mas_bottom).offset(20);
        make.height.mas_equalTo(30);
    }];
    
    
    UIButton *btn = [[UIButton alloc] init];
    btn.backgroundColor = BACKCOLOR;
    [btn setTitle:NSLocalizedString(@"registered", nil) forState:UIControlStateNormal];
    btn.layer.cornerRadius = 5;
    btn.layer.masksToBounds = YES;
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.view).offset(50);
        make.trailing.mas_equalTo(self.view).offset(-50);
        make.top.mas_equalTo(_tapView.mas_bottom).offset(30);
        make.height.mas_equalTo(40);
    }];
    
[btn addTarget:self action:@selector(clickBtn) forControlEvents:UIControlEventTouchUpInside];
    
}


-(void)clickBtn{




}



- (void)clickView:(UIButton *)btn{
    btn.selected = !btn.selected;
}





#pragma mark 三级联动
- (void)clickViewTag:(NSInteger)tag{
    switch (tag) {
        case 1465:
        {
    _industryModel = [[IndustryModel alloc] init];
    NSMutableArray *array = [_industryModel   getAllIndustry];
    [self getAllIndestry:[array copy]];
        
        }
            break;
        case 1466:
        {
        _industryModel = [[IndustryModel alloc] init];
        NSMutableArray *array = [_industryModel getIndustryTwo:_indexOne];
        [self getIndestry:[array copy]];
            
        }
            break;
        case 1467:
        {
    _industryModel = [[IndustryModel alloc] init];
    NSMutableArray *array = [_industryModel getIndustryNumber:_indexOne threeNumber:_indexTwo];
    [self getThreeIndestry:[array copy]];

        }
            break;
        default:
            break;
    }
}

//得到全部
-(void)getAllIndestry:(NSArray*)array{
    
    SSPopup* selection=[[SSPopup alloc]init];
    selection.backgroundColor=[UIColor colorWithWhite:0.00 alpha:1.0];
    selection.index = array.count;
    selection.frame = CGRectMake(0,84,self.view.frame.size.width,self.view.frame.size.height - 84 );
    selection.SSPopupDelegate=self;
    [self.view  addSubview:selection];
    [selection CreateTableview:array withSender:nil  withTitle:nil setCompletionBlock:^(int tag){
        _indexOne = tag;
        if ([array[tag] length] > 0) {
           _nextView.typeOne.titleLabel.text = array[tag];
        }else{
           _nextView.typeOne.titleLabel.text = @"";
        }
        
        _industryModel = [[IndustryModel alloc] init];
        NSString *str = [_industryModel getAllIndustry:_indexOne ];
        if ([str length] > 0) {
            _nextView.typeTwo.titleLabel.text = str;
            _nextView.typeTwo.userInteractionEnabled = YES;
        }else{
            _nextView.typeTwo.titleLabel.text = @"";
            _nextView.typeTwo.userInteractionEnabled = NO;
        }
        
        _industryModel = [[IndustryModel alloc] init];
        NSString *strOne = [_industryModel getAllIndustryTwo:_indexOne ];
        if ([strOne length] > 0) {
            _nextView.typeThree.titleLabel.text = strOne;
            _nextView.typeThree.userInteractionEnabled = YES;
        }else{
            _nextView.typeThree.titleLabel.text = @"";
            _nextView.typeThree.userInteractionEnabled = NO;
        }
    }];
}


-(void)getIndestry:(NSArray*)array{
    
    SSPopup* selection=[[SSPopup alloc]init];
    selection.backgroundColor=[UIColor colorWithWhite:0.00 alpha:1.0];
    selection.index = array.count;
    selection.frame = CGRectMake(0,84,self.view.frame.size.width,self.view.frame.size.height - 84 );
    selection.SSPopupDelegate=self;
    [self.view  addSubview:selection];
    [selection CreateTableview:array withSender:nil  withTitle:nil setCompletionBlock:^(int tag){
        _indexTwo = tag;
        if ([array[tag] length] > 0) {
            _nextView.typeTwo.titleLabel.text = array[tag];
        }else{
              _nextView.typeTwo.titleLabel.text = @"";
        }
        _industryModel = [[IndustryModel alloc] init];
        NSString *strOne = [_industryModel getIndustryTwo:_indexOne threeNumber:_indexTwo];
        if ([strOne length] > 0) {
            _nextView.typeThree.titleLabel.text = strOne;
        }else{
           _nextView.typeThree.titleLabel.text = @"";
        }
    }];
}



-(void)getThreeIndestry:(NSArray*)array{
    
    SSPopup* selection=[[SSPopup alloc]init];
    selection.backgroundColor=[UIColor colorWithWhite:0.00 alpha:1.0];
    selection.index = array.count;
    selection.frame = CGRectMake(0,84,self.view.frame.size.width,self.view.frame.size.height - 84 );
    selection.SSPopupDelegate=self;
    [self.view  addSubview:selection];
    [selection CreateTableview:array withSender:nil  withTitle:nil setCompletionBlock:^(int tag){
        _indexTwo = tag;
        if ([array[tag] length] > 0) {
            _nextView.typeThree.titleLabel.text = array[tag];
        }else{
             _nextView.typeThree.titleLabel.text = @"";
        }
    }];
}
































@end







