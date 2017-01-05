//
//  CustomerEditController.m
//  Yi_Fei
//
//  Created by yons on 16/12/21.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "CustomerEditController.h"
#import "EditFirstShopCell.h"
#import "FourViewCell.h"
#import "UWDatePickerView.h"
#import "FooterView.h"
#import "SecondTableViewCell.h"
#import "ThreeViewCell.h"
#import "CustomerProductList.h"
#import "UserDefaultManager.h"

@interface CustomerEditController ()<UITableViewDelegate,UITableViewDataSource,FourViewCellDelegate,UITextFieldDelegate,UITextViewDelegate,EditSelectViewCellDelegate,SSPopupDelegate,UWDatePickerViewDelegate,SelectOneViewDelegate,FooterViewDelegate>{
    
    CustomerProductList *_manager;
    UWDatePickerView *_pickerView;
    EditFirstShopCell *firstCell;
    EditSelectViewCell *secondCell;
    EditSelectOneViewCell *threeCell;
    SelectOneView  *fourOneCell;
    SelectTwoView  *fourTwoCell;
    ThreeViewCell  *fiveCell;
    SecondTableViewCell *sixCell;
    FourViewCell  *sevenCell;
    NSInteger _flag;
     NSInteger _clickNum;
     NSInteger _number;
    
}
@property (nonatomic,strong)BackButton *selectBtn;
@property(nonatomic,strong)UITableView *tableView; //tableView表格视图
@property(nonatomic,strong)NSArray *nameArray; //存放商品的类型
@property(nonatomic,strong)NSArray *textViewArray; //输入信息时的框框
@property(nonatomic,strong)NSArray *askArray; //输入信息时的框框
//照片
@property (nonatomic,strong)NSArray *imageArray;
@property(copy  ,nonatomic) NSArray *picArray;
@property(copy  ,nonatomic) NSArray *rmbArray;
@property(copy  ,nonatomic) NSArray *typeArray;
@property(copy  ,nonatomic) NSArray *oneArray;
@property(copy  ,nonatomic) NSArray *twoArray;
//自定义的内容
@property(nonatomic,strong)NSArray *customArray;
@property(nonatomic,strong)NSArray *bodyArray;
@property (nonatomic,strong)NSMutableArray *customType;
@property (nonatomic,strong) NSMutableArray *customContent;

@end

@implementation CustomerEditController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = INTERFACECOLOR;
    [self setNav];
    _flag = 0;
    _clickNum = 0;
    _number = 0;
    _customContent = [NSMutableArray array];
    _customType = [NSMutableArray array];
   _customArray =[_model.shopCustom componentsSeparatedByString:@"|"];
   _bodyArray = [_model.shopContent componentsSeparatedByString:@"|"];
    _rmbArray = @[@"人民币",@"美元",@"欧元",@"英镑",@"日元"];
    _typeArray = @[@"EXW",@"CFR",@"CIF",@"FOB"];
    _nameArray = @[@"公司货号",@"商品名称",@"商品价格",@"商品规格",@"商品材质",@"商品尺寸",@"商品颜色",@"商品数量"];
    _textViewArray = @[@"商品备注",@"商品简介"];
    _askArray = @[@"预留报价",@"留样报价"];
    [self addContentView];
}

