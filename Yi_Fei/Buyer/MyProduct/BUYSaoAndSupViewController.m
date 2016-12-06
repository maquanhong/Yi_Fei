//
//  BUYSaoAndSupViewController.m
//  YiFei
//
//  Created by yangyan on 16/9/2.
//  Copyright © 2016年 yous. All rights reserved.
//

#import "BUYSaoAndSupViewController.h"
//#import "SaoAndSuplyTableViewCell.h"
#import "newBuyerViewController.h"
@interface BUYSaoAndSupViewController ()

@end

@implementation BUYSaoAndSupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addcontentView];
}

-(void)addcontentView{
    self.imgArray=@[@"saoma.jpg",@"wirte.jpg"];
    self.titleArray=@[@"扫一扫",@"手势添加供应商"];
    self.tableV=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 82) style:UITableViewStylePlain];
    self.tableV.delegate=self;
    self.tableV.dataSource=self;
    self.tableV.rowHeight=41;
    self.tableV.backgroundColor=[UIColor groupTableViewBackgroundColor];
    
        
    [self.view addSubview:self.tableV];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    static NSString *cellIdent=@"cell";
////    SaoAndSuplyTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdent];
////    if (cell==nil) {
////        cell=[[SaoAndSuplyTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdent];
////    }
////    cell.imgV.image=[UIImage imageNamed:self.imgArray[indexPath.row]];
////    cell.titleL.text=self.titleArray[indexPath.row];
//    return cell;
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        
    }else if(indexPath.row==1){
        newBuyerViewController *newBuyerVC=[[newBuyerViewController alloc] init];
        newBuyerVC.view.backgroundColor=[UIColor redColor];
        [self.navigationController pushViewController:newBuyerVC animated:YES];
    }
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
