

//
//  editViewController.m
//  YiFei
//
//  Created by yangyan on 16/8/30.
//  Copyright © 2016年 yous. All rights reserved.
//

#import "ZMJEditViewController.h"
#import "EditFirstShopCell.h"
#import "EditSecondShopCell.h"
#import "EditThreeShopCell.h"
#import "SecondTableViewCell.h"
#import "EditFourShopCell.h"
#import "MyProductionController.h"
#import "ZMJEditViewController.h"
#import "MyProductionController.h"
#import "ThreeTableViewCell.h"

@interface ZMJEditViewController ()<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UITextFieldDelegate,UITextViewDelegate,EditThreeShopCellDelegate,SSPopupDelegate,UITextFieldDelegate>{
    
    EditFirstShopCell *firstCell;
    EditSecondShopCell *secondCell;
    EditThreeShopCell *threeCell;
    SecondTableViewCell *fourCell;
    ThreeTableViewCell *fiveCell;
    EditFourShopCell *sixCell;
    
    NSInteger _index;
    NSArray *_currencyArray;
    NSArray *_typeArray;
    UIView *_backGroundView;
    NSInteger _number;
    NSInteger _flag;
    NSString *_id;
    NSInteger _clickNum;
    NSString *_picture;
    NSString * _idNum;
    
}

@property(nonatomic,strong)UITableView *tableView; //tableView表格视图
@property(nonatomic,strong)NSArray *nameArray; //存放商品的类型
@property(nonatomic,strong)NSArray *contentArray; //存放商品的类型

//组头
@property (nonatomic,strong)UILabel *nameLabel;
@property (nonatomic,strong)BackButton *selectBtn;
@property (nonatomic,strong)UILabel *fourNameLabel;
@property (nonatomic,strong)UIButton *fourSelectBtn;
@property (nonatomic,strong) UIButton *certainBtn;

//新增加的内容
@property (nonatomic,strong)NSMutableArray *shopCustomType;
@property (nonatomic,strong) NSMutableArray *shopCustomContent;
//照片
@property(copy  ,nonatomic) NSArray *picArray;
@property (nonatomic,strong)NSMutableArray *array;

@property(nonatomic,strong)NSMutableArray *otherArray;
@property(nonatomic,strong)NSArray *customArray;
@property(nonatomic,strong)NSArray *bodyArray;


@end

@implementation ZMJEditViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    _nameArray = @[@"公司货号",@"商品名称",@"商品尺寸",@"商品材质",@"商品颜色",@"商品价格",@"商品备注"];
    _index=0;
    _number = 0;
    _flag = 0;
    _clickNum = 0;
    _idNum = _shopObj.companyID;
    _picture = _shopObj.shopPicture;
    _shopCustomContent = [NSMutableArray array];
     _shopCustomType = [NSMutableArray array];
    _array = [NSMutableArray array];
    NSArray *arrayimg=[_shopObj.shopPicture componentsSeparatedByString:@"|"];
    NSString *path_document = NSHomeDirectory();
    //设置一个图片的存储路径
    for (NSInteger i = 0 ; i < arrayimg.count; i++) {
        NSString *imagePath = [path_document stringByAppendingString:[NSString stringWithFormat:@"/Documents/%@.png",arrayimg[i]]];
        [_array addObject:imagePath];
    }
_customArray =[_shopObj.shopCustom componentsSeparatedByString:@"|"];
_bodyArray = [_shopObj.shopContent componentsSeparatedByString:@"|"];
    self.view.backgroundColor=[UIColor whiteColor];
    [self createnavigationView];
    [self addContentView];
    
}

#pragma mark 创建导航栏
-(void)createnavigationView{
    self.navigationItem.title = @"商品信息修改";
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
    
    _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT-30) style:UITableViewStyleGrouped];
    _tableView.backgroundColor=[UIColor whiteColor];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    [self.view addSubview:_tableView];
    
    UIView *footView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 60)];
    _certainBtn = [[UIButton alloc] init];
    [_certainBtn setTitle:@"确定" forState:UIControlStateNormal];
    [_certainBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _certainBtn.backgroundColor = BACKCOLOR;
    _certainBtn.layer.cornerRadius = 10;
    [footView addSubview:_certainBtn];
    [_certainBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(footView.mas_centerX);
        make.centerY.mas_equalTo(footView.mas_centerY);
        make.leading.mas_equalTo(footView).offset(40);
        make.trailing.mas_equalTo(footView).offset(-40);
    }];
    _tableView.tableFooterView=footView;
    [_certainBtn addTarget:self action:@selector(clickBtnNextController) forControlEvents:UIControlEventTouchUpInside];
    
}

