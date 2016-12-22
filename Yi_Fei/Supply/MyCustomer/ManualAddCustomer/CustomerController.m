//
//  CustomerController.m
//  Yi_Fei
//
//  Created by yons on 16/12/18.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "CustomerController.h"
#import "FirstCell.h"
#import "SecondCell.h"
#import "ThreeCell.h"
#import "FourCell.h"
#import "FiveCell.h"
#import "SixCell.h"
#import "SevenCell.h"
#import "EightCell.h"
#import "NineCell.h"
#import "BUYButton.h"
#import "UserDefaultManager.h"
#import "ParsingFileWorld.h"
#import "IndustryModel.h"
#import "CustomerList.h"
#import "CustomerModel.h"

@interface CustomerController ()<UITextFieldDelegate,UITextViewDelegate,ThreeCellDelegate,SSPopupDelegate,SixCellDelegate,SevenDelegate>
{
    FirstCell  *firstCell;
    SecondCell *secondCell;
    ThreeCell    *threeCell;
    FourCell    *fourCell;
    FiveCell   *fiveCell;
    SixCell  *sixCell;
    SevenCell  *sevenCell;
    EightCell *eightCell;
    NineCell  *nineCell;
    NSInteger _index;
    NSInteger _numberOne;
    NSInteger _numberTwo;
    NSInteger _numberThree;
    NSInteger _indexOne;
    NSInteger _indexTwo;
    
}
@property (nonatomic,strong)ParsingFileWorld *parsingModel;
@property (nonatomic,strong)IndustryModel *industryModel;
@property (nonatomic,strong)CustomerModel *model;
@property (nonatomic,strong)NSMutableArray *eamilArray;
//照片
@property (nonatomic,strong)NSArray *imageArray;
@property(copy  ,nonatomic) NSArray *picArray;
@property (nonatomic,strong)UIImage *logoImage;


@end

@implementation CustomerController

- (void)viewDidLoad {
    [super viewDidLoad];
    _model = [[CustomerModel alloc] init];
    _eamilArray = [NSMutableArray array];
    _index = 0;
    [self setNav];
    [self addContentView];
}


- (void)setNav {
    self.title = @"新建供应商";
    UIButton* leftBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setImage:[UIImage imageNamed:@"fanhui_icon"] forState:UIControlStateNormal];
    leftBtn.frame = CGRectMake(0, 0, 25, 25);
    UIBarButtonItem* leftBtnItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    [leftBtn addTarget:self action:@selector(leftButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem=leftBtnItem;
}
- (void)leftButtonClick {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)addContentView{
    self.tableview=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT )style:UITableViewStyleGrouped];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UIView *footView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 100)];
    UIButton *btn = [BUYButton creatBtnWithBgColor:NAVCOLOR borderColor:[UIColor lightGrayColor] borderWidth:1 titleColor:[UIColor whiteColor] text:@"保存"];
    [btn addTarget:self action:@selector(clickBtnNextController) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(footView.mas_centerX);
        make.centerY.mas_equalTo(footView.mas_centerY);
        make.leading.mas_equalTo(footView).offset(40);
        make.trailing.mas_equalTo(footView).offset(-40);
    }];
    _tableview.tableFooterView=footView;
    [self.view addSubview:_tableview];
}

