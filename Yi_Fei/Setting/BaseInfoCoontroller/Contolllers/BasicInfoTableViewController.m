//
//  BasicInfoTableViewController.m
//  Yi_Fei
//
//  Created by maquanhong on 2016/11/28.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "BasicInfoTableViewController.h"
#import "CompanyLogoCell.h"
#import "NameTableViewCell.h"
#import "PureLayout.h"
#import "BUYButton.h"
#import "UserModel.h"
#import "UserList.h"
#import "UserDefaultManager.h"

@interface BasicInfoTableViewController ()<UITextFieldDelegate>
{
    CompanyLogoCell *firstCell;
    NameTableViewCell *secondCell;
    UserModel *oneModel;
    BOOL _isSelect;
}

@property(strong  ,nonatomic) NSArray *picArray;
@property(strong  ,nonatomic) UIImage *pictureImage;
@property (nonatomic, strong) BUYButton *btn;
@property (nonatomic, strong) NSArray  *zhCnMenuArray;
@property (nonatomic, strong) NSArray  *enMenuArray;
@property (nonatomic, assign) NSInteger  selectIndex;
@property (nonatomic, strong) NSArray  *showNameValeArray;
@end

@implementation BasicInfoTableViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadData];
}


//数据的加载
-(void)loadData{
    //获取单例对象
     UserList *manager = [UserList defaultManager];
    //可变数组初始化
NSString *strOne = [UserDefaultManager getDataByKey:@"name"];
NSString *strTwo = [UserDefaultManager getDataByKey:@"link"];
   oneModel = [manager getDataName:strOne and:strTwo];
    [self.tableView reloadData];
}

- (void)btnClick{
    
    UserList *manager = [UserList defaultManager];
    UserModel *model = [[UserModel alloc] init];
    model.picture = [UserDefaultManager getDataByKey:@"path"];
    model.name = [UserDefaultManager getDataByKey:@"name"];
    model.industry = [UserDefaultManager getDataByKey:@"industry"];
    model.size = [UserDefaultManager getDataByKey:@"size"];
    model.business = [UserDefaultManager getDataByKey:@"business"];
    model.product = [UserDefaultManager getDataByKey:@"product"];
    model.url = [UserDefaultManager getDataByKey:@"url"];
    model.link = [UserDefaultManager getDataByKey:@"link"];
    model.position = [UserDefaultManager getDataByKey:@"position"];
    model.phone = [UserDefaultManager getDataByKey:@"phone"];
    model.email = [UserDefaultManager getDataByKey:@"email"];
    model.adderss = [UserDefaultManager getDataByKey:@"adderss"];

    if ([model.name length] >0 && [model.link length]>0) {
        if ([manager isHasDataIDFrom:model.name and:model.link]) {
            [manager updateDataModel:model and:model.name and:model.link];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [manager insertDataModel:model];
    [self.navigationController popViewControllerAnimated:YES];
        }
    }else{
        if (model.name.length == 0) {
            [self setWarning:@"公司名称不能为空"];
        }
        if (model.link.length == 0) {
              [self setWarning:@"电话号码不能为空"];
        }
    }
    
    
}

-(void)setWarning:(NSString*)identifer{

    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:identifer preferredStyle:UIAlertControllerStyleAlert];
    //确定按钮
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:nil] ;
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNav];
    _selectIndex = 0;
    _isSelect = YES;
    _zhCnMenuArray = @[@"公司名称",@"行业",@"公司规模",@"主营业务",@"主要产品",@"官网",@"地址",@"联系人",@"职位",@"联系电话",@"Email"];
    _enMenuArray = @[@"Company Name",@"Industry",@"Scale",@"Main Business",@"Main Products",@"Website",@"Address",@"Contacts",@"position",@"Tel",@"Email"];
    if (self.selectIndex == 0) {
        self.showNameValeArray = _zhCnMenuArray;
    } else {
        self.showNameValeArray = _enMenuArray;
    }
    UISegmentedControl *control = [[UISegmentedControl alloc] initWithItems:@[@"中文",@"English"]];
    control.selectedSegmentIndex = self.selectIndex;
    [control addTarget:self action:@selector(didSelect:) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = control;
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 100)];
    _btn  = [BUYButton creatBtnWithBgColor:BACKCOLOR borderColor:[UIColor lightGrayColor] borderWidth:1 titleColor:[UIColor whiteColor] text:@"保存"];
    _btn.frame=CGRectMake(50, 30, WIDTH - 100, 35);
    [_btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:_btn];
    self.tableView.tableFooterView = bgView;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

}