#pragma mark 导航栏
- (void)setNav {
    
    self.navigationItem.title = @"商品信息修改";
    BackButton* leftBtn= [BackButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setImage:[UIImage imageNamed:@"fanhui_icon"] forState:UIControlStateNormal];
    leftBtn.frame = CGRectMake(0, 0, 25, 25);
    UIBarButtonItem* leftBtnItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    [leftBtn addTarget:self action:@selector(leftButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem=leftBtnItem;
}

- (void)leftButtonClick {
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
    
FooterView *footerView = [[FooterView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 100)];
    [footerView.footerBtn setTitle:@"保存" forState:UIControlStateNormal];
    footerView.delegate  = self;
    _tableView.tableFooterView = footerView;
}


- (void)clickBtn{

    _manager = [CustomerProductList defaultManager];
    NSString *oneStr = [UserDefaultManager getDataByKey:@"key"];
    NSString *twoStr = [UserDefaultManager getDataByKey:@"name"];
    NSString *threeStr = [UserDefaultManager getDataByKey:@"company"];
    
     if ([oneStr isEqualToString:@"2"]) {
         
     _model.flag = oneStr;
     _model.customerName = twoStr;
     _model.companyName = threeStr;
     NSString *str = [NSString stringWithFormat:@"%d",_model.ind];
     [_manager updateMolde:_model Element:twoStr and:threeStr num:@"2" index:str];
    [self.navigationController popViewControllerAnimated:YES];
         
     }else if ([oneStr isEqualToString:@"1"]){
         
     _model.flag = oneStr;
     _model.customerName = twoStr;
     _model.companyName = threeStr;
     NSString *str = [NSString stringWithFormat:@"%d",_model.ind];
     [_manager updateMolde:_model Element:twoStr and:threeStr num:@"1" index:str];
     [self.navigationController popViewControllerAnimated:YES];

     }
}


#pragma Mark -->tableVie的代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 6;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 8;
    }else if (section == 1) {
        return 1;
    }else if (section == 2) {
        return 1;
    }else if (section == 3) {
            return 2;
    }else if (section == 4) {
        if (_clickNum == 1) {
            return _number;
        }else{
            return _customArray.count;
        }
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
        [self setDataFromeModel:firstCell.textF];
        return firstCell;
    }else if (indexPath.section == 1){
        static NSString *identifer2 =@"editSecondCell";
        secondCell  = [tableView dequeueReusableCellWithIdentifier:identifer2];
        if (secondCell == nil) {
    secondCell = [[EditSelectViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer2];
        }
        secondCell.delegate = self;
        secondCell.typeLabel.text = @"货币类型";
        [self getTypeOneFromModel:secondCell.typeOne];
        return secondCell;
    }else if (indexPath.section == 2){
        static NSString *identifer6 =@"editOneCell";
        threeCell  = [tableView dequeueReusableCellWithIdentifier:identifer6];
        if (threeCell == nil) {
            threeCell = [[EditSelectOneViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer6];
        }
        threeCell.textFiled.delegate = self;
        threeCell.textFiled.tag = 8781 ;
        threeCell.delegate = self;
        threeCell.typeLabel.text = @"价格条款";
        [self getTypeTwoFromModel:threeCell.typeOne];
        return threeCell;
    }else if (indexPath.section == 3){
 
        static NSString *identifer = @"threeCell";
        fiveCell = [tableView dequeueReusableCellWithIdentifier:identifer];
        if (!fiveCell) {
            fiveCell = [[[NSBundle mainBundle] loadNibNamed:@"ThreeViewCell" owner:self options:nil]lastObject];
        }
        fiveCell.textView.delegate = self;
        fiveCell.textView.tag = 8500 +indexPath.row;
        fiveCell.nameLabel.text = _textViewArray[indexPath.row];
        [self  getDataFromeModel:fiveCell.textView];
        return fiveCell;
        
    }else if (indexPath.section == 4){
        static NSString *identifer6 =@"sixCell";
        sixCell  = [tableView dequeueReusableCellWithIdentifier:identifer6];
        if (sixCell == nil) {
            sixCell = [[SecondTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer6];
        }
        if (_clickNum != 1) {
            if ([_customArray[indexPath.row]  isEqualToString:@"ABC"]  ) {
                sixCell.textFOne.text  = @"";
            }else{
                if ([_customArray[indexPath.row] isKindOfClass:[NSNull class]]) {
                    sixCell.textFOne.text = @"";
                }else{
                    sixCell.textFOne.text = _customArray[indexPath.row];
                }
            }
            if ([_bodyArray[indexPath.row]  isEqualToString:@"ABC"]) {
                sixCell.textFTwo.text  = @"";
            }else{
                if ([_bodyArray[indexPath.row] isKindOfClass:[NSNull class]]) {
                    sixCell.textFTwo.text = @"";
                }else{
                    sixCell.textFTwo.text = _bodyArray[indexPath.row];
                }
            }
        }
        sixCell.textFOne.delegate = self;
        sixCell.textFTwo.delegate = self;
        sixCell.textFOne.tag = 2600;
        sixCell.textFTwo.tag = 2601;
        sixCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return sixCell;
    
    }else{
    
        static NSString *identifer = @"fourCell";
        sevenCell = [tableView dequeueReusableCellWithIdentifier:identifer];
        if (!sevenCell) {
    sevenCell = [[[NSBundle mainBundle] loadNibNamed:@"FourViewCell" owner:self options:nil]lastObject];
        }
     sevenCell.setBtn.hidden = NO;
        if (_flag == 0) {
            if (_model.imageOne) {
        sevenCell.imageOne.image = [UIImage imageWithData:_model.imageOne];
            }
            if (_model.imageTwo) {
        sevenCell.imageTwo.image = [UIImage imageWithData:_model.imageTwo];
            }
            if (_model.imageThree) {
        sevenCell.imageThree.image = [UIImage imageWithData:_model.imageThree];
            }
            if (_model.imageFour) {
        sevenCell.imageFour.image = [UIImage imageWithData:_model.imageFour];
            }
        }else{
      [self getImage:self.picArray];
        }
        sevenCell.delegate = self;
        return sevenCell;
    }
}

#pragma mark 最后一组照片
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
            sevenCell.imageOne.image = photo.originImage;
        }
        if (num == 1) {
            sevenCell.imageTwo.image = photo.originImage;
        }
        if (num == 2) {
            sevenCell.imageThree.image = photo.originImage;
        }
        if (num == 3) {
            sevenCell.imageFour.image = photo.originImage;
        }
        
    }else if([[array objectAtIndex:num] isKindOfClass:[ZZCamera class]]){
        ZZCamera *camera = [array objectAtIndex:num];
        if (num == 0) {
            sevenCell.imageOne.image = camera.image;
        }
        if (num == 1) {
            sevenCell.imageTwo.image = camera.image;
        }
        if (num == 2) {
            sevenCell.imageThree.image = camera.image;
        }
        if (num == 3) {
            sevenCell.imageFour.image = camera.image;
        }
    }
}