-(void)clickBtnNextController{
    
    NSString *str2 = [UserDefaultManager getDataByKey:@"twoTF"];
    NSString *str1 = [UserDefaultManager getDataByKey:@"oneTF"];
    if (str1.length > 0 &&str2.length == 0 ) {
        _model.supplyName = str1;
    }
    if (str2.length > 0 && str1.length ==0) {
        _model.supplyName = str2;
    }
    if (str2.length > 0 &&str1.length > 0) {
        _model.supplyName = [NSString stringWithFormat:@"%@%@",str1,str2];
    }
    [self remindView:_model.supplyName  companyName:_model.companyName];
    [UserDefaultManager removeDataWithKey:@"oneTF"];
    [UserDefaultManager removeDataWithKey:@"twoTF"];
    NSMutableArray *address = [NSMutableArray array];
    if (sixCell.typeOneView.nameLabel.text.length > 0) {
        [address addObject:sixCell.typeOneView.nameLabel.text];
    }
    if (sixCell.typeTwoView.nameLabel.text.length > 0) {
        [address addObject:sixCell.typeTwoView.nameLabel.text];
    }
    if (sixCell.typeThreeView.nameLabel.text.length > 0) {
        [address addObject:sixCell.typeThreeView.nameLabel.text];
    }
    if (sixCell.typeFourView.nameLabel.text.length > 0) {
        [address addObject:sixCell.typeFourView.nameLabel.text];
    }
    NSString *str = [UserDefaultManager getDataByKey:@"address"];
    if (str.length > 0) {
        [address addObject:str];
    }
    _model.companyAddress = [address componentsJoinedByString:@"|"];
    NSMutableArray *industry = [NSMutableArray array];
    if (sevenCell.typeOneView.nameLabel.text.length > 0) {
        [industry addObject:sevenCell.typeOneView.nameLabel.text];
    }
    if (sevenCell.typeTwoView.nameLabel.text.length > 0) {
        [industry addObject:sevenCell.typeTwoView.nameLabel.text];
    }
    if (sevenCell.typeThreeView.nameLabel.text.length > 0) {
        [industry addObject:sevenCell.typeThreeView.nameLabel.text];
    }
    NSString *strOne = [UserDefaultManager getDataByKey:@"type"];
    if (strOne.length > 0) {
        [industry addObject:strOne];
    }
    _model.industryType = [industry componentsJoinedByString:@"|"];
    CustomerList  *manager = [CustomerList defaultManager];
    //查询
    if ([manager isHasDataIDFromTable:_model.supplyName]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"此供应商已经添加过" preferredStyle:UIAlertControllerStyleAlert];
        //确定按钮
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:nil] ;
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
    }else if((_model.supplyName.length != 0) && (_model.companyName.length != 0) ) {
        [manager insertDataModel:_model];
        [self.navigationController popViewControllerAnimated:YES];
    }
}


-(void)remindView:(NSString*)name  companyName:(NSString*)companyName{
    
    if (name.length == 0) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"姓或名字不能为空" preferredStyle:UIAlertControllerStyleAlert];
        //确定按钮
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }] ;
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
    }else if (companyName.length == 0){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"公司名称不能为空" preferredStyle:UIAlertControllerStyleAlert];
        //确定按钮
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }] ;
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
        
    }
}


