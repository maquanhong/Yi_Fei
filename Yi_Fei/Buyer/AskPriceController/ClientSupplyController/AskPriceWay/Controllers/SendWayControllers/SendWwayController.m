//
//  SendWwayController.m
//  Yi_Fei
//
//  Created by yons on 16/12/16.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "SendWwayController.h"
#import "SendDataViewCell.h"
#import "SupplyOutForm.h"
#import "SendDataTwoViewCell.h"
#import <MessageUI/MessageUI.h>
#import "PeripheralBlueTooth.h"
#import "ParsingController.h"
#import "CreateSupplyPDF.h"
#import "AskWayController.h"


@interface SendWwayController ()<UITableViewDataSource, UITableViewDelegate,UITextFieldDelegate,UIDocumentInteractionControllerDelegate,SendDataViewCellDelegate,SendDataTwoViewCellDelegate,MFMailComposeViewControllerDelegate,PopViewDelegate>
{
    SendDataViewCell *Firstell;
    SendDataTwoViewCell *secondCell;
    NSInteger  _index;
    NSInteger _num;
    NSInteger _pdf;
    NSInteger _flag ;
}
@property (nonatomic, strong) PopView * selection;
@property (nonatomic, strong) UITableView   *tableView;
@property (nonatomic, strong) NSArray       *sendArray;
@property (nonatomic, strong) NSArray       *dataArray;
@property (nonatomic, strong) NSArray  *TitleArray;
@property (strong, nonatomic) UIDocumentInteractionController *documentController;
@property (strong, nonatomic) SupplyOutForm *singleForm;
@property (strong, nonatomic) CreateSupplyPDF *createPdf;
@property (strong, nonatomic) PeripheralBlueTooth *Peripheral;
@property (strong, nonatomic) UIButton *btn;

@end

@implementation SendWwayController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavigationView];
    _flag = 1;
    _TitleArray = [[NSArray alloc] initWithObjects:@"发送方式",@"资料格式", nil];
    _sendArray  = @[@{@"发送方式":@"蓝牙发送"},@{@"发送方式":@"Email发送"}];
    _dataArray  = @[@{@"发送方式":@"Excel"},@{@"发送方式":@"PDF"}];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self addViewConstraints];
}

#pragma mark 创建navgationView
-(void)createNavigationView
{
    self.navigationItem.title = @"商品资料发送";
    BackButton *leftBtn = [[BackButton alloc] initWithFrame:CGRectMake(0, 0, 12, 20)];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"fanhui_icon"] forState:UIControlStateNormal];
    UIBarButtonItem * barItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = barItem;
    [leftBtn addTarget:self action:@selector(leftButtonClick) forControlEvents:UIControlEventTouchUpInside];
    UIImage *searchimage=[UIImage imageNamed:@"点点"];
    UIBarButtonItem *barbtn=[[UIBarButtonItem alloc] initWithImage:nil style:UIBarButtonItemStyleDone target:self action:@selector(sendExcelOrPDF:)];
    barbtn.image=searchimage;
    self.navigationItem.rightBarButtonItem=barbtn;
}

-(void)leftButtonClick{
    
    AskWayController *myVC = [[ AskWayController alloc] init];
    for (AskWayController * controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[AskWayController class]]) {
            myVC = controller;
        myVC.flag = [NSString stringWithFormat:@"%ld",self.flag];
        }
    }
if (myVC) {
    //跳转
    [self.navigationController popToViewController:myVC animated:YES];
    }
}

#pragma mark 添加视图
- (void)addViewConstraints {
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.scrollEnabled = NO;
    [self.view addSubview:_tableView];
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 120)];
    footerView.userInteractionEnabled = YES;
    _btn = [[UIButton alloc] init];
    [_btn setTitle:@"发送" forState:UIControlStateNormal];
    _btn.layer.cornerRadius = 5;
    _btn.backgroundColor = NAVCOLOR;
    [_btn addTarget:self action:@selector(sendClickBtn:) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:_btn];
    [_btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(footerView).offset(50);
        make.trailing.mas_equalTo(footerView).offset(-50);
        make.centerY.mas_equalTo(footerView.mas_centerY);
        make.height.mas_equalTo(30);
    }];
    _tableView.tableFooterView  = footerView;
    
}

#pragma mark tableView 的代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        static NSString *identifer1 = @"firstCell";
        Firstell  = [tableView dequeueReusableCellWithIdentifier:identifer1];
        if (Firstell == nil) {
            Firstell = [[SendDataViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer1];
        }
        Firstell.delegate = self;
        Firstell.selectionStyle =  UITableViewCellSelectionStyleNone;
        return Firstell;
    }else{
        
        static NSString *identifer2 = @"secondCell";
        secondCell  = [tableView dequeueReusableCellWithIdentifier:identifer2];
        if (secondCell == nil) {
            secondCell = [[SendDataTwoViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer2];
        }
        secondCell.delegate = self;
        secondCell.selectionStyle =  UITableViewCellSelectionStyleNone;
        return secondCell;
    }
}

