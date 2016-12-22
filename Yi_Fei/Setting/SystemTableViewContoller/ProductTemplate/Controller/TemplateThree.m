//
//  TemplateThree.m
//  Yi_Fei
//
//  Created by yons on 16/12/22.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "TemplateThree.h"
#import "FooterView.h"
#import "ThreeOneCell.h"
#import "FourViewCell.h"
#import "SecondTableViewCell.h"
#import "TemplateModel.h"
#import "TemplateList.h"
#import "SystemSettingViewController.h"

@interface TemplateThree ()<UITableViewDelegate,UITableViewDataSource,FooterViewDelegate,ThreeOneCellDelegate,FourViewCellDelegate,UITextFieldDelegate,SSPopupDelegate>
{
    ThreeOneCell *firstCell;
    FourViewCell *secondCell;
    SecondTableViewCell *threeCell;
    NSInteger _index;
}

@property (nonatomic, strong) UITableView  *tableView;
@property (nonatomic, strong) NSArray  *titleArray;
@property (nonatomic, strong) NSArray  *contentArray;
//照片
@property(copy  ,nonatomic) NSArray *picArray;

//新增加的内容
@property (nonatomic,strong)NSMutableArray *shopCustomType;
@property (nonatomic,strong) NSMutableArray *shopCustomContent;


@end


@implementation TemplateThree

- (void)viewDidLoad {
    [super viewDidLoad];
    _titleArray = @[@"货       币",@"价格条款"];
    _contentArray = @[@"美元",@"EXW"];
    _index = 0;
    _shopCustomType = [NSMutableArray array];
    _shopCustomContent = [NSMutableArray array];
    [self createNavigationView];
    [self addViewConstraints];
}

#pragma mark 创建navgationView
-(void)createNavigationView
{
    self.navigationItem.title = @"商品模板";
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
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _tableView.separatorStyle =  UITableViewCellSeparatorStyleNone;
    FooterView *footerView = [[FooterView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 200)];
    [footerView.footerBtn  setTitle:@"保存" forState:UIControlStateNormal];
    footerView.delegate  = self;
    _tableView.tableFooterView = footerView;
}

-(void)clickBtn{
    
    TemplateList *manager = [TemplateList defaultManager];
    [manager insertDataModel:_model];
    SystemSettingViewController *myVC = [[ SystemSettingViewController alloc] init];
    for (SystemSettingViewController * controller in self.navigationController.viewControllers) { //遍历
        if ([controller isKindOfClass:[SystemSettingViewController class]]) { //这里判断是否为你想要跳转的页面
            myVC = controller;
        }
    }
    if (myVC) {
        [self.navigationController popToViewController:myVC animated:YES]; //跳转
    }
}


#pragma mark tableView代理
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 2;
    }else if (section == 1){
        return 1;
    }else{
        return _index;
    }
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        static NSString *identifer = @"firstCell";
        firstCell = [tableView dequeueReusableCellWithIdentifier:identifer];
        if (!firstCell) {
    firstCell = [[ThreeOneCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];;
        }
    firstCell.titleLabel.text = _titleArray[indexPath.row];
    firstCell.typeOne.nameLabel.text = _contentArray[indexPath.row];
    firstCell.typeOne.tag = 8560 + indexPath.row;
    firstCell.textFiled.tag = 7910 + indexPath.row;
    firstCell.textFiled.delegate = self;
    firstCell.delegate = self;
    return firstCell;
    }else if (indexPath.section == 1){
        static NSString *identifer = @"fourCell";
secondCell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (!secondCell) {
    secondCell = [[[NSBundle mainBundle] loadNibNamed:@"FourViewCell" owner:self options:nil]lastObject];
        }
    secondCell.delegate = self;
    [self getImage:self.picArray];
    return secondCell;
    }else if (indexPath.section == 2){
        
    static NSString *identifer3=@"threeCell";
    threeCell  = [tableView dequeueReusableCellWithIdentifier:identifer3];
    if (threeCell == nil) {
        threeCell = [[SecondTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer3];
    }
    threeCell.textFOne.delegate = self;
    threeCell.textFTwo.delegate = self;
    threeCell.textFOne.tag = 2600;
    threeCell.textFTwo.tag = 2601;
    return threeCell;

    }
    return nil;
}

//照片赋值
-(void)getImage:(NSArray*)array{
    
    for (NSInteger i = 0 ; i < array.count; i++) {
        if (i  == 0) {
            [self getDataFromeArray:array num:i];
        }
        if (i == 1){
            [self getDataFromeArray:array num:i];
        }
        if (i == 2){
            [self getDataFromeArray:array num:i];
        }
        if (i == 3){
            [self getDataFromeArray:array num:i];
        }
    }
}