#pragma Mark -- 事件处理
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 9;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section != 4) {
        return 1;
    }else{
        if (_index == 0) {
            return 0;
        }else{
            return _index;
        }
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        static NSString *identifer1=@"firstCell";
        firstCell  = [tableView dequeueReusableCellWithIdentifier:identifer1];
        if (firstCell == nil) {
            firstCell = [[FirstCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer1];
        }
        firstCell.oneTF.delegate = self;
        firstCell.twoTF.delegate = self;
        firstCell.oneTF.tag = 3000;
        firstCell.twoTF.tag = 3001;
        firstCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return firstCell;
    }else if (indexPath.section == 1){
        static NSString *identifer2 = @"secondCell";
        secondCell  = [tableView dequeueReusableCellWithIdentifier:identifer2];
        if (secondCell == nil) {
            secondCell = [[SecondCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer2];
        }
        secondCell.textField.delegate = self;
        secondCell.textField.tag = 3002;
        secondCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return secondCell;
    }else if (indexPath.section == 2){
        static NSString *identifer3 = @"threeCell";
        threeCell  = [tableView dequeueReusableCellWithIdentifier:identifer3];
        if (threeCell == nil) {
            threeCell = [[ThreeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer3];
        }
        threeCell.delegate = self;
        threeCell.typeOneView.nameLabel.text = @"请选择";
        threeCell.textFiled.delegate = self;
        threeCell.textFiled.tag = 3003;
        threeCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return threeCell;
    }else if (indexPath.section == 3){
        static NSString *identifer4 = @"fourCell";
        fourCell = [tableView dequeueReusableCellWithIdentifier:identifer4];
        if (fourCell == nil) {
            fourCell = [[FourCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer4];
        }
        fourCell.selectionStyle = UITableViewCellSelectionStyleNone;
        fourCell.phoneText.tag = 3004;
        fourCell.phoneText.delegate = self;
        return fourCell;
    }else if (indexPath.section == 4){
        static NSString *identifer5 = @"fiveCell";
        fiveCell = [tableView dequeueReusableCellWithIdentifier:identifer5];
        if (fiveCell == nil) {
            fiveCell = [[FiveCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer5];
        }
        fiveCell.selectionStyle = UITableViewCellSelectionStyleNone;
        fiveCell.emailText.tag = 3005;
        fiveCell.emailText.delegate = self;
        return fiveCell;
    }else if (indexPath.section == 5){
        static NSString *identifer6 = @"sixCell";
        sixCell = [tableView dequeueReusableCellWithIdentifier:identifer6];
        if (sixCell == nil) {
            sixCell = [[SixCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer6];
        }
        sixCell.delegate = self;
        sixCell.selectionStyle = UITableViewCellSelectionStyleNone;
        sixCell.addressText.tag = 3006;
        sixCell.addressText.delegate = self;
        return sixCell;
    }else if (indexPath.section == 6){
        static NSString *identifer7 = @"sevenCell";
        sevenCell = [tableView dequeueReusableCellWithIdentifier:identifer7];
        if (sevenCell == nil) {
            sevenCell = [[SevenCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer7];
        }
        sevenCell.delegate = self;
        sevenCell.selectionStyle = UITableViewCellSelectionStyleNone;
        sevenCell.otherText.tag = 3007;
        sevenCell.otherText.delegate = self;
        return sevenCell;
    }else if (indexPath.section == 7){
        static NSString *identifer8 = @"eightCell";
        eightCell = [tableView dequeueReusableCellWithIdentifier:identifer8];
        if (eightCell == nil) {
            eightCell = [[EightCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer8];
        }
        eightCell.selectionStyle = UITableViewCellSelectionStyleNone;
        eightCell.logoImage.image = _logoImage;
        return eightCell;
    }else if (indexPath.section == 8){
        static NSString *identifer9 = @"nineCell";
        nineCell = [tableView dequeueReusableCellWithIdentifier:identifer9];
        if (nineCell == nil) {
            nineCell = [[NineCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer9];
        }
        nineCell.selectionStyle = UITableViewCellSelectionStyleNone;
        nineCell.contenText.tag = 3008;
        nineCell.contenText.delegate = self;
        return nineCell;
    }
    else{
        return nil;
    }
}


- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    switch (textField.tag) {
        case 3000:
        {
            if (textField.text.length > 0) {
                [UserDefaultManager saveDataWithValue:textField.text key:@"oneTF"];
            }else{
                [UserDefaultManager saveDataWithValue:@"" key:@"oneTF"];
            }
        }
            break;
        case 3001:
        {
            if (textField.text.length > 0) {
                [UserDefaultManager saveDataWithValue:textField.text key:@"twoTF"];
            }else{
                [UserDefaultManager saveDataWithValue:@"" key:@"twoTF"];
            }
        }
            break;
        case 3002:
        {
            if (textField.text.length > 0) {
                _model.companyName = textField.text;
            }else{
                _model.companyName = @"";
            }
        }
            break;
        case 3003:
        {
            if (textField.text.length > 0) {
                [UserDefaultManager saveDataWithValue:textField.text key:@"position"];
            }else{
                [UserDefaultManager saveDataWithValue:@"" key:@"position"];
            }
        }
            break;
        case 3004:
        {
            if (textField.text.length > 0) {
                _model.phone = textField.text;
            }else{
                _model.phone = @"";
            }
        }
            break;
        case 3005:
        {
            NSString *str;
            if (textField.text.length == 0) {
                str = [NSString stringWithFormat:@"%@",@""];
            }else{
                str = [NSString stringWithFormat:@"%@",textField.text];
            }
            [_eamilArray addObject:str];
            NSLog(@"%@",_eamilArray);
            NSString *content =[_eamilArray componentsJoinedByString:@"|"];
            _model.emailAddress = content;
            
        }
            break;
        case 3006:
        {
            if (textField.text.length > 0) {
                [UserDefaultManager saveDataWithValue:textField.text key:@"address"];
            }else{
                [UserDefaultManager saveDataWithValue:@"" key:@"address"];
            }
        }
            break;
        case 3007:
        {
            if (textField.text.length > 0) {
                [UserDefaultManager saveDataWithValue:textField.text key:@"type"];
            }else{
                [UserDefaultManager saveDataWithValue:@"" key:@"type"];
            }
        }
            break;
        default:
            break;
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    _model.otherNote = textView.text;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 5) {
        return 110;
    }else if (indexPath.section == 6) {
        return 80;
    }else if (indexPath.section == 8) {
        return 100;
    }else{
        return 44;
    }
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *sectionView ;
    if (section != 4) {
        sectionView = [[UIView  alloc] initWithFrame:CGRectZero];
    }
    return sectionView;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 4) {
        return 44;
    }else{
        return 0.000001;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.000001;
}


#pragma mark tableView每组的组头视图设置
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 44)];
    backView.backgroundColor = [UIColor whiteColor];
    if (section == 4) {
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.font = [UIFont systemFontOfSize:14];
        nameLabel.text = @"邮箱地址";
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
    }
    return backView;
}

-(void)clickBtnView{
    _index++;
    [_tableview reloadData];
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 7) {
        [self clickUpBtn];
    }
}

#pragma mark 上传的事件
-(void)clickUpBtn{
    
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
    photoController.selectPhotoOfMax = 1;
    //设置相册中完成按钮旁边小圆点颜色。
    //   photoController.roundColor = [UIColor greenColor];
    
    [photoController showIn:self result:^(id responseObject){
        self.picArray = (NSArray *)responseObject;
        [_tableview reloadData];
        NSString *strTime;
        for (int i=0; i< self.picArray.count; i++) {
            //拿到图片
            ZZPhoto *photo = self.picArray[i];
            CGSize  size = CGSizeMake(145, 160);
            _logoImage = [self compressOriginalImage:photo.originImage toSize:size ];
            NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0.0];
            //打印日期：中间的空格可以用‘at’或‘T’等字符划分
            NSDateFormatter *dateFomtter = [[NSDateFormatter alloc]init];
            [dateFomtter setDateFormat:@ "yyyy-MM-ddHH:mm:ss SSSS" ];
            strTime = [dateFomtter stringFromDate:date];
            NSString *path_document = NSHomeDirectory();
            //设置一个图片的存储路径
            NSString *imagePath = [path_document stringByAppendingString:[NSString stringWithFormat:@"/Documents/%@.png",strTime]];
            //把图片直接保存到指定的路径（同时应该把图片的路径imagePath存起来，下次就可以直接用来取）
            [UIImagePNGRepresentation(_logoImage) writeToFile:imagePath atomically:YES];
        }
        _model.companyLogo = strTime;
    }];
}

- (void)presentCameraSingle {
    
    ZZCameraController *cameraController = [[ZZCameraController alloc]init];
    cameraController.takePhotoOfMax = 1;
    cameraController.isSaveLocal = NO;
    [cameraController showIn:self result:^(id responseObject){
        self.picArray = [NSArray array];
        self.picArray = (NSArray *)responseObject;
        [_tableview reloadData];
        
        NSString *strTime;
        for (int i=0; i< self.picArray.count; i++) {
            //拿到图片
            ZZCamera *camera = self.picArray[i];
            CGSize  size = CGSizeMake(145, 160);
            _logoImage = [self compressOriginalImage:camera.image toSize:size ];
            NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0.0];
            //打印日期：中间的空格可以用‘at’或‘T’等字符划分
            NSDateFormatter *dateFomtter = [[NSDateFormatter alloc]init];
            [dateFomtter setDateFormat:@ "yyyy-MM-ddHH:mm:ss SSSS" ];
            strTime = [dateFomtter stringFromDate:date];
            NSString *path_document = NSHomeDirectory();
            //设置一个图片的存储路径
            NSString *imagePath = [path_document stringByAppendingString:[NSString stringWithFormat:@"/Documents/%@.png",strTime]];
            //把图片直接保存到指定的路径（同时应该把图片的路径imagePath存起来，下次就可以直接用来取）
            
            [UIImagePNGRepresentation(_logoImage) writeToFile:imagePath atomically:YES];
        }
        _model.companyLogo = strTime;
        
    }];
}

-(UIImage *)compressOriginalImage:(UIImage *)image toSize:(CGSize)size{
    
    UIGraphicsBeginImageContext(size);
    
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return scaledImage;
}


#pragma mark 自定义的选择

- (void)clickViewTag:(NSInteger)tag{
    
    
    switch (tag) {
        case 5500:
        {
            ParsingFileWorld *VC = [[ParsingFileWorld alloc] init];
            NSMutableArray *array = [VC ParsingXMLOne];
            [self getData:[array copy]];
        }
            break;
        case 5501:
        {
            ParsingFileWorld *VC = [[ParsingFileWorld alloc] init];
            NSMutableArray *array = [VC ParsingXMLPrivce:_numberOne];
            [self getProvice:[array copy]];
            
        }
            break;
        case 5502:
        {
            ParsingFileWorld *VC = [[ParsingFileWorld alloc] init];
            NSMutableArray *array = [VC ParsingXMLCity:_numberOne numberTwo:_numberTwo];
            [self getCity:[array copy]];
        }
            break;
        case 5503:
        {
            ParsingFileWorld *VC = [[ParsingFileWorld alloc] init];
            NSMutableArray *array = [VC  ParsingXMLCounty:_numberOne number:_numberTwo number:_numberThree];
            [self getCounty:[array copy]];
            
        }
            break;
            
        default:
            break;
    }
}



- (void)clickViewTag{
    
    NSArray *postionArray = @[@"董事长",@"经理",@"采购",@"销售",@"秘书",@"其他"];
    SSPopup* selection=[[SSPopup alloc]init];
    selection.backgroundColor=[UIColor colorWithWhite:0.00 alpha:1.0];
    selection.index = postionArray.count;
    selection.frame = CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height);
    selection.SSPopupDelegate=self;
    [self.view  addSubview:selection];
    [selection CreateTableview:postionArray withSender:nil  withTitle:nil setCompletionBlock:^(int tag){
        threeCell.typeOneView.nameLabel.text = postionArray[tag];
        _model.position = postionArray[tag];
    }];
    
}


