//
//  BasicInfoTableViewController.m
//  Yi_Fei
//
//  Created by maquanhong on 2016/11/28.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "BasicInfoTableViewController.h"
#import "NameValueTableViewCell.h"
#import "TextIconTableViewCell.h"
#import "PureLayout.h"
#import "BUYButton.h"
@interface BasicInfoTableViewController ()
@property (nonatomic, strong) NSArray  *zhCnMenuArray;
@property (nonatomic, strong) NSArray  *enMenuArray;
@property (nonatomic, assign) NSInteger  selectIndex;
@property (nonatomic, strong) NSArray  *showNameValeArray;
@end

@implementation BasicInfoTableViewController
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
    _selectIndex = 0;
    _zhCnMenuArray = @[@"公司LOGO",@"公司名称",@"行业",@"公司规模",@"主营业务",@"主要产品",@"官网",@"地址",@"联系人",@"联系电话",@"Email"];
    _enMenuArray = @[@"Company LOGO",@"Company Name",@"Industry",@"Scale",@"Main Business",@"Main Products",@"Website",@"Address",@"Contacts",@"Tel",@"Email"];
    if (self.selectIndex == 0) {
        self.showNameValeArray = _zhCnMenuArray;
    } else {
        self.showNameValeArray = _enMenuArray;
    }
    UISegmentedControl *control = [[UISegmentedControl alloc] initWithItems:@[@"中文",@"English"]];
    control.selectedSegmentIndex = self.selectIndex;
    [control addTarget:self action:@selector(didSelect:) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = control;
//    [self.navigationItem.titleView addSubview:control];
//    [control autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:0];
//    [control autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
//    [control autoSetDimension:ALDimensionHeight toSize:40];
//    [control autoSetDimension:ALDimensionWidth toSize:80];
    [self.tableView registerClass:[TextIconTableViewCell class] forCellReuseIdentifier:@"TextIcon"];
    [self.tableView registerClass:[NameValueTableViewCell class] forCellReuseIdentifier:@"NameValue"];
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 100)];
    UIButton *btn = [BUYButton creatBtnWithBgColor:BACKCOLOR borderColor:[UIColor lightGrayColor] borderWidth:1 titleColor:[UIColor whiteColor] text:@"保存"];
    btn.frame=CGRectMake(50, 65, WIDTH - 100, 35);
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:btn];
    self.tableView.tableFooterView = bgView;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)btnClick {

}

- (void)didSelect:(UISegmentedControl *)control {
    NSInteger selectIndex = control.selectedSegmentIndex;
    if (selectIndex == self.selectIndex) {
        return;
    }
    self.selectIndex = selectIndex;
    if (self.selectIndex == 0) {
        self.showNameValeArray = _zhCnMenuArray;
    } else {
        self.showNameValeArray = _enMenuArray;
    }
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//warning Incomplete implementation, return the number of rows
    return [self.showNameValeArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        static NSString *identify = @"TextIcon";
        TextIconTableViewCell *cell = (TextIconTableViewCell *)[tableView dequeueReusableCellWithIdentifier:identify forIndexPath:indexPath];
        cell.nameLabel.text = [self.showNameValeArray objectAtIndex:indexPath.row];
        return cell;
    } else {
        static NSString *identify = @"NameValue";
        NameValueTableViewCell *cell = (NameValueTableViewCell *)[tableView dequeueReusableCellWithIdentifier:identify forIndexPath:indexPath];
        cell.nameLabel.text = [self.showNameValeArray objectAtIndex:indexPath.row];
        return cell;
    }

    
    // Configure the cell...
    
    return nil;
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
