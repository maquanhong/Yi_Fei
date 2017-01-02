
//
//  DemandOneController.m
//  Yi_Fei
//
//  Created by yons on 16/12/29.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "DemandOneController.h"
#import "SearchView.h"
#import "OneFirstViewCell.h"
#import "TwoTableViewCell.h"
#import "ThreeTextViewCell.h"
#import "FourTextViewCell.h"
#import "FiveTextViewCell.h"
#import "FooterView.h"
//供应商
#import "SupplyList.h"
#import "IndustryModel.h"



@interface DemandOneController ()<TwoTableViewCellDelegate,FooterViewDelegate,SSPopupDelegate,OneFirstViewCellDelegate>{
    OneFirstViewCell *firstCell;
    TwoTableViewCell *secondCell;
    ThreeTextViewCell *ThreeCell;
    FourTextViewCell *fourCell;
    FiveTextViewCell *fiveCell;
    OneFirstViewCell *sixCell;
    SupplyList *_manager;
    NewTwoList  *_productMg;
    NSInteger _indexOne;
    NSInteger _indexTwo;
}
@property (nonatomic,strong)IndustryModel *industryModel; //行业类型

@property (nonatomic,strong) SearchView  *searchView; //搜索框
@property (nonatomic,strong) BackButton  *addBtn; //搜索框
//供应商
@property(nonatomic,strong)NSMutableArray *listArray; //数据源数组供应商
@property(nonatomic,strong)NSMutableArray *nameArray; //供应商数组
@property(nonatomic,strong)NSMutableArray *selectBuyer; //商品数组
//商品
@property(nonatomic,strong)NSMutableArray *productArray; //商品数组
@property(nonatomic,strong)NSMutableArray *productName; //商品数组
@property(nonatomic,strong)NSMutableArray *selectProduct; //商品数组


@end

@implementation DemandOneController


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadData];
}

//数据的加载
-(void)loadData{
    //获取单例对象
    _manager = [SupplyList  defaultManager];
    _nameArray = [NSMutableArray array];
    //可变数组初始化
    _listArray = [NSMutableArray arrayWithArray:[_manager getData]];
    for (SupplyModel *model in _listArray) {
        [_nameArray addObject:model.supplyName];
    }
    
    //获取单例对象
    _productMg = [NewTwoList newListManager];
    //可变数组初始化
    _productArray = [NSMutableArray arrayWithArray:[_productMg getData]];
    _productName = [NSMutableArray array];
    for (ProductionData *dataModel in _productArray) {
        [_productName addObject:dataModel.shopName];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = INTERFACECOLOR;
    _selectBuyer = [NSMutableArray array];
    _selectProduct = [NSMutableArray array];
    [self createSearchView];
    [self createTableView];

}

#pragma mark 创建搜索框
-(void)createSearchView{
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
    
    _addBtn = [[BackButton alloc] init];
    [_addBtn setTitle:NSLocalizedString(@"add", nil) forState:UIControlStateNormal];
    _addBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [_addBtn setTitleColor:COLOR forState:UIControlStateNormal];
    [self.view addSubview:_addBtn];
    [_addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(self.view).offset(-10);
        make.centerY.mas_equalTo(_searchView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(40, 20));
    }];
}


-(void)createTableView{
    _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 60, WIDTH, HEIGHT - 60 )style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
FooterView *footerView = [[FooterView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 150)];
    [footerView.footerBtn setTitle:NSLocalizedString(@"确认并发布", nil) forState:UIControlStateNormal];
    footerView.delegate  = self;
    _tableView.tableFooterView = footerView;
}

- (void)clickBtn{
    
}