//选择国家
- (void)getData:(NSArray*)array{
    
    SSPopup* selection=[[SSPopup alloc]init];
    selection.backgroundColor=[UIColor colorWithWhite:0.00 alpha:1.0];
    selection.index = array.count;
    selection.frame = CGRectMake(0,64,self.view.frame.size.width,self.view.frame.size.height - 64);
    selection.SSPopupDelegate=self;
    [self.view  addSubview:selection];
    [selection CreateTableview:array withSender:nil  withTitle:nil setCompletionBlock:^(int tag){
        _numberOne = tag;
        if ([array[tag] length] > 0) {
            sixCell.typeOneView.nameLabel.text = array[tag];
        }else{
            sixCell.typeOneView.nameLabel.text = @"";
        }
        
        ParsingFileWorld *VC = [[ParsingFileWorld alloc] init];
        NSString *strOne = [VC ParsingXMLTwoNumber:tag];
        if ([strOne length] > 0) {
            sixCell.typeTwoView.nameLabel.text = strOne;
            sixCell.typeTwoView.userInteractionEnabled = YES;
        }else{
            sixCell.typeTwoView.nameLabel.text = @"";
            sixCell.typeTwoView.userInteractionEnabled = NO;
        }
        
        NSString *strTwo = [VC ParsingXMLThreeNumber:tag];
        if ([strTwo length] > 0) {
            sixCell.typeThreeView.nameLabel.text = strTwo;
        }else{
            sixCell.typeThreeView.nameLabel.text = @"";
        }
        
        NSString *strThree = [VC ParsingXMLFourNumber:tag];
        if ([strThree length] > 0) {
            sixCell.typeFourView.nameLabel.text = strThree;
            sixCell.typeFourView.userInteractionEnabled = YES;
        }else{
            sixCell.typeFourView.nameLabel.text = @"";
            sixCell.typeFourView.userInteractionEnabled = NO;
        }
    }];
}

