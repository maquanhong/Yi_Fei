//
//  AddThreeProductionController.m
//  Yi_Fei
//
//  Created by yons on 16/11/24.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.

#import "AddThreeProductionController.h"
#import "BUYbutton.h"
#import "BuyerProductController.h"
#import "FirstTableViewCell.h"
#import "SecondTableViewCell.h"
#import "ThreeTableViewCell.h"
#import "FourTableViewCell.h"
#import "tableViewFooterView.h"

@interface AddThreeProductionController ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate,UITextFieldDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>{
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


@implementation AddThreeProductionController

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

}

-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark 创建tableView
-(void)createTableView
{
    _tableView =[[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT ) style:UITableViewStyleGrouped];
    _tableView.backgroundColor=[UIColor whiteColor];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    UIView *footView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 200)];
    UIButton *btn = [BUYButton creatBtnWithBgColor:NAVCOLOR borderColor:[UIColor lightGrayColor] borderWidth:1 titleColor:[UIColor whiteColor] text:@"确定"];
    [btn addTarget:self action:@selector(clickBtnNextController) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(footView.mas_centerX);
        make.centerY.mas_equalTo(footView.mas_centerY);
        make.leading.mas_equalTo(footView).offset(40);
        make.trailing.mas_equalTo(footView).offset(-40);
    }];
    _tableView.tableFooterView=footView;
    [self.view addSubview:_tableView];
}

#pragma mark 保存数据到数据库
-(void)clickBtnNextController{

    NewTwoList  *manager = [NewTwoList newListManager];
    //查询
    if ([manager isHasDataIDFromTable:_shopObj.shopName]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"此商品给已经添加过" preferredStyle:UIAlertControllerStyleAlert];
        //确定按钮
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:nil] ;
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
    }else{
        //进行收藏
        [manager insertDataModel:_shopObj];
        BuyerProductController *myVC = [[ BuyerProductController alloc] init];
        for (BuyerProductController * controller in self.navigationController.viewControllers) { //遍历
            if ([controller isKindOfClass:[BuyerProductController class]]) { //这里判断是否为你想要跳转的页面
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
        return _index;;
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
            firstCell.titileLabel.text =  @"商品备注";
            firstCell.contentLabel.placeholder =  @"请勿沾水/勿靠近火源";
            firstCell.selectionStyle =  UITableViewCellSelectionStyleNone;
            firstCell.contentLabel.delegate = self;
            firstCell.contentLabel.tag = 1260;
            return firstCell;
        }else{
            static NSString *identifer2 =@"secondCell";
            secondCell  = [tableView dequeueReusableCellWithIdentifier:identifer2];
            if (secondCell == nil) {
                secondCell = [[FourTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer2];
            }
            secondCell.titileLabel.text = @"商品简介";
            secondCell.holderLabel.text = @"请输入商品相关介绍";
            secondCell.selectionStyle =  UITableViewCellSelectionStyleNone;
            secondCell.textView.delegate = self;
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
#pragma mark textView的代理
- (void)textViewDidEndEditing:(UITextView *)textView{
    if (textView.text.length > 0) {
        _shopObj.shopInfo = textView.text;
    }else{
        _shopObj.shopInfo = @"";
    }
}

- (void)textViewDidChange:(UITextView *)textView{
    if (textView.text.length > 0) {
        secondCell.holderLabel.hidden = YES;
    }else{
        secondCell.holderLabel.hidden = NO;
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
        _shopObj.shopCustom=str;
        //    NSLog(@"拼接后的字符串是===== %@",str);
    }else if (textField.tag == 2601){
        if (textField.text.length == 0) {
            str2=[NSString stringWithFormat:@"%@",@"ABC"];
        }else{
            str2=[NSString stringWithFormat:@"%@",textField.text];
        }
        [_shopCustomContent addObject:str2];
        NSString *str=[_shopCustomContent componentsJoinedByString:@"|"];
        _shopObj.shopContent=str;
        //        NSLog(@"拼接后的字符串是2===== %@",str);
    }else if (textField.tag == 1260){
        if (textField.text.length > 0) {
            _shopObj.shopDescribe = textField.text;
        }else{
            _shopObj.shopDescribe = @"";
        }
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
    photoController.selectPhotoOfMax = 4;
    //设置相册中完成按钮旁边小圆点颜色。
    //   photoController.roundColor = [UIColor greenColor];
    
    [photoController showIn:self result:^(id responseObject){
        self.picArray = (NSArray *)responseObject;
        [_tableView reloadData];
        
        for (int i=0; i< self.picArray.count; i++) {
            ZZPhoto *photo = self.picArray[i];
            UIImage *image = photo.originImage;
            if (i ==  0) {
                _shopObj.imageOne  = UIImagePNGRepresentation(image);
            }else if (i == 1){
                _shopObj.imageTwo  = UIImagePNGRepresentation(image);
            }else if ( i == 2){
                _shopObj.imageThree  = UIImagePNGRepresentation(image);
            }else if ( i == 3){
                _shopObj.imageFour  = UIImagePNGRepresentation(image);
            }
        }
    }];
}

- (void)presentCameraSingle {
    _flag = 1;
    
    ZZCameraController *cameraController = [[ZZCameraController alloc]init];
    cameraController.takePhotoOfMax = 4;
    cameraController.isSaveLocal = NO;
    
    [cameraController showIn:self result:^(id responseObject){
        self.picArray = (NSArray *)responseObject;
        [_tableView reloadData];
        for (int i=0; i< self.picArray.count; i++) {
            ZZPhoto *photo = self.picArray[i];
            UIImage *image = photo.originImage;
            if (i ==  0) {
                _shopObj.imageOne  = UIImagePNGRepresentation(image);
            }else if (i == 1){
                _shopObj.imageTwo  = UIImagePNGRepresentation(image);
            }else if ( i == 2){
                _shopObj.imageThree  = UIImagePNGRepresentation(image);
            }else if ( i == 3){
                _shopObj.imageFour  = UIImagePNGRepresentation(image);
            }
        }
    }];
}


//-(UIImage *)compressOriginalImage:(UIImage *)image toSize:(CGSize)size{
//    UIGraphicsBeginImageContext(size);  //size 为CGSize类型，即你所需要的图片尺寸
//    
//    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
//    
//    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
//    
//    UIGraphicsEndImageContext();
//    
//    return scaledImage;   //返回的就是已经改变的图片
//}



















@end