#pragma mark 创建tableView的代理
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        static NSString *identifer1 = @"OneFirstViewCell";
        firstCell = [tableView dequeueReusableCellWithIdentifier:identifer1];
        if (!firstCell) {
            firstCell = [[OneFirstViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer1];
        }
        firstCell.titleLabel.text = NSLocalizedString(@"选择供应商", nil);
        firstCell.delegate = self;
        return firstCell;
    }else if (indexPath.row == 1){
        static NSString *identifer2 = @"TwoTableViewCell";
        secondCell = [tableView dequeueReusableCellWithIdentifier:identifer2];
        if (!secondCell) {
            secondCell = [[TwoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer2];
        }
        secondCell.delegate = self;
        return secondCell;
    }else if (indexPath.row == 2){
        static NSString *identifer3 = @"OneFirstViewCell";
        sixCell = [tableView dequeueReusableCellWithIdentifier:identifer3];
        if (!sixCell) {
            sixCell = [[OneFirstViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer3];
        }
        sixCell.titleLabel.text = NSLocalizedString(@"chooseProduct", nil);
        sixCell.delegate = self;
        return sixCell;
    }else if (indexPath.row == 3){
        static NSString *identifer4 = @"ThreeTextViewCell";
        ThreeCell = [tableView dequeueReusableCellWithIdentifier:identifer4];
        if (!ThreeCell) {
            ThreeCell = [[ThreeTextViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer4];
        }
        return ThreeCell;
    }else if (indexPath.row == 4){
        static NSString *identifer5 = @"FourTextViewCell";
        fourCell = [tableView dequeueReusableCellWithIdentifier:identifer5];
        if (!fourCell) {
        fourCell = [[FourTextViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer5];
        }
        return fourCell;
    }else if (indexPath.row == 5){
        static NSString *identifer6 = @"FiveTextViewCell";
        fiveCell = [tableView dequeueReusableCellWithIdentifier:identifer6];
        if (!fiveCell) {
            fiveCell = [[FiveTextViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer6];
        }
        return fiveCell;
    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 1 ||indexPath.row == 4){
        return 100;
    }else{
        return 44;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
 
  }
    
}


- (void)clickViewCell:(UITableViewCell *)cell{

    NSIndexPath *indexPath = [_tableView indexPathForCell:cell];
    switch (indexPath.row) {
        case 0:
        {
    if (_nameArray.count > 0 ) {
        SSPopup* selection=[[SSPopup alloc]init];
        selection.backgroundColor=[UIColor colorWithWhite:0.00 alpha:1.0];
        selection.index = _nameArray.count;
        selection.frame = CGRectMake(0,0,WIDTH,HEIGHT - 104);
        selection.SSPopupDelegate=self;
        [self.view  addSubview:selection];
        [selection CreateTableview:_nameArray withSender:nil  withTitle:nil setCompletionBlock:^(int tag){
            
            if (![_selectBuyer containsObject:_nameArray[tag]]) {
                [_selectBuyer addObject:_nameArray[tag]];
            }else{
                [self getData:NSLocalizedString(@"completeAdd", nil)];
            }
            firstCell.typeView.array = _selectBuyer;
            [firstCell.typeView.collectionView reloadData];
        }];
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"prompt", nil)
                                                        message:@"无供应商"
                                                       delegate:nil
                                              cancelButtonTitle:nil
                                              otherButtonTitles:NSLocalizedString(@"determine", nil), nil];
        [alert show];
    }
        }
            break;
        case 2:
        {
        if (_productName.count > 0) {
            SSPopup* selection=[[SSPopup alloc]init];
            selection.backgroundColor=[UIColor colorWithWhite:0.00 alpha:1.0];
            selection.index = _productName.count;
            selection.frame = CGRectMake(0,0,WIDTH,HEIGHT - 104);
            selection.SSPopupDelegate=self;
            [self.view  addSubview:selection];
            [selection CreateTableview:_productName withSender:nil  withTitle:nil setCompletionBlock:^(int tag){
                if (![_selectProduct containsObject:_productName[tag]]) {
                    [_selectProduct addObject:_productName[tag]];
                }else{
                    [self getData:NSLocalizedString(@"completeProduct", nil)];
                }
                sixCell.typeView.array = _selectProduct;
                [sixCell.typeView.collectionView reloadData];
            }];
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"prompt", nil)
                                                            message:@"无商品"
                                                           delegate:nil
                                                  cancelButtonTitle:nil
                                                  otherButtonTitles:NSLocalizedString(@"determine", nil), nil];
            [alert show];
        }

        }
            break;
            
        default:
            break;
    }
}


-(void)getData:(NSString*)data{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"prompt", nil)
                                                    message:data
                                                   delegate:nil
                                          cancelButtonTitle:nil
                                          otherButtonTitles:NSLocalizedString(@"determine", nil), nil];
    [alert show];
}


