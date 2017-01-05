//
//  InfoSendViewController.m
//  YiFei
//
//  Created by maquanhong on 10/23/16.
//  Copyright © 2016 yous. All rights reserved.
//

#import "InfoSendViewController.h"
#import "SendDataViewCell.h"
#import "SupplyOutForm.h"
#import "SendDataTwoViewCell.h"
#import <MessageUI/MessageUI.h>
#import "PeripheralBlueTooth.h"
#import "ParsingController.h"
#import "CreateSupplyPDF.h"
#import "FooterView.h"

@interface InfoSendViewController ()<UITableViewDataSource, UITableViewDelegate,SendDataViewCellDelegate,SendDataTwoViewCellDelegate,MFMailComposeViewControllerDelegate,FooterViewDelegate>
{
    SendDataViewCell *Firstell;
    SendDataTwoViewCell *secondCell;
    NSInteger  _index;
    NSInteger _num;
    NSInteger _pdf;
    NSInteger _flag ;
}

@property (nonatomic, strong) UITableView   *tableView;
@property (nonatomic, strong) NSArray       *sendArray;
@property (nonatomic, strong) NSArray       *dataArray;
@property (nonatomic, strong) NSArray  *TitleArray;

@property (strong, nonatomic) UIButton *btn;

@property (strong, nonatomic) SupplyOutForm *singleForm;
@property (strong, nonatomic) CreateSupplyPDF *createPdf;


@end

@implementation InfoSendViewController

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
-(void)createNavigationView{
    
    self.navigationItem.title = @"商品资料发送";
    BackButton *leftBtn = [[BackButton alloc] initWithFrame:CGRectMake(0, 0, 12, 20)];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"fanhui_icon"] forState:UIControlStateNormal];
    UIBarButtonItem * barItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = barItem;
    [leftBtn addTarget:self action:@selector(leftButtonClick) forControlEvents:UIControlEventTouchUpInside];
}

-(void)leftButtonClick{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark 添加视图
- (void)addViewConstraints {
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.scrollEnabled = NO;
    [self.view addSubview:_tableView];
    
    FooterView *footerView = [[FooterView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 150)];
    [footerView.footerBtn setTitle:@"发送" forState:UIControlStateNormal];
    footerView.delegate  = self;
    _tableView.tableFooterView = footerView;

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
        headView.backgroundColor =  INTERFACECOLOR ;
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
-(void)clickBtn{
    
    if (_index == 1501 && _num == 1600) {  //发送Excel
        _singleForm = [[SupplyOutForm alloc] init];
        _singleForm.shopObjc =  _shopData;
        [_singleForm outExportExcel];
        [self sendExcel:_singleForm.outputFilePath name:_singleForm.outputFileName];
    }else if (_index == 1501 && _num == 1601){  //发送pdf
        _pdf = 1;
        _createPdf = [[CreateSupplyPDF alloc] init];
        _createPdf.shopObjc =  _shopData;
        [_createPdf createPDF];
        [self sendExcel:_createPdf.outputFilePath name:_createPdf.outputFileName];
        
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



- (void)alertWithMessage:(NSString *)str{
    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:str preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alertVC addAction:okAction];
    [self presentViewController:alertVC animated:YES completion:nil];
    
}











@end
































