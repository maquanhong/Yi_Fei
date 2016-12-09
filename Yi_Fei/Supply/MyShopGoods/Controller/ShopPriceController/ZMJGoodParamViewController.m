//
//  detail2ShopViewController.m
//  YiFei
//
//  Created by yangyan on 16/8/29.
//  Copyright © 2016年 yous. All rights reserved.
//

#import "ZMJGoodParamViewController.h"
#import "BUYbutton.h"
#import "MyProductionController.h"
#import "ZMJMyProductionCell.h"
#import "Header.h"



#import "FirstTableViewCell.h"
#import "SecondTableViewCell.h"
#import "ThreeTableViewCell.h"
#import "FourTableViewCell.h"
#import "tableViewFooterView.h"
#import "MyProductionController.h"

@interface ZMJGoodParamViewController ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate,UITextFieldDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>{
 
    FirstTableViewCell *firstCell;
    FourTableViewCell *secondCell;
    SecondTableViewCell *threeCell;
    ThreeTableViewCell  *fourCell;
    NSInteger _index;
     NSInteger _flag;

}


@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)tableViewFooterView *footView;

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
@property (nonatomic,strong)NSArray *imageArray;
@property(copy  ,nonatomic) NSArray *picArray;


@end

@implementation ZMJGoodParamViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _shopCustomType = [NSMutableArray array];
    _shopCustomContent = [NSMutableArray array];
    _index = 0;
    _flag = 0;
    self.navigationItem.title=@"新建商品";
    self.view.backgroundColor=[UIColor whiteColor];
    [self createNavigationView];
    [self createTableView];
    
}

#pragma mark 创建导航栏
-(void)createNavigationView
{
    BackButton *leftBtn = [[BackButton alloc] initWithFrame:CGRectMake(0, 0, 12, 20)];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"fanhui_icon"] forState:UIControlStateNormal];
    UIBarButtonItem * barItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = barItem;
    [leftBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton* rightBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setTitle:@"Excel导入" forState:UIControlStateNormal];
    rightBtn.frame = CGRectMake(0, 0, 60, 30);
    rightBtn.titleLabel.font=[UIFont systemFontOfSize:12.0];
    UIBarButtonItem* rightBtnItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    [rightBtn addTarget:self action:@selector(ExcelButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem=rightBtnItem;
}

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark 创建tableView
-(void)createTableView
{
    _tableView =[[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT ) style:UITableViewStyleGrouped];
    _tableView.backgroundColor=[UIColor whiteColor];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    UIView *footView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 100)];
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
    [self.view addSubview:_tableView];
    [_certainBtn addTarget:self action:@selector(clickBtnNextController) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark 保存数据到数据库
-(void)clickBtnNextController{
    FMDBOneList  *manager = [FMDBOneList defaultManager];
    //查询
    if ([manager isHasDataIDFromTable:_shopObj.ind]) {
      
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"此商品给已经添加过" preferredStyle:UIAlertControllerStyleAlert];
        //确定按钮
UIAlertAction *action = [UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:nil] ;
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
    }else{
        
        //进行收藏
    [manager insertDataModel:_shopObj];
    [firstCell.textView endEditing:YES];
    MyProductionController *myVC = [[ MyProductionController alloc] init];
        for (MyProductionController * controller in self.navigationController.viewControllers) { //遍历
            if ([controller isKindOfClass:[MyProductionController class]]) { //这里判断是否为你想要跳转的页面
                myVC = controller;
            }
        }
        if (myVC) {
            [self.navigationController popToViewController:myVC animated:YES]; //跳转
        }
    }
}