#pragma Mark -->tableVie的代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}
    
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
        if (section == 0) {
            return _nameArray.count;
        }else if (section == 1){
            return 1;
        }else if (section == 2){
            return 1;
        }else if (section == 3){
            if (_clickNum == 1) {
                return _number;
            }else{
            return  _customArray.count;
            }
        }else if (section == 4){
            if (_flag == 1) {
                return 1;
            }else{
                if (_array.count == 0 ) {
                     return 0;
                }else{
                    return 1;
                }
            }
        }else{
            return 0;
        }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

        _tableView.separatorStyle =  UITableViewCellSeparatorStyleNone;
        if (indexPath.section == 0) {
            static NSString *identifer1=@"editFirstCell";
            firstCell  = [tableView dequeueReusableCellWithIdentifier:identifer1];
            if (firstCell == nil) {
                firstCell = [[EditFirstShopCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer1];
            }
            firstCell.nameLabel.text = _nameArray[indexPath.row];
            firstCell.selectionStyle =  UITableViewCellSelectionStyleNone;
            firstCell.textF.delegate = self;
            firstCell.textF.tag = 2300 + indexPath.row;
            [ self setDataFromeModel:firstCell.textF];
            return firstCell;
        }else if (indexPath.section == 1){
            static NSString *identifer2 = @"editSecondCell";
            secondCell  = [tableView dequeueReusableCellWithIdentifier:identifer2];
            if (secondCell == nil) {
                secondCell = [[EditSecondShopCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer2];
            }
            secondCell.titileLabel.text = @"商品简介";
            secondCell.selectionStyle =  UITableViewCellSelectionStyleNone;
            if (_shopObj.shopInfo.length != 0) {
                secondCell.textView.text = _shopObj.shopInfo;
            }else{
                secondCell.textView.text = @"";
            }
            secondCell.textView.delegate = self;
            return secondCell;
        }else if (indexPath.section == 2){
            static NSString *identifer3 = @"editThreeCell";
            threeCell  = [tableView dequeueReusableCellWithIdentifier:identifer3];
            if (threeCell == nil) {
                threeCell = [[EditThreeShopCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer3];
            }
            threeCell.selectionStyle =  UITableViewCellSelectionStyleNone;
            threeCell.delegate = self;
            threeCell.typeOneView.nameLabel.text = _shopObj.shopHuoBi;
            threeCell.typeTwoView.nameLabel.text = _shopObj.shopTiaoK;
            if ([_shopObj.shopTiaoK isEqualToString:@"FOB"]) {
                threeCell.textFThree.hidden = NO;
                threeCell.textFThree.text = _shopObj.shopAdderss;
            }
            return threeCell;
        }else if (indexPath.section == 3){
            static NSString *identifer4=@"editFourCell";
            fourCell  = [tableView dequeueReusableCellWithIdentifier:identifer4];
            if (fourCell == nil) {
                fourCell = [[SecondTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer4];
            }
            if (_clickNum != 1) {
            if ([_customArray[indexPath.row]  isEqualToString:@"ABC"]  ) {
        
            fourCell.textFOne.text  = @"";
                
            }else{
                if ([_customArray[indexPath.row] isKindOfClass:[NSNull class]]) {
                    fourCell.textFOne.text = @"";
                }else{
            fourCell.textFOne.text = _customArray[indexPath.row];
                }
            }
            if ([_bodyArray[indexPath.row]  isEqualToString:@"ABC"]) {
                fourCell.textFTwo.text  = @"";
            }else{
                if ([_bodyArray[indexPath.row] isKindOfClass:[NSNull class]]) {
                fourCell.textFTwo.text = @"";
                }else{
                fourCell.textFTwo.text = _bodyArray[indexPath.row];
                }
            }
        }
            fourCell.selectionStyle = UITableViewCellSeparatorStyleNone;
            fourCell.textFOne.delegate = self;
            fourCell.textFTwo.delegate = self;
            fourCell.textFOne.tag = 2600;
            fourCell.textFTwo.tag = 2601;
            return fourCell;
        }else if (indexPath.section == 4){
    if (_flag == 1) {
        static NSString *identifer5=@"editFiveCell";
        fiveCell = [tableView dequeueReusableCellWithIdentifier:identifer5];
        if (fiveCell == nil) {
            fiveCell = [[ThreeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer5];
        }
        fiveCell.imageArray = [NSArray arrayWithArray:self.picArray];
        [fiveCell.collectionView reloadData];
        return fiveCell;
     }else{
         static NSString *identifer6 = @"editSixCell";
         sixCell = [tableView dequeueReusableCellWithIdentifier:identifer6];
         if (sixCell == nil) {
             sixCell = [[EditFourShopCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer6];
         }
        sixCell.imageArray = [NSArray arrayWithArray:[_array copy]];
          return sixCell;
            }
        }else{
            return nil;
        }
}

#pragma mark 设置参数
-(void)setDataFromeModel:(UITextField*)textFiled{

    switch (textFiled.tag) {
        case 2300:
        {
            if (_shopObj.companyID.length != 0) {
        firstCell.textF.text = _shopObj.companyID;
            }else{
        firstCell.textF.text = @"";
            }
        }
            break;
        case 2301:
        {
        if (_shopObj.shopName.length != 0) {
            firstCell.textF.text = _shopObj.shopName;
        }else{
            firstCell.textF.text = @"";
        }
        }
            break;
        case 2302:
        {
        if (_shopObj.shopSize.length != 0) {
            firstCell.textF.text = _shopObj.shopSize;
        }else{
            firstCell.textF.text = @"";
        }
        }
            break;
        case 2303:
        {
        if (_shopObj.shopMed.length != 0) {
            firstCell.textF.text = _shopObj.shopMed;
        }else{
            firstCell.textF.text = @"";
        }
        }
            break;
        case 2304:
            if (_shopObj.shopColor.length != 0) {
                firstCell.textF.text = _shopObj.shopColor;
            }else{
                firstCell.textF.text = @"";
            }       {
        }
            break;
        case 2305:
        {
            if (_shopObj.shopPrice.length != 0) {
                firstCell.textF.text = _shopObj.shopPrice;
            }else{
                firstCell.textF.text = @"";
            }
        }
            break;
        case 2306:
        {
            if (_shopObj.shopDescribe.length != 0) {
                firstCell.textF.text = _shopObj.shopDescribe;
            }else{
                firstCell.textF.text = @"";
            }
        }
            break;
            
        default:
            break;
    }
}


#pragma mark -----------------------------------
#pragma mark 保存model的设置
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    
    switch (textField.tag) {
        case 2300:
        {
    _shopObj.companyID = textField.text;
        }
            break;
        case 2301:
        {
        _shopObj.shopName = textField.text;
        }
            break;
        case 2302:
        {
    _shopObj.shopSize = textField.text;
        }
            break;
        case 2303:
        {
   _shopObj.shopMed = textField.text;
        }
            break;
        case 2304:
        {
            
     _shopObj.shopColor = firstCell.textF.text;
        }
            break;
        case 2305:
        {
    _shopObj.shopPrice = textField.text;
        }
            break;
        case 2306:
        {
     _shopObj.shopDescribe = textField.text;
        }
            break;
            
        default:
            break;
    }
    return YES;
    
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView{
    _shopObj.shopInfo = textView.text;
    return YES;
}

#pragma mark textView的代理方法
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];//按回车取消第一相应者
    }
    return YES;
}



#pragma mark 设置tableView的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
        if (indexPath.section == 0) {
            return 44;
        }else if (indexPath.section == 1){
            return 120;
        }else if (indexPath.section == 2){
            return 90;
        }else if (indexPath.section == 3){
            return 44;
        }else if (indexPath.section == 4){
        if (_flag == 1) {
            NSInteger count =  self.picArray.count;
            if (count % 4 != 0) {
                return ((WIDTH - 50) / 4 + 10) * (count / 4 + 1);
            }else{
                return ((WIDTH - 50) / 4 + 10) * (count /4);
            }
        }else{
            NSInteger count =  _array.count;
            if (count % 4 != 0) {
                return ((WIDTH - 50) / 4 + 10) * (count / 4 + 1);
            }else{
                return ((WIDTH - 50) / 4 + 10) * (count /4);
            }
        }
        }else{
            return 0;
        }
}



-(void)clickViewTag:(NSInteger)tag{

    _currencyArray = @[@"人民币",@"美元",@"欧元",@"英镑",@"日元"];
    _typeArray = @[@"EXW",@"CFR",@"CIF",@"FOB"];
    switch (tag) {
        case 1300:
        {
        _index = 1300;
            
    SSPopup* selection=[[SSPopup alloc]init];
    selection.backgroundColor=[UIColor colorWithWhite:0.00 alpha:1.0];
    selection.index = _currencyArray.count;
    selection.frame = CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height);
    selection.SSPopupDelegate=self;
    [self.view  addSubview:selection];
    
    [selection CreateTableview:_currencyArray withSender:nil  withTitle:nil setCompletionBlock:^(int tag){
        
        threeCell.typeOneView.nameLabel.text = _currencyArray[tag];
        _shopObj.shopHuoBi = _currencyArray[tag];
    }];
        }
            break;
        case 1301:
        {
        _index = 1301;
    SSPopup* selection=[[SSPopup alloc]init];
    selection.backgroundColor=[UIColor colorWithWhite:0.00 alpha:1.0];
    selection.index = _typeArray.count;
    selection.frame = CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height);
    selection.SSPopupDelegate=self;
    [self.view  addSubview:selection];
    
    [selection CreateTableview:_typeArray withSender:nil  withTitle:nil setCompletionBlock:^(int tag){
        
        threeCell.typeTwoView.nameLabel.text = _typeArray[tag];
        _shopObj.shopTiaoK = _typeArray[tag];
        if ([_typeArray[tag] isEqualToString:@"FOB"]) {
            threeCell.textFThree.hidden= NO;
            threeCell.textFThree.delegate = self;
        }else{
            threeCell.textFThree.hidden= YES;
        }
    }];
        }
            break;
        default:
            break;
    }
}



