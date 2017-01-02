//
//  EditPriceController.m
//  Yi_Fei
//
//  Created by yons on 16/12/16.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "EditPriceController.h"
#import "EditFirstShopCell.h"
#import "UWDatePickerView.h"
#import "OfferPriceList.h"
#import "FooterView.h"
#import "SecondTableViewCell.h"
#import "ThreeViewCell.h"
#import "FourViewCell.h"

@interface EditPriceController ()<UITableViewDelegate,UITableViewDataSource,FourViewCellDelegate,UITextFieldDelegate,UITextViewDelegate,EditSelectViewCellDelegate,SSPopupDelegate,UWDatePickerViewDelegate,SelectOneViewDelegate,FooterViewDelegate>{
    
    UWDatePickerView *_pickerView;
    EditFirstShopCell *firstCell;
    EditSelectViewCell *secondCell;
    EditSelectOneViewCell *threeCell;
    SelectOneView  *fourOneCell;
    SelectTwoView  *fourTwoCell;
    ThreeViewCell  *fiveCell;
    SecondTableViewCell *sixCell;
    FourViewCell  *sevenCell;
    NSInteger _index;
    NSInteger _flag;
    OfferPriceList *_manager;
    NSInteger _clickNum;
    NSInteger _number;
    NSInteger _num;
    
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

@implementation EditPriceController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = INTERFACECOLOR;
    [self setNav];
    _flag = 0;
    _index = 1;
    _clickNum = 0;
    _number = 0;
    _num = [_model.flag integerValue];
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


- (void)setNav {
    self.navigationItem.title = @"报价清单";
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
    
    OfferPriceList *manager = [OfferPriceList defaultManager];
    [manager updateDataModel:_model number:_model.ind];
    [self.navigationController popViewControllerAnimated:YES];
    
}


#pragma Mark -->tableVie的代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 7;
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
        return _index;
    }else if (section == 4) {
        return 2;
    }else if (section == 5) {
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
        [self getTypeTwoFromModel:threeCell.typeOne ];
        return threeCell;
    }else if (indexPath.section == 3){
        if (indexPath.row == 0) {
            static NSString *identifer7 =@"addOneCell";
            fourOneCell = [tableView dequeueReusableCellWithIdentifier:identifer7];
            if (fourOneCell == nil) {
                fourOneCell = [[SelectOneView alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer7];
            }
            fourOneCell.delegate = self;
            fourOneCell.typeLabel.text = @"询价类型";
            fourOneCell.typeOne.nameLabel.text =  @"留样报价";
            [self getTypeViewOneFromModel:fourOneCell.typeOne];
            return fourOneCell;
        }else{
            static NSString *identifer5 =@"addTwoCell";
            fourTwoCell = [tableView dequeueReusableCellWithIdentifier:identifer5];
            if (fourTwoCell == nil) {
                fourTwoCell = [[SelectTwoView alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer5];
            }
            fourTwoCell.delegate = self;
            fourTwoCell.typeLabel.text = @"留样询价";
            fourTwoCell.typeOne.nameLabel.text =@"选择预留询价时间";
            fourTwoCell.typeOne.tag = 6801;
            [self getTypeViewTwoFromModel:fourTwoCell.typeOne];
            return fourTwoCell;
        }
    }else if (indexPath.section == 4){
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
        
    }else if (indexPath.section == 5){
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
            NSArray *arrayimg=[_model.shopPicture componentsSeparatedByString:@"|"];
            NSString *path_document = NSHomeDirectory();
            for (NSInteger i = 0 ; i < arrayimg.count; i++) {
                if (i == 0 ) {
                    //设置一个图片的存储路径
                    NSString *imagePath = [path_document stringByAppendingString:[NSString stringWithFormat:@"/Documents/%@.png",arrayimg[0]]];
                    sevenCell.imageOne.image= [UIImage imageWithContentsOfFile:imagePath];
                }
                if (i == 1 ) {
                    NSString *imagePath = [path_document stringByAppendingString:[NSString stringWithFormat:@"/Documents/%@.png",arrayimg[1]]];
                    sevenCell.imageTwo.image= [UIImage imageWithContentsOfFile:imagePath];
                }
                if (i == 2) {
                    NSString *imagePath = [path_document stringByAppendingString:[NSString stringWithFormat:@"/Documents/%@.png",arrayimg[2]]];
                    sevenCell.imageThree.image= [UIImage imageWithContentsOfFile:imagePath];
                }
                if (i == 3 ) {
                    NSString *imagePath = [path_document stringByAppendingString:[NSString stringWithFormat:@"/Documents/%@.png",arrayimg[3]]];
                    sevenCell.imageFour.image= [UIImage imageWithContentsOfFile:imagePath];
                }
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
    if (indexPath.section == 4) {
        return 100;
    }else if (indexPath.section == 6) {
        return 130;
    }else{
        return 44;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.0000001;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 5) {
        return 44;
    }else{
        return 0.0000001;
    }
}


#pragma mark 自定义组头
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *backView;
    if (section == 5) {
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
          threeCell.textFiled.hidden = NO;
            if (_model.shopAdderss.length > 0) {
            threeCell.textFiled.text = _model.shopAdderss;
            }else{
            threeCell.textFiled.text = @"";
            }
        }
    }else{
        threeCell.typeOne.nameLabel.text = @"EXW";
    }
}


//第四组
-(void)getTypeViewOneFromModel:(ZMJTypeView*)typeView{
    
    
    if ( _num == 1) {
        fourOneCell.typeOne.nameLabel.text =  @"留样报价";
        _index = 1 ;
        NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:3];
        [_tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
        
    }else if (_num == 2){
        fourOneCell.typeOne.nameLabel.text =  @"预留报价";
        _index = 2 ;
        NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:3];
        [_tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}


-(void)getTypeViewTwoFromModel:(ZMJTypeView*)typeView{
    
    if (_model.time.length > 0) {
        fourTwoCell.typeOne.nameLabel.text = _model.time;
    }else{
        fourTwoCell.typeOne.nameLabel.text = @"选择预留询价时间";
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
            NSLog(@"%@",_model.shopSpecific);
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
        if ([_typeArray[tag] isEqualToString:@"FOB"]) {
            threeCell.textFiled.hidden= NO;
            threeCell.textFiled.delegate = self;
        }else{
            threeCell.textFiled.hidden= YES;
        }
    }];
}




//询价类型
- (void)clicTypeOnekView:(ZMJTypeView *)view{
    
    SSPopup* selection=[[SSPopup alloc]init];
    selection.backgroundColor=[UIColor colorWithWhite:0.00 alpha:1.0];
    selection.index = _askArray.count;
    selection.frame = CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height);
    selection.SSPopupDelegate=self;
    [self.view  addSubview:selection];
    [selection CreateTableview:_askArray withSender:nil  withTitle:nil setCompletionBlock:^(int tag){
        if ([_askArray[tag] isEqualToString:@"预留报价"]) {
            fourOneCell.typeOne.nameLabel.text = @"预留报价";
            _index = 2 ;
            _num = 2;
            NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:3];
            [_tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
            
        }else{
            fourOneCell.typeOne.nameLabel.text = @"留样报价";
            _index = 1 ;
            _num = 1;
            NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:3];
            [_tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
        }
    }];
    
}

#pragma mark 选择预留方式
-(void)clicTypeTwoView:(ZMJTypeView *)view{
    
    _pickerView = [UWDatePickerView instanceDatePickerView];
    _pickerView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    [_pickerView setBackgroundColor:[UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:0.3]];
    _pickerView.delegate = self;
    _pickerView.type = DateTypeOfStart;
    [self.view addSubview:_pickerView];
}




- (void)getSelectDate:(NSString *)date type:(DateType)type {
    switch (type) {
        case DateTypeOfStart:
        {
            fourTwoCell.typeOne.nameLabel.text = date;
            _model.time = date;
        }
            break;
        case DateTypeOfEnd:
            break;
        default:
            break;
    }
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








