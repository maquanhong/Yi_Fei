//
//  AlreadyController.m
//  Yi_Fei
//
//  Created by yons on 16/12/13.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "AlreadyController.h"
#import "OfferPriceList.h"
#import "BuyerAskCell.h"
#import "OfferPriceModel.h"
#import "AskWayController.h"
#import "SendWwayController.h"
#import "EditPriceController.h"

#import "BuyerComeOut.h"


@interface AlreadyController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,BuyerAskCellDelegate>
{
    BOOL _isPress;
    BOOL _isSelect;
    BuyerComeOut *_outBuyer;
}
@property (nonatomic, strong)NSMutableArray *circleArray; //存放选中的商品
@property(nonatomic,strong)OfferPriceList *askManager;

@property(nonatomic,strong)UITextField *textInput; //输入框
@property(nonatomic,strong)NSMutableArray *listArray;  //保存的数据
@property(nonatomic,strong)UITableView *tableview; //表格视图
@property (nonatomic, strong) NSMutableArray *searchResultArr; //输入时的结果
@property (nonatomic, strong) NSMutableArray *btnResultArr; //点击按钮时的结果
@property (nonatomic, strong) NSMutableArray *allArray; //搜索的结果

@end

@implementation AlreadyController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadData];
}

//加载数据
-(void)loadData{
    //获取单例对象
    _askManager = [OfferPriceList defaultManager];
    OfferPriceModel *model = [[OfferPriceModel alloc] init];
    _listArray= [NSMutableArray array];
    //可变数组初始化
    NSMutableArray *array = [NSMutableArray arrayWithArray:[_askManager getDataWith:self.model.supplyName]];
    for (NSInteger i = 0 ; i < array.count ; i++) {
        model = array[i];
        if ([model.flag integerValue] == 0) {
            [_listArray addObject:model];
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _isPress = YES;
    _circleArray = [NSMutableArray array];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self createSearchView];
    [self addContentView];
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
        make.leading.mas_equalTo(imageBackView).offset(10);
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
        make.width.mas_equalTo(50);
    }];
    [searchBtn addTarget:self action:@selector(clickBtnSearch) forControlEvents:UIControlEventTouchUpInside];
}

-(void)clickBtnSearch{

    NSMutableArray *array = [NSMutableArray array];
    for (NSInteger i = 0 ; i <_circleArray.count ; i++) {
        NSString *index = [_circleArray objectAtIndex:i];
        [array addObject:_listArray[[index integerValue]]];
    }
    
    _outBuyer = [[BuyerComeOut alloc] init];
    _outBuyer.objcArray = array;
    [_outBuyer sendToSupplyExcel];
    
    
}




#pragma mark 创建tableView视图
-(void)addContentView{
    
    _tableview=[[UITableView alloc] initWithFrame:CGRectMake(10, 50, WIDTH-20, HEIGHT- 160 )style:UITableViewStylePlain];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableview.allowsSelectionDuringEditing=YES;
    
    [self.view addSubview:self.tableview];

    UILongPressGestureRecognizer *lp = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGesture:)];
    //触发长按手势的最小时间间隔，秒
    lp.minimumPressDuration = 0.5;
    [self.tableview addGestureRecognizer:lp];
    
    
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
    nameLabel.text= self.model.supplyName ;
    [haderView addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(haderView).offset(120);
        make.centerY.mas_equalTo(haderView.mas_centerY);
        make.trailing.mas_equalTo(haderView).offset(-10);
        make.height.mas_equalTo(25);
    }];
    self.tableview.tableHeaderView = haderView;
}


