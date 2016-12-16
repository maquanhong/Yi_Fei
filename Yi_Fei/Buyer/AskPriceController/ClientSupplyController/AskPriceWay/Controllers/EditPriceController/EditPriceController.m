//
//  EditPriceController.m
//  Yi_Fei
//
//  Created by yons on 16/12/16.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "EditPriceController.h"
#import "EditFirstShopCell.h"
#import "EditSelectViewCell.h"
#import "ThreeViewCell.h"
#import "FourViewCell.h"
#import "UWDatePickerView.h"
#import "AskPriceList.h"

@interface EditPriceController ()<UITableViewDelegate,UITableViewDataSource,FourViewCellDelegate,UITextFieldDelegate,UITextViewDelegate,EditSelectViewCellDelegate,SSPopupDelegate,UWDatePickerViewDelegate>{
  UWDatePickerView *_pickerView;
    EditFirstShopCell *firstCell;
    EditSelectViewCell *secondCell;
    ThreeViewCell  *threeCell;
    FourViewCell  *fourCell;
    NSInteger _index;
    NSInteger _flag;
    AskPriceList *_manager;
    
}

@property(nonatomic,strong)UITableView *tableView; //tableView表格视图
@property(nonatomic,strong)NSArray *nameArray; //存放商品的类型
@property(nonatomic,strong)NSArray *typeOneArray; //选择框的类型
@property(nonatomic,strong)NSArray *typeTwoArray; //选择框的类型
@property(nonatomic,strong)NSArray *textViewArray; //输入信息时的框框
@property(nonatomic,strong)NSArray *askArray; //输入信息时的框框
//照片
@property (nonatomic,strong)NSArray *imageArray;
@property(copy  ,nonatomic) NSArray *picArray;
@property(copy  ,nonatomic) NSArray *rmbArray;
@property(copy  ,nonatomic) NSArray *typeArray;
@end

@implementation EditPriceController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setDataFromeModel:firstCell.textF];
    [self getTypeFromModel:secondCell.typeOne];
    [self  getDataFromeModel:threeCell.textView];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    _flag = 0;
    _index = 3;
_rmbArray = @[@"人民币",@"美元",@"欧元",@"英镑",@"日元"];
    _typeArray = @[@"EXW",@"CFR",@"CIF",@"FOB"];
_nameArray = @[@"公司货号",@"商品名称",@"商品价格",@"商品规格",@"商品材质",@"商品尺寸",@"商品颜色",@"商品数量"];
_typeOneArray = @[@"货币类型",@"价格条款",@"询价类型",@"预留时间"];
_typeTwoArray = @[@"人民币",@"EXW",@"留样询价",@"选择预留询价时间"];
_textViewArray = @[@"商品备注",@"商品简介"];
_askArray = @[@"已报价",@"预留报价",@"留样报价"];
    [self createnavigationView];
    [self addContentView];
}

#pragma mark 创建导航栏
-(void)createnavigationView{
    
    self.navigationItem.title = @"编辑";
    BackButton *leftBtn = [[BackButton alloc] initWithFrame:CGRectMake(0, 0, 12, 20)];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"fanhui_icon"] forState:UIControlStateNormal];
    UIBarButtonItem * barItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = barItem;
    [leftBtn addTarget:self action:@selector(leftButtonClick) forControlEvents:UIControlEventTouchUpInside];
}

-(void)leftButtonClick{
    [self.navigationController popViewControllerAnimated:YES];
}


//添加视图
-(void)addContentView{
    
    _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT) style:UITableViewStyleGrouped];
    _tableView.backgroundColor=[UIColor whiteColor];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.separatorStyle =  UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
  UIView *footView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 150)];
  UIButton *certainBtn = [[UIButton alloc] init];
    [certainBtn setTitle:@"保存" forState:UIControlStateNormal];
    [certainBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    certainBtn.backgroundColor = BACKCOLOR;
    certainBtn.layer.cornerRadius = 10;
    [footView addSubview:certainBtn];
    [certainBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(footView.mas_centerX);
        make.centerY.mas_equalTo(footView.mas_centerY);
        make.leading.mas_equalTo(footView).offset(40);
        make.trailing.mas_equalTo(footView).offset(-40);
    }];
    _tableView.tableFooterView=footView;
    [certainBtn addTarget:self action:@selector(clickBtnNext) forControlEvents:UIControlEventTouchUpInside];
}

-(void)clickBtnNext{
    _manager = [AskPriceList defaultManager];
    [_manager updateDataModel:_model number:_model.ind];
    [self.navigationController popViewControllerAnimated:YES];
}



