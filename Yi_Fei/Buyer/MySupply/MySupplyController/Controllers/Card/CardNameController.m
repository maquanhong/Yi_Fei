//
//  CardNameController.m
//  Yi_Fei
//
//  Created by yons on 16/12/17.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "CardNameController.h"
#import "HeaderView.h"
#import "CardOneCell.h"
#import "CardTwoCell.h"
#import "BackButton.h"

@interface CardNameController (){
    CardOneCell *firstCell;
    CardTwoCell *secondCell;
}

@property (nonatomic,strong) NSArray *imageArray;
@property (nonatomic,strong) NSMutableArray *titleArray;
@property (nonatomic,strong) NSArray *subTitleArray;
//行业类型
@property (nonatomic,strong) NSArray *industryArray;

@end

@implementation CardNameController

- (void)viewDidLoad {
    [super viewDidLoad];
    _titleArray = [NSMutableArray array];
    _industryArray =[_model.industryType componentsSeparatedByString:@"|"];
    self.navigationController.navigationBar.hidden = YES;
    _imageArray = @[@"phone",@"youxiang",@"dizhi"];
    if (_model.phone.length > 0 ) {
    [_titleArray addObject:_model.phone];
    }else{
     [_titleArray addObject:@""];
    }
    if (_model.emailAddress.length > 0 ) {
        [_titleArray addObject:_model.emailAddress];
    }else{
     [_titleArray addObject:@""];
    }
    if (_model.companyAddress.length > 0 ) {
        [_titleArray addObject:_model.companyAddress];
    }else{
     [_titleArray addObject:@""];
    }
    _subTitleArray = @[@"联系方式",@"工作邮箱",@"公司地址"];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self createTableView];
}

-(void)createTableView{

    self.tableView =[[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT) style:UITableViewStyleGrouped];
    self.tableView.contentInset = UIEdgeInsetsMake(-20, 0, 0, 0);
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    [self.view addSubview:self.tableView];
    
    HeaderView *header = [[HeaderView alloc] initWithFrame:CGRectMake(0, 0, WIDTH,200)];
    header.backImageView.image = [UIImage imageNamed:@"h1"];
    NSString *path_document = NSHomeDirectory();
    //设置一个图片的存储路径
    NSString *imagePath = [path_document stringByAppendingString:[NSString stringWithFormat:@"/Documents/%@.png",_model.companyLogo]];
    header.iconImageView.image  = [UIImage imageWithContentsOfFile:imagePath];
    header.nameLabel.text = _model.supplyName;
    if (_model.position.length >0) {
  header.titleLabel.text = [NSString stringWithFormat:@"%@",_model.position];
    }else if (_model.companyName.length > 0){
    header.titleLabel.text = [NSString stringWithFormat:@"%@",_model.companyName];
    }else if (_model.companyName.length > 0 && _model.position.length >0){
    header.titleLabel.text = [NSString stringWithFormat:@"%@    %@",_model.position,_model.companyName];
    }
    self.tableView.tableHeaderView = header;
    BackButton *btn = [[BackButton alloc] init];
[btn setImage:[UIImage imageNamed:@"fanhui_icon"] forState:UIControlStateNormal];
    [header addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(header).offset(10);
        make.top.equalTo(header).offset(25);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    [btn addTarget:secondCell action:@selector(returnNextView) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)returnNextView{
    [self.navigationController popViewControllerAnimated:YES];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
    return _imageArray.count;
    }else{
        return 1;
    }
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        static NSString *identifer = @"CardOneCell";
        firstCell =[tableView dequeueReusableCellWithIdentifier:identifer];
        if (firstCell==nil) {
   firstCell = [[[NSBundle mainBundle] loadNibNamed:@"CardOneCell" owner:self options:nil] lastObject];
        }
    firstCell.flagImageView.image = [UIImage imageNamed:_imageArray[indexPath.row]];
        if ([_titleArray[indexPath.row] length] > 0) {
    firstCell.titleLabel.text = _titleArray[indexPath.row];
        }
        if ([_subTitleArray[indexPath.row] length] > 0) {
    firstCell.subTitleLabel.text = _subTitleArray[indexPath.row];
        }
    return firstCell;
    }else{
    static NSString *identifer = @"CardTwoCell";
    secondCell =[tableView dequeueReusableCellWithIdentifier:identifer];
    if (secondCell==nil) {
    secondCell = [[CardTwoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    }
    if ([_industryArray[0] length] > 0) {
    secondCell.typeOne.titleLabel.text = _industryArray[0];
    }else{
    secondCell.typeOne.titleLabel.text = _industryArray[0];
    }
    if ([_industryArray[1] length] > 0) {
        secondCell.typeTwo.titleLabel.text = _industryArray[1];
    }
    if ([_industryArray[2] length] > 0) {
        secondCell.typeThree.titleLabel.text = _industryArray[2];
    }
    if ([_industryArray count] > 3) {
        if ([_industryArray[3] length] > 0) {
            secondCell.typeFour.titleLabel.text = _industryArray[3];
        }
    }
    return secondCell;
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
          return 60;
    }else{
        return 140;
    }
}


-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
self.navigationController.navigationBar.hidden = NO;
}















@end











