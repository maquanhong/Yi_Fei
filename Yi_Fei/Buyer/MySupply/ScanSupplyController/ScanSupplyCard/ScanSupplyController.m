//
//  ScanSupplyController.m
//  Yi_Fei
//
//  Created by yons on 16/12/28.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "ScanSupplyController.h"
#import "SupplyList.h"
#import "SupplyModel.h"
#import "EditCardSupplyCell.h"
#import "DicttionAndJSON.h"
#import "BuyerViewController.h"
#import "ScanQrcodeController.h"

@interface ScanSupplyController ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate>
{
    EditCardSupplyCell *cell;
}

//数据源
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSArray  *titleArray;
@property (nonatomic,strong) NSDictionary  *dict;
//model的
@property (nonatomic,strong) NSString  *oneStr;
@property (nonatomic,strong) NSString  *twoStr;
@property (nonatomic,strong) NSString  *threeStr;
@property (nonatomic,strong) NSString  *fourStr;
@property (nonatomic,strong) NSString  *fiveStr;
@property (nonatomic,strong) NSString  *sixStr;
@property (nonatomic,strong) NSString  *sevenStr;
@property (nonatomic,strong) NSString  *eightStr;
//供应商
@property (nonatomic,strong) SupplyList *manager;
@property (nonatomic,strong) SupplyModel *model;




@end

@implementation ScanSupplyController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = INTERFACECOLOR;
    _titleArray = @[@"姓名",@"职位",@"联系电话",@"邮箱",@"公司名称",@"公司地址",@"行业类型"];
    DicttionAndJSON * VC  = [[DicttionAndJSON alloc] init];
    _dict = [VC dictionaryWithJsonString:self.strScan];
    [self setNav];
    [self creatTableView];
    
}


- (void)setNav {
    
    self.title = @"编辑客户";
    UIButton* leftBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setTitle:@"重新扫描" forState:UIControlStateNormal];
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
    
    ScanQrcodeController *myVC = [[ ScanQrcodeController alloc] init];
    for (ScanQrcodeController * controller in self.navigationController.viewControllers) { //遍历
        if ([controller isKindOfClass:[ScanQrcodeController class]]) { //这里判断是否为你想要跳转的页面
            myVC = controller;
        }
    }
    if (myVC) {
        [self.navigationController popToViewController:myVC animated:YES]; //跳转
    }
}


-(void)rightButtonClick{
    
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0.0];
    //打印日期：中间的空格可以用‘at’或‘T’等字符划分
    NSDateFormatter *dateFomtter = [[NSDateFormatter alloc]init];
    [dateFomtter setDateFormat:@ "yyyy-MM-ddHH:mm:ss SSSS" ];
    NSString *strTime=[dateFomtter stringFromDate:date];
    NSString *path_document = NSHomeDirectory();
    //设置一个图片的存储路径
    NSString *imagePath = [path_document stringByAppendingString:[NSString stringWithFormat:@"/Documents/%@.png",strTime]];
    [UIImagePNGRepresentation(self.imgScan) writeToFile:imagePath atomically:YES];
    _eightStr = strTime;
    //获取单例对象
    _manager = [SupplyList  defaultManager];
    _model = [[SupplyModel alloc] init];
    _model.supplyName = _oneStr;
    _model.position = _twoStr;
    _model.phone = _threeStr;
    _model.emailAddress = _fourStr;
    _model.companyName = _fiveStr;
    _model.companyAddress = _sixStr;
    _model.industryType = _sevenStr;
    _model.companyLogo = _eightStr;
    
    if ([_manager isHasDataIDFromTable:_model.phone]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"此用户已添加过"
                                                       delegate:nil
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"确定", nil];
        
        [alert show];
    }else{
        [_manager insertDataModel:_model];
        BuyerViewController *myVC = [[ BuyerViewController alloc] init];
        for (BuyerViewController * controller in self.navigationController.viewControllers) { //遍历
            if ([controller isKindOfClass:[BuyerViewController class]]) { //这里判断是否为你想要跳转的页面
                myVC = controller;
            }
        }
        if (myVC) {
            [self.navigationController popToViewController:myVC animated:YES]; //跳转
        }
    }
}


