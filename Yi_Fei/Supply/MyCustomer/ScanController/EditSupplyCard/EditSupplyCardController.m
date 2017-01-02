
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
#import "PackageAPI.h"
#import "SupplyListController.h"

@interface EditSupplyCardController ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate>
{
    EditCardSupplyCell *cell;
    BOOL _isSelect;
}
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSArray  *titleArray;
@property (nonatomic,strong) NSMutableDictionary  *dict;
@property (nonatomic,strong) NSString  *oneStr;
@property (nonatomic,strong) NSString  *twoStr;
@property (nonatomic,strong) NSString  *threeStr;
@property (nonatomic,strong) NSString  *fourStr;
@property (nonatomic,strong) NSString  *fiveStr;
@property (nonatomic,strong) NSString  *sixStr;
@property (nonatomic,strong) NSString  *sevenStr;
@property (nonatomic,strong) NSString  *eightStr;
//供应商
@property (nonatomic,strong) CustomerList *manager;
@property (nonatomic,strong) CustomerModel *model;
//重新拍摄
@property (strong, nonatomic) UIImagePickerController *pick;
@property (nonatomic, copy) NSString *data;
@property (nonatomic, copy) UIImage *imageNext;

@end

@implementation EditSupplyCardController

- (void)viewDidLoad {
    [super viewDidLoad];
  self.view.backgroundColor = INTERFACECOLOR;
    _isSelect = NO;
    _titleArray = @[@"姓名",@"职位",@"联系电话",@"邮箱",@"公司名称",@"公司地址",@"行业类型"];
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
  _isSelect = YES;
  [self callSystemCamral];
}

-(void)rightButtonClick{
    //获取单例对象
    _manager = [CustomerList  defaultManager];
    _model = [[CustomerModel alloc] init];
    _model.customerName = _oneStr;
    _model.position = _twoStr;
    _model.phone = _threeStr;
    _model.emailAddress = _fourStr;
    _model.companyName = _fiveStr;
    _model.companyAddress = _sixStr;
    _model.industryType = _sevenStr;
    _model.companyLogo = _eightStr;
    if ([_manager isHasDataIDFromTable:_model.phone]) {
    [SVProgressHUD showWithStatus:@"此用户已添加"];
    }else{
    [_manager insertDataModel:_model];
    SupplyListController *myVC = [[ SupplyListController alloc] init];
    for (SupplyListController * controller in self.navigationController.viewControllers) { //遍历
        if ([controller isKindOfClass:[SupplyListController class]]) { //这里判断是否为你想要跳转的页面
            myVC = controller;
        }
    }
    if (myVC) {
        [self.navigationController popToViewController:myVC animated:YES]; //跳转
    }
    }
}

-(void)getDataFormJson{

    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0.0];
    //打印日期：中间的空格可以用‘at’或‘T’等字符划分
    NSDateFormatter *dateFomtter = [[NSDateFormatter alloc]init];
    [dateFomtter setDateFormat:@ "yyyy-MM-ddHH:mm:ss SSSS" ];
    NSString *strTime=[dateFomtter stringFromDate:date];
    NSString *path_document = NSHomeDirectory();
    //设置一个图片的存储路径
    NSString *imagePath = [path_document stringByAppendingString:[NSString stringWithFormat:@"/Documents/%@.png",strTime]];
    [UIImagePNGRepresentation(self.image) writeToFile:imagePath atomically:YES];
    _eightStr = strTime;
    
    GDataXMLDocument *xmlDocument = [[GDataXMLDocument alloc] initWithXMLString:self.str error:nil];
    GDataXMLElement *root = [xmlDocument rootElement];
    NSArray *booksArr= [root children];
    NSString *oneTr = [booksArr[0] stringValue] ;
    if ([oneTr isEqualToString:@"OK"]) {
        NSArray *bookArr = [booksArr[1] children];
        NSMutableArray *arr = [NSMutableArray array];
        for (NSInteger i = 2; i < bookArr.count - 2; i++) {
            [arr addObject:bookArr[i]];
        }
        _dict = [NSMutableDictionary dictionary];
        for (GDataXMLElement *element in arr) {
            NSArray *arrOne = [element elementsForName:@"n"];
            NSArray *arrTwo = [element elementsForName:@"v"];
            NSString *key = [arrOne[0] stringValue];
            NSString *value = [arrTwo[0] stringValue];
            if (value.length <= 0 ) {
                value = [NSString stringWithFormat:@"%@",[NSNull null]];
            }else{
                [_dict setObject:value forKey:key];
            }
        }
    }else{
        [self getMessage:oneTr];
    }
     [_tableView reloadData];
}


