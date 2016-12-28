
//
//  EditCardController.m
//  Yi_Fei
//
//  Created by yons on 16/12/27.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "EditSupplyCardController.h"
#import "EditCardSupplyCell.h"
#import "DicttionAndJSON.h"
#import "NSDictionary+log.h"
#import "CustomerList.h"
#import "CustomerModel.h"


@interface EditSupplyCardController ()<UITableViewDelegate,UITableViewDataSource>
{
    EditCardSupplyCell *cell;
}
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSArray  *titleArray;
@property (nonatomic,strong) NSMutableDictionary  *dict;


@end

@implementation EditSupplyCardController

- (void)viewDidLoad {
    [super viewDidLoad];
  self.view.backgroundColor = INTERFACECOLOR;
    _titleArray = @[@"姓名",@"职位",@"联系电话",@"邮箱",@"公司地址",@"行业类型"];
    [self getDataFormJson];
    [self setNav];
    [self creatTableView];
}

- (void)setNav {
    self.title = @"扫描";
    UIButton* leftBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setTitle:@"重新拍摄" forState:UIControlStateNormal];
    [leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    leftBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    leftBtn.frame = CGRectMake(0, 0, 60, 25);
    UIBarButtonItem* leftBtnItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    [leftBtn addTarget:self action:@selector(leftButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem =  leftBtnItem ;
    

    UIButton* rightBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setTitle:@"保存" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    rightBtn.frame = CGRectMake(0, 0, 40, 25);
    UIBarButtonItem* rightBtnItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    [rightBtn addTarget:self action:@selector(rightButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem =  rightBtnItem ;
    
}

-(void)leftButtonClick{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)rightButtonClick{
    
    
}

-(void)getDataFormJson{

    GDataXMLDocument *xmlDocument = [[GDataXMLDocument alloc] initWithXMLString:self.str error:nil];
    GDataXMLElement *root = [xmlDocument rootElement];
    NSArray *booksArr= [root children];
    NSArray *bookArr = [booksArr[1] children];
    NSMutableArray *arr = [NSMutableArray array];
    for (NSInteger i = 2; i < bookArr.count - 2; i++) {
        [arr addObject:bookArr[i]];
    }

    for (GDataXMLElement *element in arr) {
        NSArray *arrOne = [element elementsForName:@"n"];
        NSArray *arrTwo = [element elementsForName:@"v"];
        NSString *key = [arrOne[0] stringValue];
        NSString *value = [arrTwo[0] stringValue];
        if (value.length <= 0 ) {
    value = [NSString stringWithFormat:@"%@",[NSNull null]];
        }
    [_dict setObject:value forKey:key];
    }
}


-(void)creatTableView{
    _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT )style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 150)];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 200)];
    imageView.image = self.image;
    [backView addSubview:imageView];
    _tableView.tableHeaderView = backView;
}


#pragma mark tableView的代理
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  _titleArray.count;
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
   static NSString *identifer = @"EditCardSupplyCell";
    cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"EditCardSupplyCell" owner:self options:nil] lastObject];
    }
    cell.titleLabel.text = _titleArray[indexPath.row];
    if (indexPath.row == 0) {
        if ([_dict[@"name"] length] > 0) {
    cell.textFiled.text = _dict[@"name"];
        }
    }else if (indexPath.row == 1){
    if ([_dict[@"jobtitle"] length] > 0) {
        cell.textFiled.text = _dict[@"jobtitle"];
    }
    }else if (indexPath.row == 2){
    if ([_dict[@"tel_mobile"] length] > 0) {
        cell.textFiled.text = _dict[@"tel_mobile"];
    }
    }else if (indexPath.row == 3){
    if ([_dict[@"company"] length] > 0) {
        cell.textFiled.text = _dict[@"company"];
    }
    }else if (indexPath.row == 4){
    if ([_dict[@"email"] length] > 0) {
        cell.textFiled.text = _dict[@"email"];
    }
    }else if (indexPath.row == 5){
    if ([_dict[@"address"] length] > 0) {
        cell.textFiled.text = _dict[@"address"];
    }
    }else if (indexPath.row == 6){
    if ([_dict[@"address"] length] > 0) {
        cell.textFiled.text = _dict[@"address"];
    }
  }
    return cell;
}
















































@end













