//
//  PulishOneViewController.m
//  Yi_Fei
//
//  Created by yons on 16/11/17.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "PulishOneViewController.h"
#import "SearchView.h"
#import "BuyCustomerView.h"
#import "GDataXMLNode.h"

@interface PulishOneViewController ()<SSPopupDelegate>
{
    NSInteger _index;
    NSInteger _number;
}
#pragma mark 类型坐标
@property (nonatomic,strong) UIButton  *addBtn;   //添加按钮
@property (nonatomic,strong) SearchView  *searchView; //搜索框
@property (nonatomic,strong) UIView  *backView;      //背景图片
@property (nonatomic,strong) UIButton  *certainBtn;  //发布按钮
@property (nonatomic,strong) UILabel  *chooseLabel;
@property (nonatomic,strong) UILabel  *typeLabel;
@property (nonatomic,strong) UILabel  *productLabel;
@property (nonatomic,strong) UILabel  *priceLabel;
@property (nonatomic,strong) UILabel  *infoLabel;
@property (nonatomic,strong) UILabel  *publishLabel;

#pragma mark 输入框
@property (nonatomic,strong) BuyCustomerView  *chooseBuyerView; //选择采购商
@property (nonatomic,strong) BuyCustomerView  *industryOneView; //行业类型
@property (nonatomic,strong) BuyCustomerView  *industryTwoView; //行业类型
@property (nonatomic,strong) BuyCustomerView  *industryThreeView; //行业类型
@property (nonatomic,strong) BuyCustomerView  *industryFourView; //行业类型
@property (nonatomic,strong) BuyCustomerView  *chooseProductView; //商品选择
@property (nonatomic,strong) UITextField  *onePrice;
@property (nonatomic,strong) UITextField  *twoPrice;
@property (nonatomic,strong) UITextView  *textView;

@property (nonatomic,strong) BuyCustomerView  *pulishTypeView;

//行业类型数组
@property (nonatomic,strong) NSMutableArray *oneTypeArray;
@property (nonatomic,strong) NSMutableArray *twoTypeArray;
@property (nonatomic,strong) NSMutableArray *threeTypeArray;

@property (nonatomic,strong) NSArray *elementArray;
@property (nonatomic,strong) GDataXMLNode *twoNode;


@end



@implementation PulishOneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self AnalysisData];
    [self createSearchView];
    
}


