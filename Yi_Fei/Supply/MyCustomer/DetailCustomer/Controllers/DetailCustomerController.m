//
//  DetailCustomerController.m
//  Yi_Fei
//
//  Created by yons on 16/12/18.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "DetailCustomerController.h"
#import "ZESegmentedsView.h"
#import "CustomerFirstCell.h"
#import "CustomerTwoCell.h"
#import "CustomerThreeCell.h"
#import "CustomerFourCell.h"
#import "CardNameController.h"
#import "CardCustomerController.h"
#import "CustomerSixCell.h"
#import "CustomerProductList.h"

@interface DetailCustomerController ()<ZESegmentedsViewDelegate,UITableViewDelegate,UITableViewDataSource>{
    CustomerProductList *_manager;
    CustomerSixCell *firstCell;
    CustomerSixCell *secondCell;
    CustomerSixCell *threeCell;
}

@property(nonatomic,strong)UITableView *tableView;  //保存的数据
@property(nonatomic,strong)NSMutableArray *listArray;  //保存的数据
@property (nonatomic, assign) NSInteger  selectIndexInSection1;
@property (nonatomic, assign) NSInteger  selectIndexInSection2;

#pragma mark 客户询价
@property (nonatomic,strong) NSArray *priceArray;
@property (nonatomic,strong) NSArray *leaveArray;
@property (nonatomic,strong) NSArray *reservedArray;

@end

@implementation DetailCustomerController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self load];
}

-(void)load{
    
    _manager = [CustomerProductList defaultManager];
      _priceArray = [NSArray arrayWithArray: [_manager getDataName:_model.customerName and:_model.companyName identify:@"send"]];
    _leaveArray = [NSArray arrayWithArray: [_manager getDataName:_model.customerName  and:_model.companyName and:@"2" identify:@"send"]];
     _reservedArray = [NSArray arrayWithArray: [_manager getDataName:_model.customerName and:_model.companyName and:@"1" identify:@"send"]];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _selectIndexInSection1 = 0;
        _selectIndexInSection2 = 0;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNav];
    self.view.backgroundColor= INTERFACECOLOR;
    [self addContentView];
}