- (void)clickView:(NSInteger)index{
    switch (index) {
        case 19000:
        {
    _industryModel = [[IndustryModel alloc] init];
    NSMutableArray *array = [_industryModel   getAllIndustry];
    [self getAllIndestry:[array copy]];
        }
            break;
        case 19001:
        {
    _industryModel = [[IndustryModel alloc] init];
    NSMutableArray *array = [_industryModel getIndustryTwo:_indexOne];
    [self getIndestry:[array copy]];
        }
            break;
        case 19002:
        {
    _industryModel = [[IndustryModel alloc] init];
    NSMutableArray *array = [_industryModel getIndustryNumber:_indexOne threeNumber:_indexTwo];
    [self getThreeIndestry:[array copy]];
        }
            break;
        case 19003:
        {
            
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
    selection.frame = CGRectMake(0,0,self.view.frame.size.width,HEIGHT - 94);
    selection.SSPopupDelegate=self;
    [self.view  addSubview:selection];
    [selection CreateTableview:array withSender:nil  withTitle:nil setCompletionBlock:^(int tag){
        _indexOne = tag;
        if ([array[tag] length] > 0) {
            secondCell.typeOne.nameLabel.text = array[tag];
        }else{
            secondCell.typeOne.nameLabel.text = @"";
        }
        
        _industryModel = [[IndustryModel alloc] init];
        NSString *str = [_industryModel getAllIndustry:_indexOne ];
        if ([str length] > 0) {
            secondCell.typeTwo.nameLabel.text = str;
            secondCell.typeTwo.userInteractionEnabled = YES;
        }else{
            secondCell.typeTwo.nameLabel.text = @"";
            secondCell.typeTwo.userInteractionEnabled = NO;
        }
        
        _industryModel = [[IndustryModel alloc] init];
        NSString *strOne = [_industryModel getAllIndustryTwo:_indexOne ];
        if ([strOne length] > 0) {
            secondCell.typeThree.nameLabel.text = strOne;
            secondCell.typeThree.userInteractionEnabled = YES;
        }else{
            secondCell.typeThree.nameLabel.text = @"";
            secondCell.typeThree.userInteractionEnabled = NO;
        }
    }];
}


-(void)getIndestry:(NSArray*)array{
    
    SSPopup* selection=[[SSPopup alloc]init];
    selection.backgroundColor=[UIColor colorWithWhite:0.00 alpha:1.0];
    selection.index = array.count;
    selection.frame = CGRectMake(0,0,self.view.frame.size.width,HEIGHT - 94);
    selection.SSPopupDelegate=self;
    [self.view  addSubview:selection];
    [selection CreateTableview:array withSender:nil  withTitle:nil setCompletionBlock:^(int tag){
        _indexTwo = tag;
        if ([array[tag] length] > 0) {
            secondCell.typeTwo.nameLabel.text = array[tag];
        }else{
            secondCell.typeTwo.nameLabel.text = @"";
        }
        _industryModel = [[IndustryModel alloc] init];
        NSString *strOne = [_industryModel getIndustryTwo:_indexOne threeNumber:_indexTwo];
        if ([strOne length] > 0) {
            secondCell.typeThree.nameLabel.text = strOne;
        }else{
            secondCell.typeThree.nameLabel.text = @"";
        }
    }];
}



-(void)getThreeIndestry:(NSArray*)array{
    
    SSPopup* selection=[[SSPopup alloc]init];
    selection.backgroundColor=[UIColor colorWithWhite:0.00 alpha:1.0];
    selection.index = array.count;
    selection.frame = CGRectMake(0,0,self.view.frame.size.width,HEIGHT - 94 );
    selection.SSPopupDelegate=self;
    [self.view  addSubview:selection];
    [selection CreateTableview:array withSender:nil  withTitle:nil setCompletionBlock:^(int tag){
        _indexTwo = tag;
        if ([array[tag] length] > 0) {
            secondCell.typeThree.nameLabel.text = array[tag];
        }else{
            secondCell.typeThree.nameLabel.text = @"";
        }
    }];
}
























@end