#pragma mark 布局界面
-(void)createSearchView{
    
    NSInteger height ;
    NSInteger width;
    NSInteger singleWidth;
    if (WIDTH == 375) {
        height = 10;
        width = 30;
        singleWidth = 25;
    }else if (WIDTH == 414){
        height = 15;
        width = 45;
        singleWidth = 40;
    }else{
        height = 0;
        width = 0;
        singleWidth = 0;
    }
    
    _searchView = [[SearchView alloc] init];
    _searchView.backgroundColor = [UIColor whiteColor];
    _searchView.layer.cornerRadius = 8;
    [self.view addSubview:_searchView];
    [_searchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).offset(15);
        make.leading.mas_equalTo(self.view).offset(15);
        make.trailing.mas_equalTo(self.view).offset(-60);
        make.height.mas_equalTo(30);
    }];
    
    _addBtn = [[UIButton alloc] init];
    [_addBtn setTitle:@"添加" forState:UIControlStateNormal];
    _addBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [_addBtn setTitleColor:COLOR forState:UIControlStateNormal];
    [self.view addSubview:_addBtn];
    [_addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(self.view).offset(-10);
        make.centerY.mas_equalTo(_searchView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(40, 20));
    }];
    
    _backView = [[UIView alloc] init];
    _backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_backView];
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_searchView.mas_bottom).offset(15);
        make.leading.mas_equalTo(self.view);
        make.trailing.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view.mas_bottom);
    }];
    
    _chooseLabel = [[UILabel alloc] init];
    _chooseLabel.font = [UIFont systemFontOfSize:14];
    _chooseLabel.text = @"选择采购商";
    [_backView addSubview:_chooseLabel];
    [_chooseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(_backView).offset(10);
        make.top.mas_equalTo(_backView.mas_top).offset(20);
        make.size.mas_equalTo(CGSizeMake(70, 20));
    }];
    
    
    _chooseBuyerView = [[BuyCustomerView alloc] init];
    _chooseBuyerView.layer.borderWidth = 1.0;
    _chooseBuyerView.layer.borderColor = COLOR.CGColor;
    _chooseBuyerView.layer.cornerRadius = 8;
    [_backView addSubview:_chooseBuyerView];
    [_chooseBuyerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_chooseLabel.mas_centerY);
        make.left.mas_equalTo(_chooseLabel.mas_right).offset(10);
        make.trailing.mas_equalTo(_backView).offset(-10);
        make.height.mas_equalTo(30);
    }];
    
    _typeLabel = [[UILabel alloc] init];
    _typeLabel.text = @"行业类型";
    _typeLabel.font = [UIFont systemFontOfSize:14];
    [_backView addSubview:_typeLabel];
    [_typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(_chooseLabel);
        make.top.mas_equalTo(_chooseLabel.mas_bottom).offset(20 + height);
        make.size.mas_equalTo(CGSizeMake(70, 20));
    }];
    
    _industryOneView = [[BuyCustomerView alloc] init];;
    _industryOneView.layer.borderWidth = 1.0;
    _industryOneView.nameLabel.text = @"大型机械及设备";
    _industryOneView.layer.borderColor = COLOR.CGColor;
    _industryOneView.layer.cornerRadius = 5;
    [_backView addSubview:_industryOneView];
    [_industryOneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_typeLabel.mas_centerY);
        make.left.mas_equalTo(_typeLabel.mas_right).offset(10);
        make.size.mas_equalTo(CGSizeMake(110 + singleWidth, 30));
    }];
    _industryOneView.tag = 18000;
    UITapGestureRecognizer *tapOne = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickView:)];
    [_industryOneView addGestureRecognizer:tapOne];
    
    _industryTwoView = [[BuyCustomerView alloc] init];;
    _industryTwoView.layer.borderWidth = 1.0;
    _industryTwoView.nameLabel.text = @"动力、电力设备";
    _industryTwoView.layer.borderColor = COLOR.CGColor;
    _industryTwoView.layer.cornerRadius = 5;
    [_backView addSubview:_industryTwoView];
    [_industryTwoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_typeLabel.mas_centerY);
        make.trailing.mas_equalTo(_backView).offset(-10);
        make.size.mas_equalTo(CGSizeMake(100 + singleWidth, 30));
    }];
    _industryTwoView.tag = 18001;
    UITapGestureRecognizer *tapTwo = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickView:)];
    [_industryTwoView addGestureRecognizer:tapTwo];
    
    _industryThreeView = [[BuyCustomerView alloc] init];;
    _industryThreeView.layer.borderWidth = 1.0;
    _industryThreeView.nameLabel.text = @"动力设备";
    _industryThreeView.layer.borderColor = COLOR.CGColor;
    _industryThreeView.layer.cornerRadius = 5;
    [_backView addSubview:_industryThreeView];
    [_industryThreeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_industryOneView.mas_bottom).offset(10);
        make.leading.mas_equalTo(_industryOneView);
        make.size.mas_equalTo(CGSizeMake(110 + singleWidth, 30));
    }];
    _industryThreeView.tag = 18002;
    UITapGestureRecognizer *tapThree = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickView:)];
    [_industryThreeView addGestureRecognizer:tapThree];
    
    _industryFourView = [[BuyCustomerView alloc] init];;
    _industryFourView.layer.borderWidth = 1.0;
    _industryFourView.layer.borderColor = COLOR.CGColor;
    _industryFourView.layer.cornerRadius = 5;
    [_backView addSubview:_industryFourView];
    [_industryFourView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_industryThreeView.mas_centerY);
        make.trailing.mas_equalTo(_backView).offset(-10);
        make.size.mas_equalTo(CGSizeMake(100 + singleWidth, 30));
    }];
    _industryFourView.tag = 18003;
    UITapGestureRecognizer *tapFour = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickView:)];
    [_industryFourView addGestureRecognizer:tapFour];
    
    _productLabel = [[UILabel alloc] init];
    _productLabel.font = [UIFont systemFontOfSize:14];
    _productLabel.text = @"商品选择";
    [_backView addSubview:_productLabel];
    [_productLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(_typeLabel);
        make.top.mas_equalTo(_typeLabel.mas_bottom).offset(60 + height );
        make.size.mas_equalTo(CGSizeMake(70, 20));
    }];
    
    _chooseProductView = [[BuyCustomerView alloc] init];
    _chooseProductView.layer.borderWidth = 1.0;
    _chooseProductView.layer.borderColor = COLOR.CGColor;
    _chooseProductView.layer.cornerRadius = 8;
    [_backView addSubview:_chooseProductView];
    [_chooseProductView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_productLabel.mas_centerY);
        make.left.mas_equalTo(_productLabel.mas_right).offset(10);
        make.trailing.mas_equalTo(_backView).offset(-10);
        make.height.mas_equalTo(30);
    }];
    
    
    _priceLabel = [[UILabel alloc] init];
    _priceLabel.font = [UIFont systemFontOfSize:14];
    _priceLabel.text = @"价格区间";
    [_backView addSubview:_priceLabel];
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(_productLabel);
        make.top.mas_equalTo(_productLabel.mas_bottom).offset(25+ height);
        make.size.mas_equalTo(CGSizeMake(70, 20));
    }];
    
    
    _onePrice = [[UITextField alloc] init];
    _onePrice.layer.borderWidth = 1.0;
    _onePrice.layer.borderColor = COLOR.CGColor;
    _onePrice.layer.cornerRadius = 5;
    [_backView addSubview:_onePrice];
    [_onePrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_priceLabel.mas_centerY);
        make.leading.mas_equalTo(_chooseBuyerView);
        make.size.mas_equalTo(CGSizeMake(100 + width, 30));
    }];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = COLOR;
    [_backView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_onePrice.mas_centerY);
        make.left.mas_equalTo(_onePrice.mas_right).offset(3);
        make.size.mas_equalTo(CGSizeMake(10, 1));
    }];
    
    _twoPrice = [[UITextField alloc] init];
    _twoPrice.layer.borderWidth = 1.0;
    _twoPrice.layer.borderColor = COLOR.CGColor;
    _twoPrice.layer.cornerRadius = 5;
    [_backView addSubview:_twoPrice];
    [_twoPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_onePrice.mas_centerY);
        make.left.mas_equalTo(lineView.mas_right).offset(3);
        make.trailing.mas_equalTo(_backView).offset(-10);
        make.height.mas_equalTo(30);
        
    }];
    
    _infoLabel = [[UILabel alloc] init];
    _infoLabel.font = [UIFont systemFontOfSize:14];
    _infoLabel.text = @"商品简介";
    [_backView addSubview:_infoLabel];
    [_infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(_priceLabel);
        make.top.mas_equalTo(_priceLabel.mas_bottom).offset(25 + height );
        make.size.mas_equalTo(CGSizeMake(70, 20));
    }];
    
    _textView = [[UITextView alloc] init];
    _textView.layer.borderWidth = 1.0;
    _textView.layer.borderColor = COLOR.CGColor;
    _textView.layer.cornerRadius = 5;
    [_backView addSubview:_textView];
    [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(_onePrice);
        make.top.mas_equalTo(_infoLabel.mas_top).offset(-5);
        make.trailing.mas_equalTo(_backView).offset(-10);
        make.height.mas_equalTo(70);
    }];
    
    
    _publishLabel = [[UILabel alloc] init];
    _publishLabel.font = [UIFont systemFontOfSize:14];
    _publishLabel.text = @"发布方式";
    [_backView addSubview:_publishLabel];
    [_publishLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(_infoLabel);
        make.top.mas_equalTo(_infoLabel.mas_bottom).offset(60 + height );
        make.size.mas_equalTo(CGSizeMake(70, 20));
    }];
    
    _pulishTypeView = [[BuyCustomerView alloc] init];
    _pulishTypeView.layer.borderWidth = 1.0;
    _pulishTypeView.layer.borderColor = COLOR.CGColor;
    _pulishTypeView.layer.cornerRadius = 8;
    [_backView addSubview:_pulishTypeView];
    [_pulishTypeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_publishLabel.mas_centerY);
        make.left.mas_equalTo(_publishLabel.mas_right).offset(10);
        make.trailing.mas_equalTo(_backView).offset(-10);
        make.height.mas_equalTo(30);
    }];
    
    _certainBtn = [[UIButton alloc] init];
    [_certainBtn setTitle:@"确认并发布" forState:UIControlStateNormal];
    _certainBtn.layer.cornerRadius = 5;
    _certainBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    _certainBtn.backgroundColor = COLOR;
    [self.view addSubview:_certainBtn];
    [_certainBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.view).offset(50);
        make.height.mas_equalTo(40);
        make.trailing.mas_equalTo(self.view).offset(-50);
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-(20 + height) );
    }];
    
}


