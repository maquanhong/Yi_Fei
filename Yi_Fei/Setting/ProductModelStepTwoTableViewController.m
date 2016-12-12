//
//  ProductModelStepTwoTableViewController.m
//  Yi_Fei
//
//  Created by maquanhong on 2016/11/29.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "ProductModelStepTwoTableViewController.h"
#import "BUYButton.h"

@interface ProductModelStepTwoTableViewController ()
@property (nonatomic, strong) NSArray *menuArray;
@end

@implementation ProductModelStepTwoTableViewController

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
    self.title = @"商品模板";
    [self setNav];
    _menuArray = @[@"商品尺寸",@"商品重量",@"外箱包装",@"中盒包装"];
 
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 100)];
    UIButton *btn = [BUYButton creatBtnWithBgColor:BACKCOLOR borderColor:[UIColor lightGrayColor] borderWidth:1 titleColor:[UIColor whiteColor] text:@"下一步"];
    btn.frame=CGRectMake(50, 65, WIDTH - 100, 35);
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:btn];
    self.tableView.tableFooterView = bgView;
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//warning Incomplete implementation, return the number of sections
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//warning Incomplete implementation, return the number of rows
    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

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

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