#pragma mark tableView每组的组头视图设置
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 3) {
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 44)];
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = [UIFont systemFontOfSize:14];
        _nameLabel.text = @"自 定 义";
        [backView addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
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
        return backView;
    }else if ( section == 4){
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 44)];
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = [UIFont systemFontOfSize:14];
        _nameLabel.text = @"产品图片";
        [backView addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(backView).offset(10);
            make.centerY.mas_equalTo(backView.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(60, 20));
        }];
        
        _selectBtn = [[BackButton alloc] init];
        [_selectBtn setTitle:@"上传" forState:UIControlStateNormal];
        _selectBtn.backgroundColor = BACKCOLOR;
        _selectBtn.layer.cornerRadius = 5;
        _selectBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [backView addSubview:_selectBtn];
        [_selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.mas_equalTo(backView).offset(-10);
            make.centerY.mas_equalTo(backView.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(50, 20));
        }];
        [_selectBtn addTarget:self action:@selector(clickUpBtn) forControlEvents:UIControlEventTouchUpInside];
        return backView;
    }else{
        return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 3 ) {
        return 44;
    }else if ( section == 4) {
        return 44;
    }else{
        return 0.001;
    }
}


#pragma mark 增加自定义的cell
-(void)clickBtnView{
    
    _clickNum = 1;
       _number++;
    [_tableView reloadData];
    
}