#pragma mark 点击方法
-(void)clickTwoBtn:(NSInteger)num{
    _num = num;
}

-(void)clickOneBtn:(NSInteger)num{
    _num = num;
}

- (void)clickBloothBtn:(NSInteger)number{
    _index = number;
}

-(void)clickEmailBtn:(NSInteger)number{
    _index = number;
}


#pragma mark cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        UIView *headerOneView =  [self infoSendTableView:_TitleArray[0]];
        return headerOneView  ;
    }else{
        UIView *headerTwoView = [self infoSendTableView:_TitleArray[1]];
        return headerTwoView;
    }
}

#pragma mark tableView的组头
- (UIView *)infoSendTableView:(NSString *)title {
    
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 50)];
    headView.backgroundColor = [UIColor grayColor];
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = title;
    titleLabel.font = [UIFont systemFontOfSize:14];
    [headView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(headView).offset(20);
        make.centerY.mas_equalTo(headView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(100, 20));
    }];
    return headView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.000001;
}

#pragma mark 点击发送按钮
-(void)sendClickBtn:(UIButton*)sender{
    if (_index == 1501 && _num == 1600) {  //发送Excel
      
        
    }else if (_index == 1501 && _num == 1601){  //发送pdf

        
    }else if (_index == 1500 && _num == 1600){
        
 
        
        NSLog(@"发送蓝牙Excel");
    }else if (_index == 1500 && _num == 1601){
        
        
        NSLog(@"发送蓝牙Pdf");
    }
}



#pragma mark 发送邮件
-(void)sendExcel:(NSString *)path name:(NSString*)fileName{
    
    MFMailComposeViewController *mailPicker = [[MFMailComposeViewController alloc] init];
    mailPicker.mailComposeDelegate = self;
    
    //判断能否发送邮件
    if (![MFMailComposeViewController canSendMail]) {
        return ;
    }
    //添加一个Excel附件
    if (_pdf == 1) {
        NSData *pdf = [NSData dataWithContentsOfFile:path];
        [mailPicker addAttachmentData: pdf mimeType: @"" fileName: fileName];
    }else{
        NSData *ExcelFile = [NSData dataWithContentsOfFile:path];
        [mailPicker addAttachmentData:ExcelFile mimeType: @"file/Excel" fileName: fileName];
    }
    [self presentViewController:mailPicker animated:YES completion:nil];
}

#pragma mark - 实现 MFMailComposeViewControllerDelegate
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    //关闭邮件发送窗口
    [self dismissViewControllerAnimated:YES completion:nil];
    NSString *msg;
    switch (result) {
        case MFMailComposeResultCancelled:
            msg = @"用户取消编辑邮件";
            break;
        case MFMailComposeResultSaved:
            msg = @"用户成功保存邮件";
            break;
        case MFMailComposeResultSent:
            msg = @"用户点击发送，将邮件放到队列中，还没发送";
            break;
        case MFMailComposeResultFailed:
            msg = @"用户试图保存或者发送邮件失败";
            break;
        default:
            msg = @"";
            break;
    }
    [self alertWithMessage:msg];
}

- (void)alertWithMessage:(NSString *)str
{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:str preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alertVC addAction:okAction];
    [self presentViewController:alertVC animated:YES completion:nil];
    
}


#pragma mark 利用系统的 -------  发送QQ，微信等等
-(void)sendExcelOrPDF:(UIBarButtonItem*)sender{
    if (_flag == 1) {
        _selection=[[PopView alloc]init];
        _selection.backgroundColor=[UIColor colorWithWhite:0.00 alpha:0.4];
        _selection.frame = CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height);
        _selection.delegate=self;
        [self.view  addSubview:_selection];
        [_selection CreateTableview:nil withSender:sender  withTitle:@"请选择发送方式" setCompletionBlock:^(int tag){
            if (tag == 1230) {
                _singleForm = [[SupplyOutForm alloc] init];
           
                [_singleForm outExportExcel];
                [self sendDataExcelOrPDF:sender path:_singleForm.outputFilePath];
            }else if (tag == 1231){
                _createPdf = [[CreateSupplyPDF alloc] init];
        
                [_createPdf createPDF];
                [self sendDataExcelOrPDF:sender path:_createPdf.outputFilePath];
            }
        }];
        _flag = 0;
    }else{
        [_selection removeFromSuperview];
        _flag = 1;
        
    }
}

#pragma mark 调用系统的发送文件
-(void)sendDataExcelOrPDF:(UIBarButtonItem*)sender path:(NSString*)path{
    NSURL *fileURL = [NSURL fileURLWithPath:path];
    self.documentController = [UIDocumentInteractionController interactionControllerWithURL:fileURL];
    self.documentController.delegate = self;
    [self.documentController presentOptionsMenuFromBarButtonItem:sender animated:YES];
}

#pragma mark - Document Interaction Controller Delegate
- (void)documentInteractionControllerDidDismissOptionsMenu:(UIDocumentInteractionController *)controller {
    if (self.documentController == controller) {
        self.documentController = nil;
    }
}


















@end
