- (void)setNav {
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



- (void)didSelect:(UISegmentedControl *)control {
    NSInteger selectIndex = control.selectedSegmentIndex;
    if (selectIndex == self.selectIndex) {
        return;
    }
    self.selectIndex = selectIndex;
    if (self.selectIndex == 0) {
        self.showNameValeArray = _zhCnMenuArray;
    [_btn setTitle:@"保存" forState:UIControlStateNormal];
    } else {
        self.showNameValeArray = _enMenuArray;
   [_btn setTitle:@"Save" forState:UIControlStateNormal];
    }
    [self.tableView reloadData];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger count = [self.showNameValeArray count] + 1;
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
    static NSString *cellIdent1 = @"LogoCell";
    firstCell = [tableView dequeueReusableCellWithIdentifier:cellIdent1];
    if (firstCell==nil) {
    firstCell = [[[NSBundle mainBundle] loadNibNamed:@"CompanyLogoCell" owner:self options:nil] lastObject];
    }
    if ( self.selectIndex == 0) {
    firstCell.titleLabel.text = @"公司LOGO";
    }else{
    firstCell.titleLabel.text = @"Company LOGO";
    }
        if (_isSelect) {
            NSString *path_document = NSHomeDirectory();
            //设置一个图片的存储路径
        if (oneModel.picture.length > 0) {
        NSString *imagePath = [path_document stringByAppendingString:[NSString stringWithFormat:@"/Documents/%@.png",oneModel.picture]];
        firstCell.logoImage.image= [UIImage imageWithContentsOfFile:imagePath];
          }
        }else{
    if (![_pictureImage isKindOfClass:[NSNull class]]) {
        firstCell.logoImage.image=  _pictureImage;
    }
    }
    firstCell.selectionStyle = UITableViewCellSelectionStyleNone;
    return firstCell;
    }else{
    static NSString *cellIdent2 = @"TextCell";
    secondCell = [tableView dequeueReusableCellWithIdentifier:cellIdent2];
    if (secondCell==nil) {
    secondCell = [[[NSBundle mainBundle] loadNibNamed:@"NameTableViewCell" owner:self options:nil] lastObject];
    }
secondCell.titleLabel.text = [self.showNameValeArray objectAtIndex:(indexPath.row - 1)];
    if (indexPath.row == 1 || indexPath.row == 8) {
        secondCell.textFiled.placeholder = @"(必填项)";
    }
    secondCell.textFiled.tag = 1690 + indexPath.row - 1;
    secondCell.textFiled.delegate = self;
    secondCell.selectionStyle = UITableViewCellSelectionStyleNone;
    [self setTextFiled:secondCell.textFiled];
    return secondCell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 60;
    }else{
        return 44;
    }
}

//设置值
-(void)setTextFiled:(UITextField*)textFiled{
    
    NSInteger index = textFiled.tag - 1690;
    switch (index) {
        case 0:
        {
    if (oneModel.name.length > 0 || [oneModel.name isEqualToString:@"0"]) {
        textFiled.text = oneModel.name;
    }else{
    textFiled.text = @"";
    }
        }
            break;
        case 1:
        {
    if (oneModel.industry.length > 0 || [oneModel.name isEqualToString:@"0"]) {
        textFiled.text = oneModel.industry;
    }else{
        textFiled.text = @"";
    }
        }
            break;
        case 2:
        {
    if (oneModel.size.length > 0 ||[oneModel.name isEqualToString:@"0"] ) {
        textFiled.text = oneModel.size;
    }else{
        textFiled.text = @"";
    }
        }
            break;
        case 3:
        {
    if (oneModel.business.length > 0 || [oneModel.name isEqualToString:@"0"]) {
        textFiled.text = oneModel.business;
    }else{
        textFiled.text = @"";
    }
        }
            break;
        case 4:
        {
    if (oneModel.product.length > 0 || [oneModel.name isEqualToString:@"0"]) {
        textFiled.text = oneModel.product;
    }else{
        textFiled.text = @"";
    }
        }
            break;
        case 5:
        {
    if (oneModel.url.length > 0 || [oneModel.name isEqualToString:@"0"]) {
        textFiled.text = oneModel.url;
    }else{
        textFiled.text = @"";
    }
        }
            break;
        case 6:
        {
    if (oneModel.adderss.length > 0 || [oneModel.name isEqualToString:@"0"]) {
        textFiled.text = oneModel.adderss;
    }else{
        textFiled.text = @"";
    }
        }
            break;
        case 7:
        {
    if (oneModel.link.length > 0 || [oneModel.name isEqualToString:@"0"]) {
        textFiled.text = oneModel.link;
    }else{
        textFiled.text = @"";
    }
        }
            break;
        case 8:
        {
    if (oneModel.position.length > 0 || [oneModel.name isEqualToString:@"0"]) {
        textFiled.text = oneModel.position;
    }else{
        textFiled.text = @"";
    }
        }
            break;
        case 9:
        {
        if (oneModel.phone.length > 0 || [oneModel.name isEqualToString:@"0"]) {
            textFiled.text = oneModel.phone;
        }else{
            textFiled.text = @"";
        }
        }
            break;
        case 10:
        {
            if (oneModel.email.length > 0 || [oneModel.name isEqualToString:@"0"]) {
                textFiled.text = oneModel.email;
            }else{
                textFiled.text = @"";
            }
        }
            break;
        default:
            break;
    }
}