#pragma Mark -->tableVie的代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 8;
    }if (section == 1) {
         return _index;
    }if (section == 2) {
        return 2;
    }else{
        return 1;
    }
  
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  
    if (indexPath.section == 0) {
        static NSString *identifer1=@"editFirstCell";
    firstCell  = [tableView dequeueReusableCellWithIdentifier:identifer1];
    if (firstCell == nil) {
    firstCell = [[EditFirstShopCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer1];
        }
    firstCell.textF.delegate = self;
    firstCell.nameLabel.text = _nameArray[indexPath.row];
    firstCell.selectionStyle =  UITableViewCellSelectionStyleNone;
    firstCell.textF.tag = 2610 + indexPath.row;
        return firstCell;
    }else if (indexPath.section == 1){
        static NSString *identifer2 =@"editSecondCell";
    secondCell  = [tableView dequeueReusableCellWithIdentifier:identifer2];
        if (secondCell == nil) {
    secondCell = [[EditSelectViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer2];
        }
    secondCell.textFiled.delegate = self;
    secondCell.textFiled.tag = 8780 + indexPath.row;
    secondCell.delegate = self;
    secondCell.typeLabel.text = _typeOneArray[indexPath.row];
    secondCell.typeOne.nameLabel.text = _typeTwoArray[indexPath.row];
    secondCell.typeOne.tag = 6700 + indexPath.row;
    return secondCell;
    }else if (indexPath.section == 2){
        static NSString *identifer = @"threeCell";
        threeCell = [tableView dequeueReusableCellWithIdentifier:identifer];
        if (!threeCell) {
            threeCell = [[[NSBundle mainBundle] loadNibNamed:@"ThreeViewCell" owner:self options:nil]lastObject];
        }
    threeCell.textView.delegate = self;
    threeCell.textView.tag = 8500 +indexPath.row;
    threeCell.nameLabel.text = _textViewArray[indexPath.row];
        return threeCell;
    }else {
        static NSString *identifer = @"fourCell";
        fourCell = [tableView dequeueReusableCellWithIdentifier:identifer];
        if (!fourCell) {
            fourCell = [[[NSBundle mainBundle] loadNibNamed:@"FourViewCell" owner:self options:nil]lastObject];
        }
        fourCell.setBtn.hidden = NO;
        if (_flag == 0) {
        NSArray *arrayimg=[_model.shopPicture componentsSeparatedByString:@"|"];
        NSString *path_document = NSHomeDirectory();
        for (NSInteger i = 0 ; i < arrayimg.count; i++) {
            if (i == 0 ) {
                //设置一个图片的存储路径
                NSString *imagePath = [path_document stringByAppendingString:[NSString stringWithFormat:@"/Documents/%@.png",arrayimg[0]]];
                fourCell.imageOne.image= [UIImage imageWithContentsOfFile:imagePath];
            }
            if (i == 1 ) {
                NSString *imagePath = [path_document stringByAppendingString:[NSString stringWithFormat:@"/Documents/%@.png",arrayimg[1]]];
                fourCell.imageTwo.image= [UIImage imageWithContentsOfFile:imagePath];
            }
            if (i == 2) {
                NSString *imagePath = [path_document stringByAppendingString:[NSString stringWithFormat:@"/Documents/%@.png",arrayimg[2]]];
                fourCell.imageThree.image= [UIImage imageWithContentsOfFile:imagePath];
            }
            if (i == 3 ) {
                NSString *imagePath = [path_document stringByAppendingString:[NSString stringWithFormat:@"/Documents/%@.png",arrayimg[3]]];
                fourCell.imageFour.image= [UIImage imageWithContentsOfFile:imagePath];
            }
        }
        }else{
            [self getImage:self.picArray];
        }
               fourCell.delegate = self;
        return fourCell;
    }
}

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
        fourCell.imageOne.image = photo.originImage;
        }
        if (num == 1) {
        fourCell.imageTwo.image = photo.originImage;
        }
        if (num == 2) {
        fourCell.imageThree.image = photo.originImage;
        }
        if (num == 3) {
        fourCell.imageFour.image = photo.originImage;
        }
  
    }else if([[array objectAtIndex:num] isKindOfClass:[ZZCamera class]]){
        ZZCamera *camera = [array objectAtIndex:num];
        if (num == 0) {
            fourCell.imageOne.image = camera.image;
        }
        if (num == 1) {
            fourCell.imageTwo.image = camera.image;
        }
        if (num == 2) {
            fourCell.imageThree.image = camera.image;
        }
        if (num == 3) {
            fourCell.imageFour.image = camera.image;
        }
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 2) {
        return 100;
    }else if (indexPath.section == 3) {
        return 130;
    }else{
        return 44;
    }
}



