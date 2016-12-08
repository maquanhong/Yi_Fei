//
//  BuyerViewController.m
//  YiFei
//
//  Created by yangyan on 16/8/30.
//  Copyright © 2016年 yous. All rights reserved.
//

#import "BuyerViewController.h"
#import "ZMJMyProductionCell.h"
#import "BuyerTableViewCell.h"
#import "MySalerViewController.h"
#import "AddSupplyViewController.h"
#import "NewCreateClientTableViewController.h"
@interface BuyerViewController (){
    NSArray *array;
    UIView *addTableV;
}
@property(nonatomic,strong)UISearchController *searchC;
@property (nonatomic, assign) BOOL bShowAddView;
@property (nonatomic, assign) BussinessType type;
@end

@implementation BuyerViewController
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

- (instancetype)initWithTypeId:(BussinessType)type {
    self = [super init];
    if (self) {
        _type = type;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1.0];
    if (self.type == BussinessBuyer) {
       self.title=@"供应商列表";
    } else {
        self.title=@"客户列表";
    }
    
    self.bShowAddView = NO;
    [self setNav];
    [self addContentView];
}




-(void)addContentView{
    array=@[@"易非"];
    self.tableview=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)style:UITableViewStyleGrouped];
    self.tableview.backgroundColor=[UIColor clearColor];
    self.tableview.rowHeight=80;
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self.view addSubview:self.tableview];
    
    //初始化搜索栏
    _searchC = [[UISearchController alloc] initWithSearchResultsController:nil];
    _searchC.searchBar.barTintColor=[UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1.0];
    _searchC.delegate=self;
    //是否隐藏导航
    _searchC.hidesNavigationBarDuringPresentation = NO;
    _searchC.dimsBackgroundDuringPresentation=NO;
    _searchC.searchBar.barStyle=UIBarStyleBlack;
    //自适应
    [_searchC.searchBar sizeToFit];
    //提示信息
    if (self.type == BussinessBuyer) {
        _searchC.searchBar.placeholder = @"请输入供应商或者公司名称";
    } else {
        _searchC.searchBar.placeholder = @"请输入客户或者公司名称";
    }
    
    _searchC.searchBar.showsCancelButton=YES;
    UIButton *canceLBtn = [_searchC.searchBar valueForKey:@"cancelButton"];
    [canceLBtn setTitle:@"取消" forState:UIControlStateNormal];
    [canceLBtn setTitleColor:NAVCOLOR forState:UIControlStateNormal];
    //代理方法
    _searchC.searchResultsUpdater = self;
    _searchC.delegate=self;
    self.tableview.tableHeaderView = _searchC.searchBar;
}


- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {

}

#pragma Mark -- 事件处理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdent=@"cell";
    BuyerTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdent];
    if (cell==nil) {
        cell=[[BuyerTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdent];
    }
    cell.imgV.image=[UIImage imageNamed:@"logo.png"];
    cell.nameShop.text=array[indexPath.row];
    return cell;
}


//添加列表窗口
-(void)rightButtonClick{
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
        NSArray *titleArray;
        if (self.type == BussinessBuyer) {
            titleArray=@[@"扫一扫",@"手动添加供应商"];
        } else {
            titleArray=@[@"扫一扫",@"手动添加客户"];
        }
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
            }
            btn.tag=70+i;
            btn.titleLabel.font=[UIFont systemFontOfSize:15.0];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btn setTitle:titleArray[i] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
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
    

}

-(void)btn2Click:(UIButton *)sender{
    NewCreateClientTableViewController *addSuVC;
    if (self.type == BussinessBuyer) {
        addSuVC=[[NewCreateClientTableViewController alloc] initWithTypeId:BussinessBuyer];
    } else {
        addSuVC=[[NewCreateClientTableViewController alloc] initWithTypeId:BussinessSaler];
    }
    [self.navigationController pushViewController:addSuVC animated:YES];
    [addTableV removeFromSuperview];
}

-(void)leftButtonClick{
    [self.navigationController popViewControllerAnimated:YES];
    [addTableV removeFromSuperview];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MySalerViewController *mySalerVC=[[MySalerViewController alloc] init];
    [self.navigationController pushViewController:mySalerVC animated:YES];
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

@end