-(void)AnalysisData{
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"industry" ofType:@"txt"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    
    //创建XmlDocument对象 并初始化
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:data error:nil];
    //获取根节点
    GDataXMLElement *rootElement = [doc rootElement];
    _elementArray= [rootElement children];
    _oneTypeArray = [NSMutableArray array];
    _twoTypeArray = [NSMutableArray array];
    _threeTypeArray = [NSMutableArray array];
    for (NSInteger i = 0 ; i < _elementArray.count; i++) {
        GDataXMLElement *oneElement = [_elementArray objectAtIndex:i];
        GDataXMLNode *oneNode = [oneElement attributeForName:@"Name"];
        [_oneTypeArray addObject:[oneNode stringValue]];
        //进行第二轮解析
        NSMutableArray *twoArray = [NSMutableArray array];
        if ([oneElement children].count != 0) {
            NSArray *two = [oneElement children];
            for (NSInteger j = 0; j < two.count; j++) {
                
                GDataXMLElement *twoElement = [two objectAtIndex:j];
                GDataXMLNode *twoNode = [twoElement attributeForName:@"Name"];
                [twoArray addObject:[twoNode stringValue]];
                
                NSMutableArray *threeArray = [NSMutableArray array];
                if ([twoElement children].count != 0) {
                    NSArray *three = [twoElement children];
                    for (NSInteger n = 0; n < three.count; n++) {
                        GDataXMLElement *threeElement = [three objectAtIndex:n];
                        GDataXMLNode *threeNode = [threeElement attributeForName:@"Name"];
                        [threeArray addObject:[threeNode stringValue]];
                    }
                    [_threeTypeArray addObject:threeArray];
                }else{
                    [threeArray addObject:[NSNull null]];
                    [_threeTypeArray addObject:threeArray];
                }
            }
            [_twoTypeArray addObject:twoArray];
        }else{
            [twoArray addObject:[NSNull null]];
            [_twoTypeArray addObject:twoArray];
        }
    }
}