#pragma Mark -- 事件处理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return _listArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifer = @"BuyerAskCell";
    BuyerAskCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (!cell) {
        cell = [[BuyerAskCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    }
    OfferPriceModel *dataModel = [[OfferPriceModel alloc] init];
        dataModel = _listArray[indexPath.row];

    NSArray *arrayimg=[dataModel.shopPicture componentsSeparatedByString:@"|"];
    NSString *path_document = NSHomeDirectory();
    //设置一个图片的存储路径
    NSString *imagePath = [path_document stringByAppendingString:[NSString stringWithFormat:@"/Documents/%@.png",arrayimg[0]]];
    cell.iconImageView.image= [UIImage imageWithContentsOfFile:imagePath];
  
    if (dataModel.shopPrice.length > 0 ) {
        cell.price.text=[NSString stringWithFormat:@"￥%@",dataModel.shopPrice];
    }else{
        cell.price.text  =  @"";
    }
    if (dataModel.shopName.length > 0 ) {
    cell.titleLabel.text = dataModel.shopName;
    }else{
    cell.titleLabel.text  =  @"";
    }
    cell.delegate = self;
    cell.selected = UITableViewCellSelectionStyleNone;

    return cell;
}


#pragma mark 点击页面进行跳转
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_isSelect ) {
        BuyerAskCell *cell = [_tableview cellForRowAtIndexPath:indexPath];
        NSString *str = [NSString stringWithFormat:@"%ld",indexPath.row];
        if ([_circleArray containsObject:str]) {
            cell.selectBtn.selected = NO ;
            [_circleArray removeObject:str];
        }else{
            cell.selectBtn.selected = YES ;
            [_circleArray addObject:str];
        }
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 110;
}




- (void)longPressGesture:(UILongPressGestureRecognizer*)lp{
    if(lp.state == UIGestureRecognizerStateBegan){
        
        if (_isPress) {
            NSArray *allCells=[self.tableview visibleCells];
            for(BuyerAskCell *cell in allCells)
            {
            cell.selectBtn.hidden=NO;
            cell.selectBtn.selected=NO;
            }
            AskWayController *myVC = [[ AskWayController alloc] init];
            for (AskWayController * controller in self.navigationController.viewControllers) {
                if ([controller isKindOfClass:[AskWayController class]]) {
                    myVC = controller;
                }
            }
            myVC.rightBtnOne.hidden = YES;
            myVC.rightBtnTwo.hidden = NO;
            [myVC.rightBtnTwo addTarget:self action:@selector(sendVC) forControlEvents:UIControlEventTouchUpInside];
            _isPress = NO;
            _isSelect = YES;
        }else{
            NSArray *allCells=[self.tableview visibleCells];
            for(BuyerAskCell *cell in allCells)
                cell.selectBtn.hidden=YES;
            AskWayController *myVC = [[ AskWayController alloc] init];
            for (AskWayController * controller in self.navigationController.viewControllers) {
                if ([controller isKindOfClass:[AskWayController class]]) {
                    myVC = controller;
                }
            }
            myVC.rightBtnOne.hidden = NO;
            myVC.rightBtnTwo.hidden = YES;
            _isPress = YES;
            _isSelect = NO;
        }
    }
}


-(void)sendVC{
    
    AskWayController *myVC = [[ AskWayController alloc] init];
    for (AskWayController * controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[AskWayController class]]) {
            myVC = controller;
        }
    }
    NSMutableArray *array = [NSMutableArray array];
    for (NSInteger i = 0 ; i <_circleArray.count ; i++) {
        NSString *index = [_circleArray objectAtIndex:i];
        [array addObject:_listArray[[index integerValue]]];
    }
    if (_circleArray.count > 0) {
    SendWwayController *sendVC = [[SendWwayController alloc] init];
    sendVC.numCount = 0;
        sendVC.gggArray = [NSArray arrayWithArray:array];
    [myVC.navigationController pushViewController:sendVC animated:YES];
    }
}


-(void)clickcell:(UITableViewCell *)cell num:(NSInteger)num{
    NSIndexPath *indexPath =  [_tableview indexPathForCell:cell];
    NSInteger  index = indexPath.row;
    switch (num) {
        case 1280:
        {
    EditPriceController *prepareVC = [[EditPriceController alloc] init];
    prepareVC.model = _listArray[index];
    [self.navigationController pushViewController:prepareVC animated:YES];
        }
            break;
        case 1281:
        {
    _askManager = [OfferPriceList defaultManager];
    OfferPriceModel *model = [[OfferPriceModel alloc] init];
    model = _listArray[index];
    [_askManager deleteNameFromTable:model.ind];
    [_listArray removeObjectAtIndex:index];
    [_tableview deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    [_tableview reloadData];
        }
            break;
            
        default:
            break;
    }
    
    
}






-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    NSArray *allCells=[self.tableview visibleCells];
    for(BuyerAskCell *cell in allCells)
        cell.selectBtn.hidden=YES;
    AskWayController *myVC = [[ AskWayController alloc] init];
    for (AskWayController * controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[AskWayController class]]) {
            myVC = controller;
        }
    }
    myVC.rightBtnOne.hidden = NO;
    myVC.rightBtnTwo.hidden = YES;
}









@end


























