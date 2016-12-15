//
//  MySalerViewController.m
//  YiFei
//
//  Created by yangyan on 16/9/2.
//  Copyright © 2016年 yous. All rights reserved.
//

#import "MySalerViewController.h"
#import "MyBuyerTableViewCell.h"
#import "MyBuyerInfoTableViewCell.h"
#import "AskPriceTableViewCell.h"
//#import "MyBuyerAskTableViewCell.h"
#import "ClientInfoTableViewCell.h"
#import "NameContentTableViewCell.h"
#import "ZESegmentedsView.h"
#import "OnlyTitleTableViewCell.h"
//#import "AddSupplyViewController.h"
#import "NewClientSupplyController.h"
#import "BriefProductTableViewCell.h"
#import "ProductListTableViewController.h"
@interface MySalerViewController ()<ZESegmentedsViewDelegate>
{
    UIView *addTableV;
}
@property (nonatomic, assign) NSInteger  selectIndexInSection1;
@property (nonatomic, assign) NSInteger  selectIndexInSection2;
@property (nonatomic, assign) BOOL bShowAddView;
@end

@implementation MySalerViewController
- (instancetype)init {
    self = [super init];
    if (self) {
        _selectIndexInSection1 = 0;
        _selectIndexInSection2 = 0;
    }
    return self;
}
- (void)setNav {
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


//-(void)btnClick:(UIButton *)sender{
//    
//    AddSupplyViewController *addSuVC=[[AddSupplyViewController alloc] init];
//    [self.navigationController pushViewController:addSuVC animated:YES];
//    [addTableV removeFromSuperview];
//}

-(void)btn2Click:(UIButton *)sender{
    NewClientSupplyController *addSuVC=[[NewClientSupplyController alloc] initWithTypeId:BussinessBuyer];
    [self.navigationController pushViewController:addSuVC animated:YES];
    [addTableV removeFromSuperview];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"我的供应商";
    [self setNav];
    self.view.backgroundColor=[UIColor groupTableViewBackgroundColor];
    [self addContentView];
}


-(void)addContentView{
    self.tableV=[[UITableView alloc] initWithFrame:CGRectMake(10, 10, WIDTH-20, HEIGHT-10) style:UITableViewStyleGrouped];
    self.tableV.layer.masksToBounds=YES;
    self.tableV.layer.cornerRadius=4.0;
    self.tableV.delegate=self;
    self.tableV.dataSource=self;
    self.tableV.backgroundColor=[UIColor groupTableViewBackgroundColor];
    
    self.tableV.tableHeaderView.backgroundColor=[UIColor groupTableViewBackgroundColor];
    self.tableV.tableHeaderView.layer.masksToBounds=YES;
    self.tableV.tableHeaderView.layer.cornerRadius=5.0;
    [self.view addSubview:self.tableV];

}

#pragma Mark -- 事件处理

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    } else if (section == 1) {
        return 1;
    } else if (section == 2) {
        return 1;
    } else if (section == 3) {
        return 2;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return 40;
    }else if (indexPath.section==1){
        if (self.selectIndexInSection1 == 0) {
            return 120;
        } else if (self.selectIndexInSection1 == 1) {
            return 60;
        } else {
            return 40;
        }
        
    } else if (indexPath.section == 2) {
        return 120;
    }else{
        if (self.selectIndexInSection2 == 0) {
            return 230;
        } else if (self.selectIndexInSection2 == 1) {
            return 230;
        } else {
            return 60;
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        static NSString *cellIdent1=@"cell";
        MyBuyerTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdent1];
        if (cell==nil) {
            cell=[[MyBuyerTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdent1];
        }
        cell.layer.masksToBounds=YES;
        cell.layer.cornerRadius=5.0;
        cell.backgroundColor=[UIColor whiteColor];
        cell.imagV.backgroundColor=[UIColor orangeColor];
        cell.label.text=@"供应商C公司的名称";
        return cell;
    }else if (indexPath.section==1){
        
        if (self.selectIndexInSection1 == 0) {
            static NSString *cellIdent2=@"cell2_0";
            ClientInfoTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdent2];
            if (cell==nil) {
                cell=[[ClientInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdent2];
            }
            cell.nameLabel.text = @"姓名：周运发";
            cell.telLabel.text = @"电话：18636475867";
            cell.postionLabel.text = @"职位：总经理";
            cell.emailLabel.text = @"邮箱：maqanhong34@163.com";
            cell.companyLabel.text = @"杭州百倍云科技公司";
            cell.addressLabel.text = @"地址：浙江深杭州市";
            cell.careerLabel.text = @"行业类型：跳跳糖";
            return cell;
        } else if (self.selectIndexInSection1 == 1) {
            static NSString *cellIdent3=@"cell2_1";
            NameContentTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdent3];
            if (cell==nil) {
                cell=[[NameContentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdent3];
            }
            
            cell.titleLabel.text = @"商品名称：复古吊灯";
            cell.contentLabel.text = @"规格：按钮式开关";
            
            return cell;
        } else if (self.selectIndexInSection1 == 2) {
            static NSString *cellIdent4=@"cell2_2";
            OnlyTitleTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdent4];
            if (cell==nil) {
                cell=[[OnlyTitleTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdent4];
            }
            
            cell.titleLabel.text = @"商品名称：复古吊灯";
            
            return cell;
        }
        return nil;
        
    } else if (indexPath.section == 2) {
        static NSString *cellIdent9=@"morecell";
        BriefProductTableViewCell *cell = (BriefProductTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdent9];
        if (!cell) {
            cell = [[BriefProductTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdent9];
        }
        cell.iconImageView.backgroundColor = [UIColor redColor];
        cell.productImageView.backgroundColor = [UIColor redColor];
        cell.productNameLabel.text = @"降落伞状白织灯";
        cell.moreLabel.text = @"查看更多";
        cell.titleLabel.text = @"商品列表";
        cell.moreImageView.backgroundColor = [UIColor redColor];
        return cell;
    } else{
        
        if (self.selectIndexInSection2 == 0) {
            static NSString *cellIdent5=@"cell3_0";
            AskPriceTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdent5];
            if (cell==nil) {
                cell=[[AskPriceTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdent5];
            }
            
            cell.productLabel.text = @"商品名称：复古吊灯";
            cell.typeLabel.text = @"规格：按钮式开关";
            cell.skinLabel.text = @"材质：PVC塑料";
            cell.sizeLabel.text = @"尺寸：60cm";
            cell.colorLabel.text = @"颜色：米黄色";
            cell.countLabel.text = @"数量：30";
            cell.markLabel.text = @"备注：总经理";
            return cell;

        } else if (self.selectIndexInSection2 == 1) {
            static NSString *cellIdent6=@"cell3_1";
            AskPriceTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdent6];
            if (cell==nil) {
                cell=[[AskPriceTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdent6];
            }
            
            cell.productLabel.text = @"商品名称：复古吊灯";
            cell.typeLabel.text = @"规格：按钮式开关";
            cell.skinLabel.text = @"材质：PVC塑料";
            cell.sizeLabel.text = @"尺寸：60cm";
            cell.colorLabel.text = @"颜色：米黄色";
            cell.countLabel.text = @"数量：30";
            cell.markLabel.text = @"备注：总经理";
            return cell;
        } else if (self.selectIndexInSection2 == 2) {
            static NSString *cellIdent7=@"cell3_2";
            NameContentTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdent7];
            if (cell==nil) {
                cell=[[NameContentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdent7];
            }
            
            cell.titleLabel.text = @"商品名称：复古吊灯";
            cell.contentLabel.text = @"规格：按钮式开关";

            return cell;

        }
        return nil;
    }
}


- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 30)];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH / 2 - 50, 7, 100, 15)];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = @"供应商C";
        [view addSubview:label];
        UIButton *cardBtn = [[UIButton alloc] initWithFrame:CGRectMake(WIDTH - 105, 5, 100, 30)];
        cardBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        cardBtn.layer.cornerRadius = 8;
        [cardBtn setTitle:@"供应商名片" forState:UIControlStateNormal];
        [cardBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [cardBtn setBackgroundColor:[UIColor colorWithRed:36/255.0 green:127/255.0 blue:211/255.0 alpha:1.0f]];
        [cardBtn addTarget:self action:@selector(supplyCard) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:cardBtn];
        return view;
    } else if (section == 1) {
        ZESegmentedsView *segmentView = [[ZESegmentedsView alloc] initWithFrame:CGRectMake(20, 5, WIDTH-40, 30) segmentedCount:3 segmentedTitles:@[@"供应商资料",@"交易记录",@"备忘供应商爱好"] selectIndex:self.selectIndexInSection1];
        segmentView.delegate = self;
        segmentView.tag = 10000 + section;
        return segmentView;
    } else if (section == 3) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 80)];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, WIDTH, 15)];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = @"供应商报价";
        [view addSubview:label];
        ZESegmentedsView *segmentView = [[ZESegmentedsView alloc] initWithFrame:CGRectMake(20, 35, WIDTH-40, 30) segmentedCount:3 segmentedTitles:@[@"最新报价",@"留样报价",@"预留报价"] selectIndex:self.selectIndexInSection2];
        segmentView.delegate = self;
        segmentView.tag = 10000 + section;
        [view addSubview:segmentView];
        return view;
    }
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ProductListTableViewController *proVc = [[ProductListTableViewController alloc] init];
    [self.navigationController pushViewController:proVc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 40;
    } else if (section == 1) {
        return 30;
    } else if (section == 2) {
        return 0;
    } else if (section == 3) {
        return 80;
    }
    return 0;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

#pragma mark ZESegmentedsViewDelegate
- (void)selectedZESegmentedsViewItemAtIndex:(NSInteger)selectedItemIndex zeView:(ZESegmentedsView *)zeView {
    if ((zeView.tag - 10000) == 1) {
        self.selectIndexInSection1 = selectedItemIndex;
        
    } else if ((zeView.tag - 10000) == 2) {
    self.selectIndexInSection2 = selectedItemIndex;
    
    }
    [self.tableV reloadSections:[NSIndexSet indexSetWithIndex:zeView.tag - 10000] withRowAnimation:UITableViewRowAnimationNone];
}

@end