#pragma mark 设置参数
-(void)setDataFromeModel:(UITextField*)textFiled{
    switch (textFiled.tag) {
        case 2610:
        {
        if (_model.companyID.length != 0) {
            firstCell.textF.text = _model.companyID;
        }else{
            firstCell.textF.text = @"";
        }
        }
            break;
        case 2611:
        {
        if (_model.shopName.length != 0) {
            firstCell.textF.text = _model.shopName;
        }else{
            firstCell.textF.text = @"";
        }
        }
            break;
        case 2612:
        {
        if (_model.shopPrice.length != 0) {
            firstCell.textF.text = _model.shopPrice;
        }else{
            firstCell.textF.text = @"";
        }
        }
            break;
        case 2613:
        {
        if (_model.shopSpecific.length != 0) {
            firstCell.textF.text = _model.shopSpecific;
        }else{
            firstCell.textF.text = @"";
        }
        }
            break;
        case 2614:
        {
        if (_model.shopMed.length != 0) {
            firstCell.textF.text = _model.shopMed;
        }else{
            firstCell.textF.text = @"";
        }
        }
            break;
        case 2615:
        {
        if (_model.shopSize.length != 0) {
            firstCell.textF.text = _model.shopSize;
        }else{
            firstCell.textF.text = @"";
        }
        }
            break;
        case 2616:
        {
        if (_model.shopColor.length != 0) {
            firstCell.textF.text = _model.shopColor;
        }else{
            firstCell.textF.text = @"";
        }
        }
        case 2617:
        {
        if (_model.count.length != 0) {
            firstCell.textF.text = _model.count;
        }else{
            firstCell.textF.text = @"";
        }
        }
            break;
        default:
            break;
    }
}

-(void)getDataFromeModel:(UITextView*)textView{
    switch (textView.tag) {
        case 8500:
        {
    if (_model.shopDescribe.length != 0) {
        threeCell.textView.text = _model.shopDescribe;
    }
        }
            break;
        case 8501:
        {
    if (_model.shopInfo.length != 0) {
        threeCell.textView.text = _model.shopInfo;
    }
        }
            break;
        default:
            break;
    }
}

-(void)getTypeFromModel:(ZMJTypeView*)typeView{
   
    switch (typeView.tag) {
        case 6700:
        {
    if (_model.shopHuoBi.length > 0) {
    secondCell.typeOne.nameLabel.text = _model.shopHuoBi;
    }else{
   secondCell.typeOne.nameLabel.text = @"";
    }
        }
            break;
        case 6701:
        {
    if (_model.shopTiaoK.length > 0) {
        secondCell.typeOne.nameLabel.text = _model.shopTiaoK;
        if ([_model.shopTiaoK isEqualToString:@"FOB"]) {
            UITextField *textField = [self.view viewWithTag:8781];
            textField.hidden = NO;
            if (_model.shopAdderss.length > 0) {
                textField.text = _model.shopAdderss;
            }else{
                textField.text = @"";
            }
        }
    }else{
    secondCell.typeOne.nameLabel.text = @"";
    }
        }
            break;
        case 6702:
        {
    NSInteger flag = [_model.flag integerValue];
            
            NSLog(@"%@",_model.flag);
        if ( flag == 0) {
    secondCell.typeOne.nameLabel.text = _askArray[flag];
        }else if (flag == 1){
    secondCell.typeOne.nameLabel.text = _askArray[flag];
        }else{
    secondCell.typeOne.nameLabel.text = _askArray[flag];
        }
    }
            break;
        case 6703:
        {
    if (_model.time.length > 0) {
    secondCell.typeOne.nameLabel.text = _model.time;
    }else{
    secondCell.typeOne.nameLabel.text = @"选择预留询价时间";
    }
        }
            break;
        default:
            break;
    }
}


#pragma mark 得到值
-(void)textFieldDidEndEditing:(UITextField *)textField{

    switch (textField.tag) {
        case 2610:
        {
   _model.companyID = textField.text;
        }
            break;
        case 2611:
        {
  _model.shopName = textField.text;
        }
            break;
        case 2612:
        {
  _model.shopPrice = textField.text;
        }
            break;
        case 2613:
        {
  _model.shopSpecific = textField.text;
        }
            break;
        case 2614:
        {
  _model.shopMed = textField.text;
        }
            break;
        case 2615:
        {
 _model.shopSize = textField.text;
        }
            break;
        case 2616:
        {
 _model.shopColor = textField.text;
        }
        case 2617:
        {
 _model.count = textField.text;
        }
        case 8781:
        {
 _model.shopAdderss = textField.text;
        }
            break;
        default:
            break;
    }
}