- (void)setNav {
    
    self.navigationItem.title = @"我的客户";
    UIButton* leftBtn= [UIButton buttonWithType:UIButtonTypeCustom];
[leftBtn setImage:[UIImage imageNamed:@"fanhui_icon"] forState:UIControlStateNormal];
    leftBtn.frame = CGRectMake(0, 0, 25, 25);
    UIBarButtonItem* leftBtnItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
[leftBtn addTarget:self action:@selector(leftButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem=leftBtnItem;
    
}

- (void)leftButtonClick {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)addContentView{
    
    _tableView=[[UITableView alloc] initWithFrame:CGRectMake(10, 10, WIDTH-20, HEIGHT-10) style:UITableViewStyleGrouped];
    _tableView.layer.masksToBounds=YES;
    _tableView.layer.cornerRadius=4.0;
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.backgroundColor=[UIColor groupTableViewBackgroundColor];
    _tableView.separatorStyle =  UITableViewCellSeparatorStyleNone;
    _tableView.tableHeaderView.backgroundColor=[UIColor groupTableViewBackgroundColor];
    _tableView.tableHeaderView.layer.masksToBounds=YES;
    _tableView.tableHeaderView.layer.cornerRadius=5.0;
    [self.view addSubview:_tableView];
    
}

#pragma Mark -- 事件处理
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    } else if (section == 1) {
        return 1;
    } else if (section == 2) {
        if (self.selectIndexInSection2 == 0){
            return _priceArray.count;
        }else if (self.selectIndexInSection2 == 1){
           return _leaveArray.count;
        }else{
            return _reservedArray.count;
        }
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return 60;
    }else if (indexPath.section==1){
        if (self.selectIndexInSection1 == 0) {
            return 180;
        } else if (self.selectIndexInSection1 == 1) {
            return 60;
        } else {
            return 60;
        }
    }else{
        return 290;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
    static NSString *cellIdent1=@"cell";
    CustomerFirstCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdent1];
    if (cell==nil) {
        cell=[[CustomerFirstCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdent1];
    }
    cell.layer.masksToBounds=YES;
    cell.layer.cornerRadius=5.0;
    cell.backgroundColor=[UIColor whiteColor];
    cell.label.text= _model.companyName;
        if (_model.companyLogo) {
        cell.imagV.image= [UIImage imageWithData:_model.companyLogo];
        }else{
        cell.imagV.image= [UIImage imageNamed:@"Null"];
        }
    return cell;
    }else if (indexPath.section == 1){
        if (self.selectIndexInSection1 == 0) {
            static NSString *cellIdent2=@"cell2_0";
            CustomerTwoCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdent2];
            if (cell==nil) {
                cell=[[CustomerTwoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdent2];
            }
            cell.model = _model;
            return cell;
        } else if (self.selectIndexInSection1 == 1) {
            static NSString *cellIdent3=@"cell2_1";
            CustomerThreeCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdent3];
            if (cell==nil) {
                cell=[[CustomerThreeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdent3];
            }
            cell.titleLabel.text = @"商品名称：复古吊灯";
            cell.contentLabel.text = @"规格：按钮式开关";
            return cell;
        } else if (self.selectIndexInSection1 == 2) {
            static NSString *cellIdent4=@"cell2_2";
            CustomerFourCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdent4];
            if (cell==nil) {
                cell=[[CustomerFourCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdent4];
            }
            cell.discrible.text = _model.otherNote;
            return cell;
        }
        return nil;
    }else if (indexPath.section == 2){
        
        if (self.selectIndexInSection2 == 0) {
        static NSString *cellIdent5=@"cell3_0";
            firstCell =[tableView dequeueReusableCellWithIdentifier:cellIdent5];
            if (firstCell==nil) {
                firstCell = [[CustomerSixCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdent5];
            }
            [self getDataFormCell:firstCell model:_priceArray[indexPath.row]];
            return firstCell;
        } else if (self.selectIndexInSection2 == 1) {
        
        static NSString *cellIdent6=@"cell3_1";
        secondCell =[tableView dequeueReusableCellWithIdentifier:cellIdent6];
        if (secondCell==nil) {
            secondCell=[[CustomerSixCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdent6];
        }
    [self getDataFormCell:secondCell model:_leaveArray[indexPath.row]];
        return secondCell;
        } else if (self.selectIndexInSection2 == 2) {
    static NSString *cellIdent7=@"cell3_2";
    threeCell =[tableView dequeueReusableCellWithIdentifier:cellIdent7];
    if (threeCell==nil) {
        threeCell =[[CustomerSixCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdent7];
    }
[self getDataFormCell:threeCell model:_reservedArray[indexPath.row]];
    return threeCell;
        }
        return nil;
    }
      return nil;
}



-(void)getDataFormCell:(CustomerSixCell*)cell model:(CustomerProductModel*)model{
 
        cell.titleEightLabel.text = [model.askTime substringToIndex:10] ;
       cell.detailOneLabel.text = model.shopName;
        cell.detailTwoLabel.text =model.shopSpecific;
        cell.detailThreeLabel.text = model.shopSize;
       cell.detailFourLabel.text = model.count;
        cell.detailFiveLabel.text = model.shopMed;
        cell.detailSixLabel.text = model.shopDescribe ;
       cell.detailSevenLabel.text = model.shopColor;
        
        if (model.imageOne) {
            cell.oneImageView.image = [UIImage imageWithData:model.imageOne];
        }
        if (model.imageTwo) {
            cell.twoImageView.image = [UIImage imageWithData:model.imageTwo];
        }
        if (model.imageThree) {
           cell.ThreeImageView.image = [UIImage imageWithData:model.imageThree];
        }
        if (model.imageFour) {
          cell.FourImageView.image = [UIImage imageWithData:model.imageFour];
        }
}




- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 30)];
        view.backgroundColor = [UIColor whiteColor];
        UILabel *label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = _model.customerName;
        label.font = [UIFont systemFontOfSize:16];
        [view addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(view);
            make.height.mas_equalTo(20);
        }];
        UIButton *cardBtn = [[UIButton alloc] init];
        cardBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        cardBtn.layer.cornerRadius = 5;
        [cardBtn setTitle:@"供应商名片" forState:UIControlStateNormal];
        [cardBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [cardBtn setBackgroundColor:[UIColor colorWithRed:36/255.0 green:127/255.0 blue:211/255.0 alpha:1.0f]];
        [view addSubview:cardBtn];
        [cardBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.equalTo(view).offset(-10);
            make.centerY.equalTo(label);
            make.height.mas_equalTo(25);
            make.width.mas_equalTo(75);
        }];
        [cardBtn addTarget:self action:@selector(supplyCard) forControlEvents:UIControlEventTouchUpInside];
        return view;

    }else if (section == 1){
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 50)];
        view.backgroundColor = [UIColor whiteColor];
        ZESegmentedsView *segmentView = [[ZESegmentedsView alloc] initWithFrame:CGRectMake(10, 10, WIDTH-40, 30) segmentedCount:3 segmentedTitles:@[@"客户资料",@"交易记录",@"备  注"] selectIndex:self.selectIndexInSection1];
        segmentView.delegate = self;
        segmentView.tag = 10000 + section;
        [view addSubview:segmentView];
        return view;
    } else if (section == 2) {
        
UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 100)];
        
  UIView *oneView  = [[UIView alloc] initWithFrame:CGRectMake(0, 10, WIDTH, 38)];
        oneView.backgroundColor = [UIColor whiteColor];
        [view addSubview:oneView];
        
UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 9, WIDTH, 20)];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = @"客户询价";
        [oneView addSubview:label];
        
UIView *twoView  = [[UIView alloc] initWithFrame:CGRectMake(0, 50, WIDTH, 50)];
        twoView.backgroundColor = [UIColor whiteColor];
        [view addSubview:twoView];
        ZESegmentedsView *segmentView = [[ZESegmentedsView alloc] initWithFrame:CGRectMake(20, 10, WIDTH-60, 30) segmentedCount:3 segmentedTitles:@[@"最新询价",@"留样询价",@"客户预留询价"] selectIndex:self.selectIndexInSection2];
        segmentView.delegate = self;
        segmentView.tag = 10000 + section;
        [twoView addSubview:segmentView];
        return view;
    }
    return nil;
}


-(void)supplyCard{
    
    CardCustomerController *cardVC = [[ CardCustomerController alloc] init];
    cardVC.model = _model;
    [self.navigationController pushViewController:cardVC animated:YES];
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 40;
    } else if (section == 1) {
        return 50;
    }else{
        return 100;
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    if (section == 1) {
        return 0.00000001;
    }else{
        return 10;
    }
}



#pragma mark ZESegmentedsViewDelegate
- (void)selectedZESegmentedsViewItemAtIndex:(NSInteger)selectedItemIndex zeView:(ZESegmentedsView *)zeView {
    if ((zeView.tag - 10000) == 1) {
        self.selectIndexInSection1 = selectedItemIndex;
    } else if ((zeView.tag - 10000) == 2) {
        self.selectIndexInSection2 = selectedItemIndex;
    }
    [_tableView reloadSections:[NSIndexSet indexSetWithIndex:zeView.tag - 10000] withRowAnimation:UITableViewRowAnimationNone];
}






























































@end