-(void)clickView:(id)sender
{
    UITapGestureRecognizer * singleTap = (UITapGestureRecognizer *)sender;
    NSInteger index = [singleTap view].tag;
    
    switch (index) {
        case 18000:
        {
            SSPopup* selection=[[SSPopup alloc]init];
            selection.backgroundColor=[UIColor colorWithWhite:0.00 alpha:1.0];
            selection.index = _oneTypeArray.count;
            selection.frame = CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height);
            selection.SSPopupDelegate=self;
            [self.view  addSubview:selection];
            [selection CreateTableview:_oneTypeArray withSender:nil  withTitle:nil setCompletionBlock:^(int tag){
                _industryOneView.nameLabel.text = _oneTypeArray[tag];
                _index = tag;
                NSString *twoStr = _twoTypeArray[_index][0];
                if (![twoStr isKindOfClass:[NSNull class]]) {
                    _industryTwoView.nameLabel.text = twoStr;
                }else{
                    _industryTwoView.nameLabel.text = @"";
                }
                
                NSString *threeStr = _threeTypeArray[_index][0];
                if (![threeStr isKindOfClass:[NSNull class]]) {
                    _industryThreeView.nameLabel.text = threeStr;
                }else{
                    _industryThreeView.nameLabel.text = @"";
                }
            }];
        }
            break;
        case 18001:
        {
            SSPopup* selection=[[SSPopup alloc]init];
            selection.backgroundColor=[UIColor colorWithWhite:0.00 alpha:1.0];
            for (NSString *str  in _twoTypeArray[_index]) {
                if (![str isKindOfClass:[NSNull class]]) {
                    selection.index = [_twoTypeArray[_index] count];
                }
            }
            selection.frame = CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height);
            selection.SSPopupDelegate=self;
            [self.view  addSubview:selection];
            [selection CreateTableview:_twoTypeArray[_index] withSender:nil  withTitle:nil setCompletionBlock:^(int tag){
                _industryTwoView.nameLabel.text = _twoTypeArray[_index][tag];
                _number = tag;
                NSString *threeStr = _threeTypeArray[tag][0];
                if (![threeStr isKindOfClass:[NSNull class]]) {
                    _industryThreeView.nameLabel.text = threeStr;
                }else{
                    _industryThreeView.nameLabel.text = @"";
                }
            }];
        }
            break;
        case 18002:
        {
            SSPopup* selection=[[SSPopup alloc]init];
            selection.backgroundColor=[UIColor colorWithWhite:0.00 alpha:1.0];
            for (NSString *str  in _threeTypeArray[_number]) {
                if (![str isKindOfClass:[NSNull class]]) {
                    selection.index = [_threeTypeArray[_number] count];
                }
            }
            selection.frame = CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height);
            selection.SSPopupDelegate=self;
            [self.view  addSubview:selection];
            [selection CreateTableview:_threeTypeArray[_number] withSender:nil  withTitle:nil setCompletionBlock:^(int tag){
                _industryThreeView.nameLabel.text = _threeTypeArray[_number][tag];
            }];
            
        }
            break;
        default:
            break;
    }
    
    
    
}















@end