-(void)creatTableView{
    
    _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
}

#pragma mark tableView的代理
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _titleArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifer = @"EditCardSupplyCell";
    cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"EditCardSupplyCell" owner:self options:nil] lastObject];
    }
    cell.titleLabel.text = _titleArray[indexPath.section];
    if (indexPath.section == 0) {
        if ([_dict[@"link"] isEqualToString:@"0"]) {
            cell.textView.text = @"";
            _oneStr = @"";
        }else{
            cell.textView.text = _dict[@"link"];
            _oneStr = _dict[@"link"];
        }
        cell.textView.delegate = self;
        cell.textView.tag = 1660;
        
    }else if (indexPath.section == 1){
        if ([_dict[@"position"] isEqualToString:@"0"]) {
            cell.textView.text = @"";
            _twoStr = @"";
        }else{
            cell.textView.text = _dict[@"position"];
            _twoStr = _dict[@"position"];
        }
        cell.textView.delegate = self;
        cell.textView.tag = 1661;
    }else if (indexPath.section == 2){
        if ([_dict[@"phone"] isEqualToString:@"0"]) {
            cell.textView.text = @"";
            _threeStr = @"";
        }else{
            cell.textView.text = _dict[@"phone"];
            _threeStr = _dict[@"phone"];
        }
        cell.textView.delegate = self;
        cell.textView.tag = 1662;
    }else if (indexPath.section == 3){
        if ([_dict[@"email"] isEqualToString:@"0"]) {
            cell.textView.text = @"";
            _fourStr  = @"";
        }else{
            cell.textView.text = _dict[@"email"];
            _fourStr  = _dict[@"email"];
        }
        cell.textView.delegate = self;
        cell.textView.tag = 1663;
    }else if (indexPath.section == 4){
        if ([_dict[@"name"] isEqualToString:@"0"]) {
            cell.textView.text = @"";
            _fiveStr = @"";
        }else{
            cell.textView.text = _dict[@"name"];
            _fiveStr = _dict[@"name"];
        }
        cell.textView.delegate = self;
        cell.textView.tag = 1664;
        
    }else if (indexPath.section == 5){
        if ([_dict[@"adderss"] isEqualToString:@"0"]) {
            cell.textView.text = @"";
            _sixStr = @"";
        }else{
            cell.textView.text = _dict[@"adderss"];
            _sixStr = _dict[@"adderss"];
        }
        cell.textView.delegate = self;
        cell.textView.tag = 1665;
    }else if (indexPath.section == 6){
        if ([_dict[@"industry"] isEqualToString:@"0"]) {
            cell.textView.text = @"";
            _sevenStr = @"";
        }else{
            cell.textView.text = _dict[@"industry"];
            _sevenStr = _dict[@"industry"];
        }
        cell.textView.delegate = self;
        cell.textView.tag = 1666;
    }
    return cell;
}


-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *backView  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 10)];
    backView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    return backView;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.0000001;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

#pragma mark 获取自己设置的值
-(void)textViewDidEndEditing:(UITextView *)textView{
    
    switch (textView.tag) {
        case 1660:
        {
            _oneStr = textView.text;
        }
            break;
        case 1661:
        {
            _twoStr = textView.text;
        }
            break;
        case 1662:
        {
            _threeStr = textView.text;
        }
            break;
        case 1663:
        {
            _fourStr = textView.text;
        }
            break;
        case 1664:
        {
            _fiveStr = textView.text;
        }
            break;
        case 1665:
        {
            _sixStr = textView.text;
        }
            break;
        case 1666:
        {
            _sevenStr = textView.text;
        }
            break;
        default:
            break;
    }
}






































@end




