-(void)getDataFromeArray:(NSArray*)array num:(NSInteger)num{
    
    if ([[array objectAtIndex:num] isKindOfClass:[ZZPhoto class]]) {
        //从数组里面把model取出来
        ZZPhoto *photo = [array objectAtIndex:num];
        if (num == 0) {
            secondCell.imageOne.image = photo.originImage;
        }
        if (num == 1) {
            secondCell.imageTwo.image = photo.originImage;
        }
        if (num == 2) {
            secondCell.imageThree.image = photo.originImage;
        }
        if (num == 3) {
            secondCell.imageFour.image = photo.originImage;
        }
        
    }else if([[array objectAtIndex:num] isKindOfClass:[ZZCamera class]]){
        ZZCamera *camera = [array objectAtIndex:num];
        if (num == 0) {
            secondCell.imageOne.image = camera.image;
        }
        if (num == 1) {
            secondCell.imageTwo.image = camera.image;
        }
        if (num == 2) {
            secondCell.imageThree.image = camera.image;
        }
        if (num == 3) {
            secondCell.imageFour.image = camera.image;
        }
    }
}

#pragma mark 高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 44;
    }else if (indexPath.section == 1) {
        if (self.picArray.count == 0) {
            return 50;
        }else{
          return 130;
        }
    }else{
        return 44;
    }
}

#pragma mark tableView每组的组头视图设置
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 2) {
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 44)];
     UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.font = [UIFont systemFontOfSize:14];
        nameLabel.text = @"自 定 义";
        [backView addSubview:nameLabel];
        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(backView).offset(10);
            make.centerY.mas_equalTo(backView.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(60, 20));
        }];
      UIButton  *selectBtn = [[BackButton alloc] init];
        [selectBtn setImage:[UIImage imageNamed:@"tianjia"] forState:UIControlStateNormal];
        [backView addSubview:selectBtn];
        [selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.mas_equalTo(backView).offset(-10);
            make.centerY.mas_equalTo(backView.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(30, 30));
        }];
        [selectBtn addTarget:self action:@selector(clickBtnView) forControlEvents:UIControlEventTouchUpInside];
        UIView *lineV=[[UIView alloc] init];
        lineV.backgroundColor=[UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1.0];
        [backView addSubview:lineV];
        [lineV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(backView);
            make.trailing.mas_equalTo(backView);
            make.bottom.mas_equalTo(backView.mas_bottom);
            make.height.mas_equalTo(1);
        }];
        
        return backView;
    }else{
        return nil;
    }
}


#pragma mark 增加自定义的cell
-(void)clickBtnView{
    _index++;
    [_tableView reloadData];
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 2) {
        return 44;
    }else{
        return 0.0000001;
    }
}


- (void)clickView:(NSInteger)index{

    NSArray *oneArray = @[@"美元",@"欧元",@"英镑",@"日元",@"人民币"];
    NSArray *twoArray = @[@"EXW",@"FOB",@"CFR",@"CIF"];
    
    switch (index) {
        case 8560:
        {
    ZMJTypeView *typeView = [self.view viewWithTag:8560];
    [self createView:oneArray typeView:typeView num:(NSInteger)8560];
        }
            break;
        case 8561:
        {
    ZMJTypeView *typeView = [self.view viewWithTag:8561];
    [self createView:twoArray typeView:typeView num:8561];
        }
            break;
        default:
            break;
    }
}


-(void)createView:(NSArray*)array typeView:(ZMJTypeView*)typeView  num:(NSInteger)num {
    SSPopup* selection=[[SSPopup alloc]init];
    selection.backgroundColor=[UIColor colorWithWhite:0.00 alpha:1.0];
    selection.index = array.count;
    selection.frame = CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height);
    selection.SSPopupDelegate=self;
    [self.view  addSubview:selection];
    [selection CreateTableview:array withSender:nil  withTitle:nil setCompletionBlock:^(int tag){
        typeView.nameLabel.text = array[tag];
        if (num == 8561) {
         UITextField *textF = [self.view viewWithTag:7911];
        if ([array[tag] isEqualToString:@"FOB"]) {
        textF.hidden = NO;
        }else{
         textF.hidden = YES;
        }
        _model.shopHuoBi = array[tag];
        }else{
        _model.shopTiaoK = array[tag];
        }
    }];
}