//选择省份
-(void)getProvice:(NSArray*)array{
    
    SSPopup* selection=[[SSPopup alloc]init];
    selection.backgroundColor=[UIColor colorWithWhite:0.00 alpha:1.0];
    selection.index = array.count;
    selection.frame = CGRectMake(0,64,self.view.frame.size.width,self.view.frame.size.height - 64);
    selection.SSPopupDelegate=self;
    [self.view  addSubview:selection];
    [selection CreateTableview:array withSender:nil  withTitle:nil setCompletionBlock:^(int tag){
        _numberTwo = tag;
        if ([array[tag] length] > 0) {
            sixCell.typeTwoView.nameLabel.text = array[tag];
        }else{
            sixCell.typeTwoView.nameLabel.text = @"";
        }
        ParsingFileWorld *VC = [[ParsingFileWorld alloc] init];
        NSString *strTwo = [VC ParsingXMLCity:_numberOne numberOne:_numberTwo];
        if ([strTwo length] > 0) {
            sixCell.typeThreeView.nameLabel.text = strTwo;
        }else{
            sixCell.typeThreeView.nameLabel.text = @"";
        }
        
        NSString *strThree = [VC ParsingXMLCounty:_numberOne numberOne:_numberTwo];
        if ([strTwo length] > 0) {
            sixCell.typeFourView.nameLabel.text = strThree;
            sixCell.typeFourView.userInteractionEnabled = YES;
        }else{
            sixCell.typeFourView.nameLabel.text = @"";
            sixCell.typeFourView.userInteractionEnabled = NO;
        }
    }];
    
}