-(void)creatTableView{
    
    _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT )style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 180)];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 180)];
    if (_isSelect) {
    imageView.image = _imageNext;
    }else{
    imageView.image = self.image;
    }
    [backView addSubview:imageView];
    _tableView.tableHeaderView = backView;
    
}


#pragma mark tableView的代理
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _titleArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  1;
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
   static NSString *identifer = @"EditCardSupplyCell";
    cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"EditCardSupplyCell" owner:self options:nil] lastObject];
    }
    cell.titleLabel.text = _titleArray[indexPath.section];
    if (indexPath.section == 0) {
        if ([_dict[@"name"] length] > 0) {
    cell.textView.text = _dict[@"name"];
    cell.textView.delegate = self;
    cell.textView.tag = 1460;
    _oneStr = _dict[@"name"];
        }
    }else if (indexPath.section == 1){
    if ([_dict[@"jobtitle"] length] > 0) {
        cell.textView.text = _dict[@"jobtitle"];
        cell.textView.delegate = self;
        cell.textView.tag = 1461;
        _twoStr = _dict[@"jobtitle"];
    }
    }else if (indexPath.section == 2){
    if ([_dict[@"tel_mobile"] length] > 0) {
        cell.textView.text = _dict[@"tel_mobile"];
        cell.textView.delegate = self;
        cell.textView.tag = 1462;
        _threeStr = _dict[@"tel_mobile"];
    }
    }else if (indexPath.section == 3){
    if ([_dict[@"email"] length] > 0) {
        cell.textView.text = _dict[@"email"];
        cell.textView.delegate = self;
        cell.textView.tag = 1463;
        _fourStr = _dict[@"email"];
    }
    }else if (indexPath.section == 4){
    if ([_dict[@"company"] length] > 0) {
        cell.textView.text = _dict[@"company"];
        cell.textView.delegate = self;
        cell.textView.tag = 1464;
          _fiveStr =_dict[@"company"];
    }
    }else if (indexPath.section == 5){
    if ([_dict[@"address"] length] > 0) {
        cell.textView.text = _dict[@"address"];
        cell.textView.delegate = self;
        cell.textView.tag = 1465;
        _sixStr =_dict[@"address"];
    }
    }else if (indexPath.section == 6){
    cell.textView.text = @"";
    cell.textView.delegate = self;
    cell.textView.tag = 1466;
    _sevenStr = @"";
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
        case 1460:
        {
    _oneStr = textView.text;
        }
            break;
        case 1461:
        {
      _twoStr = textView.text;
        }
            break;
        case 1462:
        {
      _threeStr = textView.text;
        }
            break;
        case 1463:
        {
     _fourStr = textView.text;
        }
            break;
        case 1464:
        {
    _fiveStr = textView.text;
        }
            break;
        case 1465:
        {
    _sixStr = textView.text;
        }
            break;
        case 1466:
        {
        _sevenStr = textView.text;
        }
            break;
        default:
            break;
    }
}

#pragma mark 提醒功能
-(void)getMessage:(NSString*)str{

    switch ([str integerValue]) {
        case -90:
        {
        [self getData:@"无此接口权限"];
        }
            break;
        case -91:
        {
      [self getData:@"余额不足"];
        }
            break;
        case -92:
        {
    [self getData:@"用户已冻结"];
        }
            break;
        case -98:
        {
     [self getData:@"时间超限"];
        }
            break;
        case -99:
        {
     [self getData:@"验证md5错误"];
        }
            break;
        case -100:
        {
    [self getData:@"用户名或密码错误"];
        }
            break;
        case -101:
        {
      [self getData:@"上传失败"];
        }
            break;
        case -102:
        {
        [self getData:@"文件上传太大"];
        }
            break;
        case -106:
        {
        [self getData:@"请求出现异常"];
        }
            break;
        case -110:
        {
         [self getData:@"识别失败"];
        }
            break;
        default:
            break;
    }


}

-(void)getData:(NSString*)data{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                    message:data
                                                   delegate:nil
                                          cancelButtonTitle:nil
                                          otherButtonTitles:@"确定", nil];
    [alert show];
}








-(void)callSystemCamral{
    _pick = [[UIImagePickerController alloc]init];
    _pick.sourceType = UIImagePickerControllerSourceTypeCamera;
    _pick.delegate = self;
    [self presentViewController:_pick animated:YES completion:nil];
    
}