//设置输入的数据
-(void)textFieldDidEndEditing:(UITextField *)textField{
    NSInteger index = textField.tag - 1690;
    switch (index) {
        case 0:
        {
[UserDefaultManager saveDataWithValue:textField.text key:@"name"];
        }
            break;
        case 1:
        {
[UserDefaultManager saveDataWithValue:textField.text key:@"industry"];
        }
            break;
        case 2:
        {
[UserDefaultManager saveDataWithValue:textField.text key:@"size"];
        }
            break;
        case 3:
        {
[UserDefaultManager saveDataWithValue:textField.text key:@"business"];
        }
            break;
        case 4:
        {
[UserDefaultManager saveDataWithValue:textField.text key:@"product"];
        }
            break;
        case 5:
        {
[UserDefaultManager saveDataWithValue:textField.text key:@"url"];
        }
            break;
        case 6:
        {
[UserDefaultManager saveDataWithValue:textField.text key:@"adderss"];
        }
            break;
        case 7:
        {
[UserDefaultManager saveDataWithValue:textField.text key:@"link"];
        }
            break;
        case 8:
        {
[UserDefaultManager saveDataWithValue:textField.text key:@"position"];
        }
            break;
        case 9:
        {
[UserDefaultManager saveDataWithValue:textField.text key:@"phone"];
        }
            break;
        case 10:
        {
[UserDefaultManager saveDataWithValue:textField.text key:@"email"];
        }
            break;
        default:
            break;
    }
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        [self clickUpBtn];
    }
}


#pragma mark 上传的事件
-(void)clickUpBtn{
    
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"选择图片方式" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
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
        _isSelect = NO;
        self.picArray = (NSArray *)responseObject;
        ZZPhoto *photo = self.picArray[0];
        _pictureImage = photo.originImage;
        [self.tableView reloadData];
        NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0.0];
        //打印日期：中间的空格可以用‘at’或‘T’等字符划分
        NSDateFormatter *dateFomtter = [[NSDateFormatter alloc]init];
        [dateFomtter setDateFormat:@ "yyyy-MM-ddHH:mm:ss SSSS" ];
        
        NSString *strTime=[dateFomtter stringFromDate:date];
        NSString *path_document = NSHomeDirectory();
        //设置一个图片的存储路径
        NSString *imagePath = [path_document stringByAppendingString:[NSString stringWithFormat:@"/Documents/%@.png",strTime]];
    [UIImagePNGRepresentation(photo.originImage) writeToFile:imagePath atomically:YES];
   [UserDefaultManager saveDataWithValue:strTime key:@"path"];
    }];
}

- (void)presentCameraSingle {
    
    ZZCameraController *cameraController = [[ZZCameraController alloc]init];
    cameraController.takePhotoOfMax = 1;
    cameraController.isSaveLocal = NO;
    [cameraController showIn:self result:^(id responseObject){
         _isSelect = NO;
        self.picArray = [NSArray array];
        self.picArray = (NSArray *)responseObject;
        ZZCamera *camera = self.picArray[0];
        _pictureImage = camera.image;
        [self.tableView reloadData];
        NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0.0];
        NSDateFormatter *dateFomtter = [[NSDateFormatter alloc]init];
        [dateFomtter setDateFormat:@ "yyyy-MM-ddHH:mm:ss SSSS" ];
        NSString *strTime=[dateFomtter stringFromDate:date];
        NSString *path_document = NSHomeDirectory();
        NSString *imagePath = [path_document stringByAppendingString:[NSString stringWithFormat:@"/Documents/%@.png",strTime]];
[UIImagePNGRepresentation(camera.image) writeToFile:imagePath atomically:YES];
        [UserDefaultManager saveDataWithValue:strTime key:@"path"];
    }];
}

























@end