//高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 3) {
        return 100;
    }else if (indexPath.section == 5) {
        return 130;
    }else{
        return 44;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
        return 0.0000001;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 4) {
        return 44;
    }else{
        return 0.0000001;
    }
}

#pragma mark 自定义组头
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *backView;
    if (section == 4) {
    backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 44)];
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.font = [UIFont systemFontOfSize:14];
        nameLabel.text = @"自 定 义";
        [backView addSubview:nameLabel];
        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(backView).offset(10);
            make.centerY.mas_equalTo(backView.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(60, 20));
        }];
        
        _selectBtn = [[BackButton alloc] init];
        [_selectBtn setImage:[UIImage imageNamed:@"tianjia"] forState:UIControlStateNormal];
        [backView addSubview:_selectBtn];
        [_selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.mas_equalTo(backView).offset(-10);
            make.centerY.mas_equalTo(backView.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(30, 30));
        }];
        [_selectBtn addTarget:self action:@selector(clickBtnView) forControlEvents:UIControlEventTouchUpInside];
    }
  return backView;
}

#pragma mark 增加自定义的cell
-(void)clickBtnView{
    _clickNum = 1;
    _number++;
    [_tableView reloadData];
}


#pragma mark 设置参数
//第一组
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

//第二组
-(void)getTypeOneFromModel:(ZMJTypeView*)typeView{
    
    if (_model.shopHuoBi.length > 0) {
        secondCell.typeOne.nameLabel.text = _model.shopHuoBi;
    }else{
        secondCell.typeOne.nameLabel.text = @"人民币";
    }
}


//第三组
-(void)getTypeTwoFromModel:(ZMJTypeView*)typeView{
    
    if (_model.shopTiaoK.length > 0) {
        threeCell.typeOne.nameLabel.text = _model.shopTiaoK;
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
        threeCell.typeOne.nameLabel.text = @"EXW";
    }
}


//第五组
-(void)getDataFromeModel:(UITextView*)textView{
    
    switch (textView.tag) {
        case 8500:
        {
    if (_model.shopDescribe.length != 0) {
        fiveCell.textView.text = _model.shopDescribe;
    }
        }
            break;
        case 8501:
        {
    if (_model.shopInfo.length != 0) {
        fiveCell.textView.text = _model.shopInfo;
    }
        }
            break;
        default:
            break;
    }
}