#pragma UITextField代理
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
          NSLog(@"拼接后的字符串是2===== %@",str);
        _shopObj.shopCustom  =   str;
    
    }else if(textField.tag == 2601){
        if (textField.text.length == 0) {
            str2=[NSString stringWithFormat:@"%@",@"ABC"];
        }else{
            str2 = [NSString stringWithFormat:@"%@",textField.text];
        }
        [_shopCustomContent addObject:str2];
    NSString *str=[_shopCustomContent componentsJoinedByString:@"|"];
     NSLog(@"拼接后的字符串是2===== %@",str);
        _shopObj.shopContent  =   str;
    }
}


#pragma mark 上传的事件
-(void)clickUpBtn{
    
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
        _shopObj.shopPicture=str;
    }];
}


- (void)presentCameraSingle {
    _flag = 1;
    
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
        _shopObj.shopPicture=str;
    }];
}


-(UIImage *)compressOriginalImage:(UIImage *)image toSize:(CGSize)size{
    UIGraphicsBeginImageContext(size);
    
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return scaledImage;
}


#pragma mark 保存数据到数据库
-(void)clickBtnNextController{
    FMDBOneList  *manager = [FMDBOneList defaultManager];
    [manager updateDataModel:_shopObj number:_shopObj.ind];
    [self.navigationController popViewControllerAnimated:YES];
}














@end

