-(void)textViewDidEndEditing:(UITextView *)textView{
    switch (textView.tag) {
        case 8500:
        {
    _model.shopDescribe = textView.text;
        }
            break;
        case 8501:
        {
   _model.shopInfo = textView.text;
        }
            break;
        default:
            break;
    }

}



- (void)clickView:(ZMJTypeView *)view{
    
    switch (view.tag) {
        case 6700:
        {
    SSPopup* selection=[[SSPopup alloc]init];
    selection.backgroundColor=[UIColor colorWithWhite:0.00 alpha:1.0];
    selection.index = _rmbArray.count;
    selection.frame = CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height);
    selection.SSPopupDelegate=self;
    [self.view  addSubview:selection];
    [selection CreateTableview:_rmbArray withSender:nil  withTitle:nil setCompletionBlock:^(int tag){
    ZMJTypeView *typyOne = [self.view viewWithTag:6700];
        typyOne.nameLabel.text = _rmbArray[tag];
    }];
        }
            break;
        case 6701:
        {
    SSPopup* selection=[[SSPopup alloc]init];
    selection.backgroundColor=[UIColor colorWithWhite:0.00 alpha:1.0];
    selection.index = _typeArray.count;
    selection.frame = CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height);
    selection.SSPopupDelegate=self;
    [self.view  addSubview:selection];
    [selection CreateTableview:_typeArray withSender:nil  withTitle:nil setCompletionBlock:^(int tag){
    ZMJTypeView *typyOne = [self.view viewWithTag:6701];
    typyOne.nameLabel.text = _typeArray[tag];
       UITextField *filedOne = [self.view viewWithTag:8781];
    if ([_typeArray[tag] isEqualToString:@"FOB"]) {
        filedOne.hidden= NO;
        filedOne.delegate = self;
    }else{
        filedOne.hidden= YES;
    }
    }];
        }
            break;
        case 6702:
        {
    SSPopup* selection=[[SSPopup alloc]init];
    selection.backgroundColor=[UIColor colorWithWhite:0.00 alpha:1.0];
    selection.index = _askArray.count;
    selection.frame = CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height);
    selection.SSPopupDelegate=self;
    [self.view  addSubview:selection];
    [selection CreateTableview:_askArray withSender:nil  withTitle:nil setCompletionBlock:^(int tag){
        ZMJTypeView *typyOne = [self.view viewWithTag:6702];
        typyOne.nameLabel.text = _askArray[tag];
        NSLog(@"%@",_askArray[tag]);
        if ([_askArray[tag] isEqualToString:@"预留报价"]) {
            _index = 4 ;
            [_tableView reloadData];
        }else{
            _index = 3 ;
        [_tableView reloadData];
        }
    }];
    }
            break;
        case 6703:
        {
    _pickerView = [UWDatePickerView instanceDatePickerView];
    _pickerView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    [_pickerView setBackgroundColor:[UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:0.3]];
    _pickerView.delegate = self;
    _pickerView.type = DateTypeOfStart;
    [self.view addSubview:_pickerView];
        }
            break;
        default:
            break;
    }
}

- (void)getSelectDate:(NSString *)date type:(DateType)type {
    switch (type) {
        case DateTypeOfStart:
        {
    ZMJTypeView *typeView = [self.view viewWithTag:6703];
    typeView.nameLabel.text = date;
            _model.time = date;
        }
            break;
        case DateTypeOfEnd:
            break;
        default:
            break;
    }
}



























-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *backView = [[UIView alloc] initWithFrame:CGRectZero];
    return backView;
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *backView = [[UIView alloc] initWithFrame:CGRectZero];
    return backView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.000001;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.000001;
}





- (void)clickView{
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"选择" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction * action1 = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self clickPhotoAlbum];
    }];
    
    UIAlertAction * action2 = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        _flag = 1;
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
    
    _flag = 1;
    ZZPhotoController *photoController = [[ZZPhotoController alloc]init];
    photoController.selectPhotoOfMax = 4;
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
    _flag = 1;
    
    ZZCameraController *cameraController = [[ZZCameraController alloc]init];
    cameraController.takePhotoOfMax = 4;
    cameraController.isSaveLocal = NO;
    [cameraController showIn:self result:^(id responseObject){
        self.picArray = [NSArray array];
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








