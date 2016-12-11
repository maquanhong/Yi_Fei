//
//  NewCreateClientTableViewController.m
//  Yi_Fei
//
//  Created by maquanhong on 2016/11/20.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "NewCreateClientTableViewController.h"
#import "TextFieldTableViewCell.h"
#import "IndustryTypeTableViewCell.h"
#import "BUYButton.h"
#import "ClientBaseInfo.h"
#import <MBProgressHUD/MBProgressHUD.h>
@interface NewCreateClientTableViewController ()<TextFieldTableViewCellDelegate>
@property (nonatomic, strong) NSArray *menuArray;
@property (nonatomic, assign) BussinessType  type;
@property (nonatomic, strong) NSMutableDictionary  *clientBaseInfoDic;
@property (nonatomic, strong) NSMutableDictionary  *supplyerBaseInfoDic;
@property (nonatomic, strong) NSArray  *keysArray;
@end

@implementation NewCreateClientTableViewController

- (instancetype)initWithTypeId:(BussinessType)type {
    self = [super init];
    if (self) {
        _type = type;
        _clientBaseInfoDic = [NSMutableDictionary dictionary];
        _supplyerBaseInfoDic = [NSMutableDictionary dictionary];
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

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNav];
    if (self.type == BussinessBuyer) {
        self.title = @"新建供应商";
    } else if (self.type == BussinessSaler) {
        self.title = @"新建客户";
    }
    _keysArray = @[@"name",@"company",@"telphone",@"email",@"companyAddress",@"jobType"];
    _menuArray = @[@"姓名",@"公司",@"联系电话",@"邮箱",@"公司地址",@"  行业类型"];
       [self.tableView registerClass:[TextFieldTableViewCell class] forCellReuseIdentifier:@"cell"];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 100)];
    UIButton *btn = [BUYButton creatBtnWithBgColor:BACKCOLOR borderColor:[UIColor lightGrayColor] borderWidth:1 titleColor:[UIColor whiteColor] text:@"保存"];
    btn.frame=CGRectMake(50, 65, WIDTH - 100, 35);
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:btn];
    self.tableView.tableFooterView = bgView;
    
}

- (void)btnClick {
    [self.view endEditing:YES];
    if (self.type == BussinessBuyer) {
        if ([[self.supplyerBaseInfoDic allKeys] count] != [self.keysArray count]) {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.mode = MBProgressHUDModeText;
            [hud.label setText:@"信息不完整"];
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                [MBProgressHUD hideHUDForView:self.view animated:YES];
            });
        } else {
            
        }
        
    } else if (self.type == BussinessSaler) {
        if ([[self.clientBaseInfoDic allKeys] count] != [self.keysArray count]) {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.mode = MBProgressHUDModeText;
            [hud.label setText:@"信息不完整"];
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                [MBProgressHUD hideHUDForView:self.view animated:YES];
            });
        } else {
            ClientBaseInfo *baseInfo = [ClientBaseInfo objectWithDictionary:self.clientBaseInfoDic];
            [baseInfo save];
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.mode = MBProgressHUDModeText;
            [hud.label setText:@"正在保存"];
            while (baseInfo.isSaving) {
                [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
            }
            [hud.label setText:@"保存成功"];
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                [self.navigationController popViewControllerAnimated:YES];
            });
        }
        
    }
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [self.menuArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identify = @"cell";
    TextFieldTableViewCell *cell = (TextFieldTableViewCell *)[tableView dequeueReusableCellWithIdentifier:identify forIndexPath:indexPath];
    if (!cell) {
        cell = [[TextFieldTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    cell.titleLabel.text = [self.menuArray objectAtIndex:indexPath.row];
    cell.delegate = self;
    return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

#pragma mark TextFieldTableViewCellDelegate
/*
 @"clientId",
 @"company",
 @"telphone",
 @"email",
 @"companyAddress",
 @"jobType"
 */
- (void)textDidChange:(NSString *)text inCell:(TextFieldTableViewCell *)cell {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    NSString *key = [self.keysArray objectAtIndex:indexPath.row];
    if (self.type == BussinessBuyer) {
        if (text.length == 0) {
            [self.supplyerBaseInfoDic removeObjectForKey:key];
        } else {
            [self.supplyerBaseInfoDic setObject:text forKey:key];
        }
        
    } else if (self.type == BussinessSaler) {
        if (text.length == 0) {
            [self.clientBaseInfoDic removeObjectForKey:key];
        } else {
            [self.clientBaseInfoDic setObject:text forKey:key];
        }
        
    }
    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/










@end