#pragma mark tableVie的代理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 2;
    }else if (section == 1){
        return _index;
    }else if (section == 2){
        if (_flag == 1) {
            return 1;
        }else{
        return 0;
        }
    }else {
        return 0;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            static NSString *identifer1=@"firstCell";
            firstCell  = [tableView dequeueReusableCellWithIdentifier:identifer1];
            if (firstCell == nil) {
                firstCell = [[FirstTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer1];
            }
            firstCell.titileLabel.text = @"商品简介";
            firstCell.holderLabel.text = @"请输入商品相关介绍";
            firstCell.selectionStyle =  UITableViewCellSelectionStyleNone;
            _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            firstCell.textView.delegate = self;
            firstCell.textView.tag = 2400 ;
             return firstCell;
        }else{
            static NSString *identifer2 =@"secondCell";
            secondCell  = [tableView dequeueReusableCellWithIdentifier:identifer2];
            if (secondCell == nil) {
                secondCell = [[FourTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer2];
            }
            secondCell.titileLabel.text = @"商品备注";
            secondCell.holderLabel.text = @"请勿沾水/勿靠近火源";
            secondCell.selectionStyle =  UITableViewCellSelectionStyleNone;
            secondCell.textView.delegate = self;
            secondCell.textView.tag = 2401;
            return secondCell;
        }
        
    } else if (indexPath.section == 1){
        static NSString *identifer3=@"threeCell";
       threeCell  = [tableView dequeueReusableCellWithIdentifier:identifer3];
        if (threeCell == nil) {
            threeCell = [[SecondTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer3];
        }
        threeCell.textFOne.delegate = self;
        threeCell.textFTwo.delegate = self;
        threeCell.textFOne.tag = 2600;
        threeCell.textFTwo.tag = 2601;
     _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
     threeCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return threeCell;
    }else if (indexPath.section == 2){
        
        static NSString *identifer4=@"fourCell";
        fourCell = [tableView dequeueReusableCellWithIdentifier:identifer4];
        if (fourCell == nil) {
        fourCell = [[ThreeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer4];
        }
        if (_flag == 1) {
    fourCell.imageArray = [NSArray arrayWithArray:self.picArray];
    [fourCell.collectionView reloadData];
        }
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        return fourCell;
    }else {
        return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
              return  40 ;
        }else{
         return 120;
        }
    }else if (indexPath.section == 1) {
         return 44 ;
    }else if (indexPath.section == 2) {
        NSInteger count =  self.picArray.count;
        if (count % 4 != 0) {
            return ((WIDTH - 50) / 4 + 10) * (count / 4 + 1);
        }else{
            return ((WIDTH - 50) / 4 + 10) * (count /4);
        }
    }else{
        return 0;
    }
}


#pragma mark tableView每组的组头视图设置
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 1) {
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
    }else if ( section == 2){
        
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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 1  ) {
        return 44;
    }else if ( section == 2) {
        return 44;
    }else{
        return 0.0001;
    }
}


#pragma mark 增加自定义的cell
-(void)clickBtnView{
    _index++;
    [_tableView reloadData];
}


//编辑结束监听
- (void)textFieldDidEndEditing:(UITextField *)textField{
    NSString *str1;
    NSString *str2;
    if (textField.tag == 2600) {
        if (textField.text.length == 0) {
     str1=[NSString stringWithFormat:@"%@",@"ABC"];
               NSLog(@"%@",str1);
        }else{
     str1=[NSString stringWithFormat:@"%@",textField.text];
            NSLog(@"%@",str1);
        }
    [_shopCustomType addObject:str1];
        NSLog(@"%@",_shopCustomType);
    NSString *str=[_shopCustomType componentsJoinedByString:@"|"];
    _shopObj.shopCustom=str;
//    NSLog(@"拼接后的字符串是===== %@",str);
    }else{
        if (textField.text.length == 0) {
    str2=[NSString stringWithFormat:@"%@",@"ABC"];
             NSLog(@"%@",str2);
        }else{
    str2=[NSString stringWithFormat:@"%@",textField.text];
              NSLog(@"%@",str2);
        }
        [_shopCustomContent addObject:str2];
            NSLog(@"%@",_shopCustomContent);
        NSString *str=[_shopCustomContent componentsJoinedByString:@"|"];
        _shopObj.shopContent=str;
//        NSLog(@"拼接后的字符串是2===== %@",str);
    }
}


#pragma mark textView的代理方法

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];//按回车取消第一相应者
    }
    return YES;
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    if (textView.tag  == 2400) {
    firstCell.holderLabel.alpha = 0;
    }else{
    secondCell.holderLabel.alpha = 0;
    }
    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    //将要停止编辑(不是第一响应者时)
    if (textView.text.length == 0) {
        if (textView.tag  == 2400) {
        firstCell.holderLabel.alpha = 1.0;
        }else{
        secondCell.holderLabel.alpha = 1.0;
        }
    }
    return YES;
}


-(void)textViewDidEndEditing:(UITextView *)textView{
        if (textView.tag - 2400 == 0) {
            if (textView.text.length > 0) {
        _shopObj.shopDescribe = textView.text;
            }else{
        _shopObj.shopDescribe = @"";
            }
        }else{
        if (textView.text.length > 0) {
            _shopObj.shopInfo = textView.text;
        }else{
            _shopObj.shopInfo = @"";
        }
    }
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
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














@end

































