#pragma mark 得到值
-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    NSString *str1;
    NSString *str2;
    
    switch (textField.tag) {
        case 2600:
        {
        if (textField.text.length == 0) {
            str1=[NSString stringWithFormat:@"%@",@"ABC"];
        }else{
            str1=[NSString stringWithFormat:@"%@",textField.text];
        }
        [_customType addObject:str1];
        NSString *str=[_customType componentsJoinedByString:@"|"];
        _model.shopCustom  =   str;
        }
            break;
        case 2601:
        {
        if (textField.text.length == 0) {
            str2=[NSString stringWithFormat:@"%@",@"ABC"];
        }else{
            str2 = [NSString stringWithFormat:@"%@",textField.text];
        }
      [_customContent addObject:str2];
      NSString *str=[_customContent componentsJoinedByString:@"|"];
      _model.shopContent  =   str;
        }
            break;
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


#pragma mark 货币类型
- (void)clickOneView:(ZMJTypeView *)view{
    
    SSPopup* selection=[[SSPopup alloc]init];
    selection.backgroundColor=[UIColor colorWithWhite:0.00 alpha:1.0];
    selection.index = _rmbArray.count;
    selection.frame = CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height);
    selection.SSPopupDelegate=self;
    [self.view  addSubview:selection];
    [selection CreateTableview:_rmbArray withSender:nil  withTitle:nil setCompletionBlock:^(int tag){
    secondCell.typeOne.nameLabel.text = _rmbArray[tag];
        _model.shopHuoBi = _rmbArray[tag];
    }];
}


#pragma mark 货币条款
- (void)clickTwoView:(ZMJTypeView *)view{
    
    SSPopup* selection=[[SSPopup alloc]init];
    selection.backgroundColor=[UIColor colorWithWhite:0.00 alpha:1.0];
    selection.index = _typeArray.count;
    selection.frame = CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height);
    selection.SSPopupDelegate=self;
    [self.view  addSubview:selection];
    [selection CreateTableview:_typeArray withSender:nil  withTitle:nil setCompletionBlock:^(int tag){
    threeCell.typeOne.nameLabel.text = _typeArray[tag];
    _model.shopTiaoK = _typeArray[tag];
    if ([_typeArray[tag] isEqualToString:@"FOB"]) {
        threeCell.textFiled.hidden= NO;
        threeCell.textFiled.delegate = self;
    }else{
     threeCell.textFiled.hidden= YES;
    }
    }];
}



#pragma mark 选取照片
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
    [photoController showIn:self result:^(id responseObject){
        
        self.picArray = (NSArray *)responseObject;
        [_tableView reloadData];
        for (int i=0; i< self.picArray.count; i++) {
            ZZPhoto *photo = self.picArray[i];
            UIImage *image = photo.originImage;
            if (i ==  0) {
                _model.imageOne  = UIImagePNGRepresentation(image);
            }else if (i == 1){
                _model.imageTwo  = UIImagePNGRepresentation(image);
            }else if ( i == 2){
                _model.imageThree  = UIImagePNGRepresentation(image);
            }else if ( i == 3){
                _model.imageFour  = UIImagePNGRepresentation(image);
            }
        }    }];
}

- (void)presentCameraSingle {
    _flag = 1;
    ZZCameraController *cameraController = [[ZZCameraController alloc]init];
    cameraController.takePhotoOfMax = 4;
    cameraController.isSaveLocal = NO;
    [cameraController showIn:self result:^(id responseObject){
        self.picArray = [NSArray array];
        self.picArray = (NSArray *)responseObject;
        for (int i=0; i< self.picArray.count; i++) {
             ZZCamera *camera = self.picArray[i];
            UIImage *image = camera.image;
            if (i ==  0) {
            _model.imageOne  = UIImagePNGRepresentation(image);
            }else if (i == 1){
            _model.imageTwo  = UIImagePNGRepresentation(image);
            }else if ( i == 2){
            _model.imageThree  = UIImagePNGRepresentation(image);
            }else if ( i == 3){
            _model.imageFour  = UIImagePNGRepresentation(image);
            }
        }
    }];
}


































@end