//选择市
-(void)getCity:(NSArray*)array{
    
    SSPopup* selection=[[SSPopup alloc]init];
    selection.backgroundColor=[UIColor colorWithWhite:0.00 alpha:1.0];
    selection.index = array.count;
    selection.frame = CGRectMake(0,64,self.view.frame.size.width,self.view.frame.size.height - 64);
    selection.SSPopupDelegate=self;
    [self.view  addSubview:selection];
    [selection CreateTableview:array withSender:nil  withTitle:nil setCompletionBlock:^(int tag){
        _numberThree = tag;
        if ([array[tag] length] > 0) {
            sixCell.typeThreeView.nameLabel.text = array[tag];
        }else{
            sixCell.typeThreeView.nameLabel.text = @"";
        }
        ParsingFileWorld *VC = [[ParsingFileWorld alloc] init];
        NSString *strFour = [VC ParsingXMLCounty:_numberOne numberOne:_numberTwo numberThree:_numberThree];
        if ([strFour length] > 0) {
            sixCell.typeFourView.nameLabel.text = strFour;
            sixCell.typeFourView.userInteractionEnabled = YES;
        }else{
            sixCell.typeFourView.nameLabel.text = @"";
            sixCell.typeFourView.userInteractionEnabled = NO;
        }
    }];
}




-(void)getCounty:(NSArray*)array{
    SSPopup* selection=[[SSPopup alloc]init];
    selection.backgroundColor=[UIColor colorWithWhite:0.00 alpha:1.0];
    selection.index = array.count;
    selection.frame = CGRectMake(0,64,self.view.frame.size.width,self.view.frame.size.height - 64);
    selection.SSPopupDelegate=self;
    [self.view  addSubview:selection];
    [selection CreateTableview:array withSender:nil  withTitle:nil setCompletionBlock:^(int tag){
        if ([array[tag] length] > 0) {
            sixCell.typeFourView.nameLabel.text = array[tag];
        }else{
            sixCell.typeFourView.nameLabel.text = @"";
        }
    }];
}



