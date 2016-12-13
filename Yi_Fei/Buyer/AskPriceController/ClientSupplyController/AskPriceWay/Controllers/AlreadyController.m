//
//  AlreadyController.m
//  Yi_Fei
//
//  Created by yons on 16/12/13.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "AlreadyController.h"
#import "AskPriceList.h"

@interface AlreadyController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>{
    BOOL _isSearch;
    BOOL _btnSearch;
    BOOL _nilSearch;

}
@property(nonatomic,strong)AskPriceList *askManager;
@property(nonatomic,strong)UITextField *textInput; //输入框
@property(nonatomic,strong)NSMutableArray *listArray;  //保存的数据
@property(nonatomic,strong)UITableView *tableview; //表格视图
@property (nonatomic, strong) NSMutableArray *searchResultArr; //输入时的结果
@property (nonatomic, strong) NSMutableArray *btnResultArr; //点击按钮时的结果
@property (nonatomic, strong) NSMutableArray *allArray; //搜索的结果
;

@end

@implementation AlreadyController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadData];
}

//数据的加载
-(void)loadData{
    
    //获取单例对象
    _askManager = [AskPriceList defaultManager];
    //可变数组初始化
    _listArray = [NSMutableArray arrayWithArray:[_askManager getData]];
    _allArray = [NSMutableArray array];
    for (NSInteger i = 0 ; i < _listArray.count; i++) {
        AskPriceModel *dataModel = [[AskPriceModel alloc] init];
        dataModel = _listArray[i];
        if (dataModel.shopName.length != 0 ) {
            [_allArray addObject:dataModel.shopName];
        }else{
            [_allArray addObject:[NSNull null]];
        }
    }
    [_tableview reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self createSearchView];
//    [self addContentView];
    
    
}

#pragma mark 创建搜索框
-(void)createSearchView{
    
    UIButton *searchBtn = [[UIButton alloc]init];
    [searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
    searchBtn.backgroundColor = [UIColor groupTableViewBackgroundColor];
    searchBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [searchBtn setTitleColor:COLOR forState:UIControlStateNormal];
    [self.view addSubview:searchBtn];
    
    
    UIView *imageBackView = [[UIView alloc]init];
    imageBackView.userInteractionEnabled = YES;
    imageBackView.layer.cornerRadius = 8;
    imageBackView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:imageBackView];
    [imageBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.view).offset(20);
        make.right.equalTo(searchBtn.mas_left).offset(-10);
        make.top.mas_equalTo(self.view.mas_top).offset(10);
        make.height.mas_equalTo(30);
    }];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:@"sousuo"];
    [imageBackView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(imageBackView).offset(20);
        make.centerY.mas_equalTo(imageBackView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    
    _textInput = [[UITextField alloc] init];
    _textInput.font = [UIFont systemFontOfSize:14];
    _textInput.placeholder = @"输入商品名称";
    _textInput.delegate = self;
    [_textInput addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [imageBackView addSubview:_textInput];
    [_textInput mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(imageView.mas_right).offset(5);
        make.centerY.mas_equalTo(imageBackView.mas_centerY);
        make.trailing.mas_equalTo(imageBackView);
        make.height.mas_equalTo(30);
    }];
    
    [searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.view).offset(-10);
        make.centerY.mas_equalTo(imageBackView.mas_centerY);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(60);
    }];
    [searchBtn addTarget:self action:@selector(clickBtnSearch) forControlEvents:UIControlEventTouchUpInside];
    
    
}

#pragma mark 点击搜索按钮
-(void)clickBtnSearch{
    
    _btnSearch = YES;
    [_btnResultArr removeAllObjects];
    int k = 0;
    for (NSString *str in _allArray) {
        NSString *ste = [NSString stringWithFormat:@"%@",str];
        NSRange range = [ste rangeOfString:_textInput.text];
        NSString *tpinyin = [self transform:ste];
        NSRange rangeTpinyin = [tpinyin rangeOfString:_textInput.text];
        if (range.length || rangeTpinyin.length) {
            [_btnResultArr addObject:_listArray[k]];
            NSLog(@"%@",_btnResultArr);
        }
        k++;
        [_tableview reloadData];
    }
}

#pragma mark textFiled的点击事件
- (void)textFieldDidChange:(UITextField *)textField{
    
    if (textField.text.length == 0) {
        _nilSearch = YES;
        [_tableview reloadData];
    }else{
        _isSearch = YES;
        [_searchResultArr removeAllObjects];
        [self textFileSearch:textField.text];
    }
}

-(void)textFileSearch:(NSString *)TextField
{
    [_searchResultArr removeAllObjects];
    int k = 0;
    for (NSString *str in _allArray) {
        NSString *ste = [NSString stringWithFormat:@"%@",str];
        NSRange range = [ste rangeOfString:TextField];
        NSString *tpinyin = [self transform:ste];
        NSRange rangeTpinyin = [tpinyin rangeOfString:TextField];
        if (range.length || rangeTpinyin.length) {
            [_searchResultArr addObject:_listArray[k]];
        }
        k++;
        [_tableview reloadData];
    }
}


#pragma mark 将输入的字母转换为文字
- (NSString *)transform:(NSString *)chinese
{
    NSMutableString *pinyin = [chinese mutableCopy];
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformStripCombiningMarks, NO);
    NSString *py = [pinyin stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *pys = [NSString stringWithFormat:@"%@%@%@%@%@%@",[pinyin uppercaseString],[pinyin lowercaseString],[pinyin capitalizedString],[py uppercaseString],[py lowercaseString],[py capitalizedString]];
    return pys;
}




#pragma mark 创建tableView视图
-(void)addContentView{
    
//    _tableview=[[UITableView alloc] initWithFrame:CGRectMake(10, 20, WIDTH-20, HEIGHT-50 )style:UITableViewStylePlain];
//    self.tableview.delegate = self;
//    self.tableview.dataSource = self;
//    self.tableview.backgroundColor = [UIColor groupTableViewBackgroundColor];
//    [self.view addSubview:self.tableview];
    
    
    UIView *haderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH-20, 45)];
    haderView.backgroundColor = [UIColor whiteColor];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:haderView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(8,8)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = haderView.bounds;
    maskLayer.path = maskPath.CGPath;
    haderView.layer.mask = maskLayer;
    
    UIView *nextView = [[UIView alloc]init];
    nextView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [haderView addSubview:nextView];
    [nextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(haderView);
        make.trailing.mas_equalTo(haderView);
        make.bottom.mas_equalTo(haderView.mas_bottom);
        make.height.mas_equalTo(2);
    }];
    
    UILabel *nameLabel = [[UILabel alloc] init];
    [nameLabel sizeToFit];
    nameLabel.textColor=[UIColor blackColor];
    nameLabel.font=[UIFont systemFontOfSize:18.0];
    nameLabel.text=@" 供应商A";
    [haderView addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(haderView).offset(120);
        make.centerY.mas_equalTo(haderView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(100, 20));
    }];
    self.tableview.tableHeaderView = haderView;
}



















































@end


























