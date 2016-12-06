
//
//  BuyerDetailViewController.m
//  Yi_Fei
//
//  Created by yons on 16/11/24.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "BuyerDetailViewController.h"
#import "BuyerEditFirstCell.h"
#import "BuyerEditFSecondCell.h"
#import "BuyerEditThreeCell.h"
#import "SendInfoController.h"
#import "ShareActivity.h"

@interface BuyerDetailViewController ()<UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate,ShareActivityDelegate>
{
    BuyerEditFirstCell *firstCell;
    BuyerEditFSecondCell *secondCell;
    BuyerEditThreeCell *threeCell;
}

@property(nonatomic,strong)UITableView *tableView;
@property (nonatomic, strong) HYActivityView *activityView;

@end

@implementation BuyerDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor groupTableViewBackgroundColor];
    [self createNavigationView];
    [self addContentView];
   
}

#pragma mark 创建导航栏
-(void)createNavigationView
{
    self.navigationItem.title = @"商品详情";
    BackButton *leftBtn = [[BackButton alloc] initWithFrame:CGRectMake(0, 0, 12, 20)];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"fanhui_icon"] forState:UIControlStateNormal];
    UIBarButtonItem * barItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = barItem;
    [leftBtn addTarget:self action:@selector(leftButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    BackButton *rightBtn = [[BackButton alloc] initWithFrame:CGRectMake(0, 0, 30, 20)];
    
    [rightBtn setImage:[UIImage imageNamed:@"点点"] forState:UIControlStateNormal];
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    [rightBtn addTarget:self action:@selector(shareProduct) forControlEvents: UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = rightItem;
}

-(void)leftButtonClick{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark 创建视图模块
-(void)addContentView{
    _tableView  =[[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT) style:UITableViewStyleGrouped];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:_tableView];
    [_tableView reloadData];
}

#pragma Mark -- 事件处理

#pragma mark -- 代
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    if (indexPath.row == 0) {
        static NSString *identifer1=@"DetailFirstCell";
        firstCell  = [tableView dequeueReusableCellWithIdentifier:identifer1];
        if (firstCell == nil) {
            firstCell = [[BuyerEditFirstCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer1];
        }
        firstCell.selectionStyle = UITableViewCellSelectionStyleNone;
        firstCell.productionObjc = self.shopData;
        return firstCell;
        
    }else if (indexPath.row == 1){
        
        static NSString *identifer2 = @"DetailSecondCell";
        secondCell  = [tableView dequeueReusableCellWithIdentifier:identifer2];
        if (secondCell == nil) {
            secondCell = [[BuyerEditFSecondCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer2];
        }
        secondCell.productionObjc = self.shopData;
        secondCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return secondCell;
        
    }else if (indexPath.row == 2){
        static NSString *identifer3 = @"DetailThreeCell";
        threeCell  = [tableView dequeueReusableCellWithIdentifier:identifer3];
        if (threeCell == nil) {
            threeCell = [[BuyerEditThreeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer3];
        }
        threeCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return threeCell;
        
    }else{
        return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 200;
    }else if (indexPath.row == 1){
        return 100;
    }else if (indexPath.row == 2){
        return 260;
    }else{
        return 0;
    }
}


//设置section的header
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 260)];
    backView.backgroundColor  =   [UIColor whiteColor];
    NSArray *arrayimg=[self.shopData.shopPicture componentsSeparatedByString:@"|"];
    NSString *path_document = NSHomeDirectory();
    //设置一个图片的存储路径
    NSMutableArray *imageArray = [NSMutableArray array];
    for (NSInteger i = 0 ; i < arrayimg.count; i++) {
        NSString *imagePath = [path_document stringByAppendingString:[NSString stringWithFormat:@"/Documents/%@.png",arrayimg[i]]];
        [imageArray addObject:imagePath];
        
    }
    SDCycleScrollView *cycleScrollView=[SDCycleScrollView   cycleScrollViewWithFrame:CGRectMake(0, 0, WIDTH, 180) imageNamesGroup:imageArray];
    
    [backView addSubview:cycleScrollView];
    
    UILabel *titleLable = [[UILabel alloc] init];
    titleLable.font = [UIFont systemFontOfSize:18];
    if (_shopData.shopName.length != 0) {
        titleLable.text = _shopData.shopName;
    }else{
        titleLable.text = @"akjfpaifipa";
    }
    
    [backView addSubview:titleLable];
    [titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(cycleScrollView).offset(10);
        make.top.mas_equalTo(cycleScrollView.mas_bottom).offset(15);
        make.height.mas_equalTo(20);
        make.trailing.mas_equalTo(cycleScrollView).offset(-10);
    }];
    
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.text = @"价格";
    nameLabel.font = [UIFont systemFontOfSize:14];
    [backView addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(titleLable);
        make.top.mas_equalTo(titleLable.mas_bottom).offset(10);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(30);
    }];
    
    UILabel * priceLabel = [[UILabel alloc] init];
    priceLabel.font = [UIFont systemFontOfSize:14];
    priceLabel.text = _shopData.shopPrice;
    [backView addSubview:priceLabel];
    [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(nameLabel.mas_right).offset(10);
        make.centerY.mas_equalTo(nameLabel.mas_centerY);
        make.height.mas_equalTo(20);
        make.trailing.mas_equalTo(backView).offset(-10);
    }];
    return backView;
}
//在设置section的header的时候，必须要结合设置header的高度，否则header不显示(要想实现section的header的话 必须要设置其高度，否则不显示)
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 250;
}


- (void)shareProduct {
    ShareActivity *sa = [[ShareActivity alloc] initShareActivityView];
    sa.delegate = self;
    [sa show];
}

- (void)clickButtonView:(NSInteger)index button:(UIButton *)btn{
    
    switch (index) {
        case 123456:
        {
    SendInfoController *sendView = [[SendInfoController alloc] init];
    sendView.shopData =  _shopData;
    [self.navigationController pushViewController:sendView animated:YES];
            
        }
            break;
        case 123457:
        {
            
            
            
        }
            break;
        case 123458:
        {
          
            
            
            
        }
            break;
        case 123459:
        {
       
            
            
            
        }
            break;
        case 123460:
        {
          
            
            
            
            
        }
            break;
        default:
            break;
    }
}

























@end




