- (void)clickViewnumber:(NSInteger)tag{
    
    switch (tag) {
        case 5600:
        {
            _industryModel = [[IndustryModel alloc] init];
            NSMutableArray *array = [_industryModel   getAllIndustry];
            [self getAllIndestry:[array copy]];
        }
            break;
        case 5601:
        {
            _industryModel = [[IndustryModel alloc] init];
            NSMutableArray *array = [_industryModel getIndustryTwo:_indexOne];
            [self getIndestry:[array copy]];
        }
            break;
        case 5602:
        {
            _industryModel = [[IndustryModel alloc] init];
            NSMutableArray *array = [_industryModel getIndustryNumber:_indexOne threeNumber:_indexTwo];
            [self getThreeIndestry:[array copy]];
        }
            break;
            
        default:
            break;
    }
    
}


//得到全部
-(void)getAllIndestry:(NSArray*)array{
    
    SSPopup* selection=[[SSPopup alloc]init];
    selection.backgroundColor=[UIColor colorWithWhite:0.00 alpha:1.0];
    selection.index = array.count;
    selection.frame = CGRectMake(0,64,self.view.frame.size.width,self.view.frame.size.height - 64);
    selection.SSPopupDelegate=self;
    [self.view  addSubview:selection];
    [selection CreateTableview:array withSender:nil  withTitle:nil setCompletionBlock:^(int tag){
        _indexOne = tag;
        if ([array[tag] length] > 0) {
            sevenCell.typeOneView.nameLabel.text = array[tag];
        }else{
            sevenCell.typeOneView.nameLabel.text = @"";
        }
        
        _industryModel = [[IndustryModel alloc] init];
        NSString *str = [_industryModel getAllIndustry:_indexOne ];
        if ([str length] > 0) {
            sevenCell.typeTwoView.nameLabel.text = str;
            sevenCell.typeTwoView.userInteractionEnabled = YES;
        }else{
            sevenCell.typeTwoView.nameLabel.text = @"";
            sevenCell.typeTwoView.userInteractionEnabled = NO;
        }
        
        _industryModel = [[IndustryModel alloc] init];
        NSString *strOne = [_industryModel getAllIndustryTwo:_indexOne ];
        if ([strOne length] > 0) {
            sevenCell.typeThreeView.nameLabel.text = strOne;
            sevenCell.typeThreeView.userInteractionEnabled = YES;
        }else{
            sevenCell.typeThreeView.nameLabel.text = @"";
            sevenCell.typeThreeView.userInteractionEnabled = NO;
        }
    }];
}


-(void)getIndestry:(NSArray*)array{
    
    SSPopup* selection=[[SSPopup alloc]init];
    selection.backgroundColor=[UIColor colorWithWhite:0.00 alpha:1.0];
    selection.index = array.count;
    selection.frame = CGRectMake(0,64,self.view.frame.size.width,self.view.frame.size.height - 64);
    selection.SSPopupDelegate=self;
    [self.view  addSubview:selection];
    [selection CreateTableview:array withSender:nil  withTitle:nil setCompletionBlock:^(int tag){
        _indexTwo = tag;
        if ([array[tag] length] > 0) {
            sevenCell.typeTwoView.nameLabel.text = array[tag];
        }else{
            sevenCell.typeTwoView.nameLabel.text = @"";
        }
        _industryModel = [[IndustryModel alloc] init];
        NSString *strOne = [_industryModel getIndustryTwo:_indexOne threeNumber:_indexTwo];
        if ([strOne length] > 0) {
            sevenCell.typeThreeView.nameLabel.text = strOne;
        }else{
            sevenCell.typeThreeView.nameLabel.text = @"";
        }
    }];
}



-(void)getThreeIndestry:(NSArray*)array{
    
    SSPopup* selection=[[SSPopup alloc]init];
    selection.backgroundColor=[UIColor colorWithWhite:0.00 alpha:1.0];
    selection.index = array.count;
    selection.frame = CGRectMake(0,64,self.view.frame.size.width,self.view.frame.size.height - 64);
    selection.SSPopupDelegate=self;
    [self.view  addSubview:selection];
    [selection CreateTableview:array withSender:nil  withTitle:nil setCompletionBlock:^(int tag){
        _indexTwo = tag;
        if ([array[tag] length] > 0) {
            sevenCell.typeThreeView.nameLabel.text = array[tag];
        }else{
            sevenCell.typeThreeView.nameLabel.text = @"";
        }
    }];
}

























@end



