#pragma mark 代理方法
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    UIImage *image =  [info objectForKey:UIImagePickerControllerOriginalImage];
    if (image) {
        NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0.0];
        //打印日期：中间的空格可以用‘at’或‘T’等字符划分
        NSDateFormatter *dateFomtter = [[NSDateFormatter alloc]init];
        [dateFomtter setDateFormat:@ "yyyy-MM-ddHH:mm:ss SSSS" ];
        NSString *strTime=[dateFomtter stringFromDate:date];
        NSString *path_document = NSHomeDirectory();
        //设置一个图片的存储路径
        NSString *imagePath = [path_document stringByAppendingString:[NSString stringWithFormat:@"/Documents/%@.png",strTime]];
        [UIImagePNGRepresentation(image) writeToFile:imagePath atomically:YES];
        _eightStr = strTime;
        _imageNext = image;
        [self startRec:image];
        
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(void)startRec:(UIImage*)image{
    NSData *sendImageData = UIImageJPEGRepresentation(image, 0.75);
    NSUInteger sizeOrigin = [sendImageData length];
    NSUInteger sizeOriginKB = sizeOrigin / 1024;
    if (sizeOriginKB > 5*1024)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"图片大小超过5M，请重试"
                                                       delegate:nil
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"确定", nil];
        
        [alert show];
        return;
    }
    
    dispatch_source_t timer=dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
    
    dispatch_source_set_timer(timer, dispatch_time(DISPATCH_TIME_NOW, 0ull*NSEC_PER_SEC), DISPATCH_TIME_FOREVER, 1ull*NSEC_PER_SEC);
    
    dispatch_source_set_event_handler(timer, ^{
        PackageAPI *package = [[PackageAPI alloc] init];
        
        self.resultStr = [package uploadPackage:sendImageData andindexPath:0];
        [self performSelectorOnMainThread:@selector(recongnitionResult:) withObject:self.resultStr waitUntilDone:YES];
        dispatch_source_cancel(timer);
    });
    
    dispatch_source_set_cancel_handler(timer, ^{
        
    });
    //启动
    dispatch_resume(timer);
}


-(void)recongnitionResult:(id)sender
{
    _data= sender;
    if ([_data length])
    {
        if ([_data isEqualToString:ERROR_SERVER]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:ERROR_SERVER
                                                           delegate:nil
                                                  cancelButtonTitle:nil
                                                  otherButtonTitles:@"确定", nil];
            
            [alert show];
            return;
        }
        if ([_data isEqualToString:ERROR_TIMEOUT]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:ERROR_TIMEOUT
                                                           delegate:nil
                                                  cancelButtonTitle:nil
                                                  otherButtonTitles:@"确定", nil];
            
            [alert show];
            return;
        }
        if ([_data isEqualToString:ERROR_NULL]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:ERROR_NULL
                                                           delegate:nil
                                                  cancelButtonTitle:nil
                                                  otherButtonTitles:@"确定", nil];
            [alert show];
            return;
        }
    [_pick dismissViewControllerAnimated:YES completion:nil];
        
        GDataXMLDocument *xmlDocument = [[GDataXMLDocument alloc] initWithXMLString:_data error:nil];
        GDataXMLElement *root = [xmlDocument rootElement];
        NSArray *booksArr= [root children];
        NSString *oneTr = [booksArr[0] stringValue] ;
        if ([oneTr isEqualToString:@"OK"]) {
            NSArray *bookArr = [booksArr[1] children];
            NSMutableArray *arr = [NSMutableArray array];
            for (NSInteger i = 2; i < bookArr.count - 2; i++) {
                [arr addObject:bookArr[i]];
            }
            _dict = [NSMutableDictionary dictionary];
            for (GDataXMLElement *element in arr) {
                NSArray *arrOne = [element elementsForName:@"n"];
                NSArray *arrTwo = [element elementsForName:@"v"];
                NSString *key = [arrOne[0] stringValue];
                NSString *value = [arrTwo[0] stringValue];
                if (value.length <= 0 ) {
                    value = [NSString stringWithFormat:@"%@",[NSNull null]];
                }else{
                    [_dict setObject:value forKey:key];
                }
            }
        }else{
            [self getMessage:oneTr];
        }
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 180)];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 180)];
            imageView.image = _imageNext;
        [backView addSubview:imageView];
        _tableView.tableHeaderView = backView;
        [_tableView reloadData];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:ERROR_NULL
                                                       delegate:nil
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"确定", nil];
        
        [alert show];
        return;
    }
}



-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}













@end