//编辑结束监听
- (void)textFieldDidEndEditing:(UITextField *)textField{
    NSString *str1;
    NSString *str2;
    if (textField.tag == 2600) {
        if (textField.text.length == 0) {
        str1=[NSString stringWithFormat:@"%@",@"ABC"];
        }else{
            str1=[NSString stringWithFormat:@"%@",textField.text];
        }
        [_shopCustomType addObject:str1];
        NSString *str=[_shopCustomType componentsJoinedByString:@"|"];
        _model.customeTile=str;
    }else if (textField.tag == 2601)  {
        if (textField.text.length == 0) {
            str2=[NSString stringWithFormat:@"%@",@"ABC"];
        }else{
            str2=[NSString stringWithFormat:@"%@",textField.text];
        }
        [_shopCustomContent addObject:str2];
        NSString *str=[_shopCustomContent componentsJoinedByString:@"|"];
        _model.customeContent=str;
    }else if (textField.tag == 7911 ){
        if (textField.text.length > 0) {
            _model.shopAddress = textField.text;
        }else{
           _model.shopAddress = @"";
        }
    }
}


#pragma mark 选取照片
- (void)clickView{

    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"选择" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction * action1 = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self clickPhotoAlbum];
    }];
    
    UIAlertAction * action2 = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self presentCameraSingle];
    }];
    UIAlertAction * action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alert addAction: action1];
    [alert addAction: action2];
    [alert addAction: action3];
    [self presentViewController:alert animated:NO completion:nil];
}

-(void)clickPhotoAlbum{
    ZZPhotoController *photoController = [[ZZPhotoController alloc]init];
    photoController.selectPhotoOfMax = 8;
    //设置相册中完成按钮旁边小圆点颜色。
    //   photoController.roundColor = [UIColor greenColor];
    [photoController showIn:self result:^(id responseObject){
        self.picArray = (NSArray *)responseObject;
        [_tableView reloadData];
        
        NSMutableArray *arrayM=[NSMutableArray array];
        NSMutableArray  *TimeArray=[NSMutableArray array];
        for (int i=0; i< self.picArray.count; i++) {
            //拿到图片
            ZZPhoto *photo = self.picArray[i];
            CGSize  size = CGSizeMake(145, 160);
        UIImage *image = [self compressOriginalImage:photo.originImage toSize:size ];
            NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0.0];
            //打印日期：中间的空格可以用‘at’或‘T’等字符划分
            NSDateFormatter *dateFomtter = [[NSDateFormatter alloc]init];
            [dateFomtter setDateFormat:@ "yyyy-MM-ddHH:mm:ss SSSS" ];
            NSString *strTime=[dateFomtter stringFromDate:date];
            NSString *path_document = NSHomeDirectory();
            //设置一个图片的存储路径
            NSString *imagePath = [path_document stringByAppendingString:[NSString stringWithFormat:@"/Documents/%@.png",strTime]];
            //把图片直接保存到指定的路径（同时应该把图片的路径imagePath存起来，下次就可以直接用来取）
            [TimeArray addObject:strTime];
            [arrayM addObject:imagePath];
            [UIImagePNGRepresentation(image) writeToFile:imagePath atomically:YES];
        }
        NSString *str=[TimeArray componentsJoinedByString:@"|"];
        _model.shopPicture=str;
    }];
}

- (void)presentCameraSingle {
    
    ZZCameraController *cameraController = [[ZZCameraController alloc]init];
    cameraController.takePhotoOfMax = 8;
    cameraController.isSaveLocal = NO;
    [cameraController showIn:self result:^(id responseObject){
        self.picArray = (NSArray *)responseObject;
        [_tableView reloadData];
        NSMutableArray *arrayM=[NSMutableArray array];
        NSMutableArray  *TimeArray=[NSMutableArray array];
        for (int i=0; i< self.picArray.count; i++) {
            //拿到图片
            ZZCamera *camera = self.picArray[i];
            CGSize  size = CGSizeMake(145, 160);
            UIImage *image = [self compressOriginalImage:camera.image toSize:size ];
            NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0.0];
            //打印日期：中间的空格可以用‘at’或‘T’等字符划分
            NSDateFormatter *dateFomtter = [[NSDateFormatter alloc]init];
            [dateFomtter setDateFormat:@ "yyyy-MM-ddHH:mm:ss SSSS" ];
            NSString *strTime=[dateFomtter stringFromDate:date];
            NSString *path_document = NSHomeDirectory();
            //设置一个图片的存储路径
            NSString *imagePath = [path_document stringByAppendingString:[NSString stringWithFormat:@"/Documents/%@.png",strTime]];
            //把图片直接保存到指定的路径（同时应该把图片的路径imagePath存起来，下次就可以直接用来取）
            [TimeArray addObject:strTime];
            [arrayM addObject:imagePath];
            [UIImagePNGRepresentation(image) writeToFile:imagePath atomically:YES];
        }
        NSString *str=[TimeArray componentsJoinedByString:@"|"];
        _model.shopPicture=str;
    }];
}


-(UIImage *)compressOriginalImage:(UIImage *)image toSize:(CGSize)size{
    
    UIGraphicsBeginImageContext(size);
    
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return scaledImage;
}




























@end













