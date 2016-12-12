//
//  MyBuyerViewController.m
//  YiFei
//
//  Created by yangyan on 16/9/2.
//  Copyright © 2016年 yous. All rights reserved.
//

#import "MyBuyerViewController.h"
#import "MyBuyerTableViewCell.h"
#import "MyBuyerInfoTableViewCell.h"
#import "AskPriceTableViewCell.h"
//#import "MyBuyerAskTableViewCell.h"
#import "ClientInfoTableViewCell.h"
#import "NameContentTableViewCell.h"
#import "ZESegmentedsView.h"
#import "OnlyTitleTableViewCell.h"
#import "AddSupplyViewController.h"
#import "NewClientSupplyController.h"
@interface MyBuyerViewController ()<ZESegmentedsViewDelegate>
{
    UIView *addTableV;
}
@property (nonatomic, assign) NSInteger  selectIndexInSection1;
@property (nonatomic, assign) NSInteger  selectIndexInSection2;
@property (nonatomic, assign) BOOL bShowAddView;
@end

@implementation MyBuyerViewController
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
    
    UIBarButtonItem * rightButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(rightButtonClick)];
    self.navigationItem.rightBarButtonItem=rightButton;
    self.automaticallyAdjustsScrollViewInsets=YES;
}

- (void)leftButtonClick {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightButtonClick {
    self.bShowAddView = !self.bShowAddView;
    //获取当前顶层的窗口
    UIWindow *awindow=[[UIApplication sharedApplication].windows lastObject];
    if (self.bShowAddView) {
        addTableV=[[UIView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT)];
        addTableV.backgroundColor=[UIColor clearColor];
        UIView *bgView = [[UIView alloc] initWithFrame:addTableV.bounds];
        bgView.backgroundColor = [UIColor blackColor];
        bgView.alpha = 0.6;
        [addTableV addSubview:bgView];
        [awindow addSubview:addTableV];
        NSArray *imgArray=@[@"saoyisao-.png",@"shoudong.png"];
        NSArray *titleArray=@[@"扫一扫",@"手动添加供应商"];
        for (int i=0; i<2; i++) {
            UIView *backV=[[UIView alloc] init];
            backV.backgroundColor = [UIColor whiteColor];
            [backV sizeToFit];
            backV.frame=CGRectMake(0, 41*i, WIDTH, 41);
            [addTableV addSubview:backV];
            
            UIImageView *imgV=[[UIImageView alloc] init];
            imgV.contentMode = UIViewContentModeCenter;
            imgV.frame=CGRectMake(10, 5, 30, 30);
            imgV.image=[UIImage imageNamed:imgArray[i]];
            [backV addSubview:imgV];
            
            
            UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
            [btn sizeToFit];
            btn.frame=CGRectMake(CGRectGetMaxX(imgV.frame), 5, 70, 30);
            if (i==1) {
                btn.frame=CGRectMake(CGRectGetMaxX(imgV.frame), 5, 130, 30);
                [btn addTarget:self action:@selector(btn2Click:) forControlEvents:UIControlEventTouchUpInside];
            } else {
                [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            }
            btn.tag=70+i;
            btn.titleLabel.font=[UIFont systemFontOfSize:15.0];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btn setTitle:titleArray[i] forState:UIControlStateNormal];
            [backV addSubview:btn];
            
            
            UIView *lineV=[[UIView alloc] init];
            lineV.frame=CGRectMake(0, CGRectGetMaxY(backV.frame) - 1, WIDTH, 1);
            lineV.backgroundColor=[UIColor lightGrayColor];
            [backV addSubview:lineV];
        }
    }else{
        [addTableV removeFromSuperview];
    }

}

-(void)btnClick:(UIButton *)sender{
    
    AddSupplyViewController *addSuVC=[[AddSupplyViewController alloc] init];
    [self.navigationController pushViewController:addSuVC animated:YES];
    [addTableV removeFromSuperview];
}

-(void)btn2Click:(UIButton *)sender{
    NewClientSupplyController *addSuVC=[[NewClientSupplyController alloc] initWithTypeId:BussinessSaler];
    [self.navigationController pushViewController:addSuVC animated:YES];
    [addTableV removeFromSuperview];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"我的客户";
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
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    } else if (section == 1) {
        return 1;
    } else if (section == 2) {
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
        cell.label.text=@"客户C公司的名称";
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
        
    }else{
        
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
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 30)];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = @"客户C";
        return label;
    } else if (section == 1) {
        ZESegmentedsView *segmentView = [[ZESegmentedsView alloc] initWithFrame:CGRectMake(20, 5, WIDTH-40, 30) segmentedCount:3 segmentedTitles:@[@"客户资料",@"交易记录",@"备忘客户爱好"] selectIndex:self.selectIndexInSection1];
        segmentView.delegate = self;
        segmentView.tag = 10000 + section;
        return segmentView;
    } else if (section == 2) {
        ZESegmentedsView *segmentView = [[ZESegmentedsView alloc] initWithFrame:CGRectMake(20, 5, WIDTH-40, 30) segmentedCount:3 segmentedTitles:@[@"最新询价",@"留样询价",@"客户预留询价"] selectIndex:self.selectIndexInSection2];
        segmentView.delegate = self;
        segmentView.tag = 10000 + section;
        return segmentView;
    }
    
    return nil;
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
