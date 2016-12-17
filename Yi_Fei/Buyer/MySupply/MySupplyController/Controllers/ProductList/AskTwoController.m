
//
//  AskTwoController.m
//  Yi_Fei
//
//  Created by yons on 16/12/17.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "AskTwoController.h"
#import "FirstViewCell.h"
#import "ThreeViewCell.h"
#import "FourViewCell.h"


@interface AskTwoController ()<UITextFieldDelegate,UITextViewDelegate>
{
    FirstViewCell *firstCell;
    ThreeViewCell *threeCell;
    FourViewCell *fourCell;

}
@property (nonatomic,strong) NSArray *leftArray;

@end

@implementation AskTwoController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _leftArray = @[@"商品名称",@"商品规格",@"商品材质",@"商品尺寸",@"商品颜色",@"商品数量"];
    [self setNav];
    [self addContentView];
    
}

- (void)setNav {
    self.title = @"留样询价";
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


#pragma mark 创建tableView视图
-(void)addContentView{
    
    _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 100)];
    backView.backgroundColor = [UIColor whiteColor];
    UIButton *btn = [[UIButton alloc] init];
    btn.layer.cornerRadius = 5;
    btn.backgroundColor = COLOR;
    [btn setTitle:@"发送" forState:UIControlStateNormal];
    [backView addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(backView);
        make.leading.equalTo(backView).offset(50);
        make.trailing.equalTo(backView).offset(-50);
        make.height.mas_equalTo(40);
    }];
    _tableView.tableFooterView = backView;
}

#pragma mark 代理
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 6 ;
    }else{
        return 1;
    }
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        static NSString *identifer = @"FirstViewCell";
        firstCell = [tableView dequeueReusableCellWithIdentifier:identifer];
        if (!firstCell) {
            firstCell = [[[NSBundle mainBundle] loadNibNamed:@"FirstViewCell" owner:self options:nil]lastObject];
        }
        firstCell.textfFiled.delegate  = self;
        firstCell.nameLabel.text = _leftArray[indexPath.row];
        firstCell.selectionStyle = UITableViewCellSelectionStyleNone;
        firstCell.textfFiled.tag = 1580 + indexPath.row;
        [ self setDataFromeModel:firstCell.textfFiled];
        return firstCell;
    }else if(indexPath.section == 1) {
        static NSString *identifer = @"threeCell";
        threeCell = [tableView dequeueReusableCellWithIdentifier:identifer];
        if (!threeCell) {
            threeCell = [[[NSBundle mainBundle] loadNibNamed:@"ThreeViewCell" owner:self options:nil]lastObject];
        }
        threeCell.textView.delegate = self;
        if (_model.shopDescribe.length > 0) {
            threeCell.textView.text = _model.shopDescribe;
        }
        threeCell.nameLabel.text = @"商品备注";
        return threeCell;
    }else{
        static NSString *identifer = @"fourCell";
        fourCell = [tableView dequeueReusableCellWithIdentifier:identifer];
        if (!fourCell) {
            fourCell = [[[NSBundle mainBundle] loadNibNamed:@"FourViewCell" owner:self options:nil]lastObject];
        }
        
        NSArray *arrayimg=[_model.shopPicture componentsSeparatedByString:@"|"];
        NSString *path_document = NSHomeDirectory();
        
        for (NSInteger i = 0 ; i < arrayimg.count; i++) {
            if (i == 0 ) {
                //设置一个图片的存储路径
                NSString *imagePath = [path_document stringByAppendingString:[NSString stringWithFormat:@"/Documents/%@.png",arrayimg[0]]];
                fourCell.imageOne.image= [UIImage imageWithContentsOfFile:imagePath];
            }else{
                fourCell.imageOne.hidden = YES;
            }
            if (i == 1 ) {
                NSString *imagePath = [path_document stringByAppendingString:[NSString stringWithFormat:@"/Documents/%@.png",arrayimg[1]]];
                fourCell.imageTwo.image= [UIImage imageWithContentsOfFile:imagePath];
            }else{
                fourCell.imageTwo.hidden = YES;
            }
            if (i == 2) {
                NSString *imagePath = [path_document stringByAppendingString:[NSString stringWithFormat:@"/Documents/%@.png",arrayimg[2]]];
                fourCell.imageThree.image= [UIImage imageWithContentsOfFile:imagePath];
            }else{
                fourCell.imageThree.hidden = YES;
            }
            if (i == 3 ) {
                NSString *imagePath = [path_document stringByAppendingString:[NSString stringWithFormat:@"/Documents/%@.png",arrayimg[3]]];
                fourCell.imageFour.image= [UIImage imageWithContentsOfFile:imagePath];
            }else{
                fourCell.imageFour.hidden = YES;
            }
        }
        return fourCell;
    }
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 44;
    }else if (indexPath.section == 1) {
        return 100;
    }else {
        return 130;
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


#pragma mark 设置参数
-(void)setDataFromeModel:(UITextField*)textFiled{
    
    switch (textFiled.tag) {
        case 1480:
        {
            if (_model.shopName.length != 0) {
                firstCell.textfFiled.text = _model.shopName;
            }else{
                firstCell.textfFiled.text = @"";
            }
        }
            break;
        case 1481:
        {
            if (_model.shopSpecific.length != 0) {
                firstCell.textfFiled.text = _model.shopSpecific;
            }else{
                firstCell.textfFiled.text = @"";
            }
        }
            break;
            
        case 1482:
        {
            if (_model.shopMed.length != 0) {
                firstCell.textfFiled.text = _model.shopMed;
            }else{
                firstCell.textfFiled.text = @"";
            }
        }
            break;
        case 1483:
        {
            if (_model.shopSize.length != 0) {
                firstCell.textfFiled.text = _model.shopSize;
            }else{
                firstCell.textfFiled.text = @"";
            }
        }
            break;
        case 1484:
        {
            if (_model.shopColor.length != 0) {
                firstCell.textfFiled.text = _model.shopColor;
            }else{
                firstCell.textfFiled.text = @"";
            }
        }
            break;
        case 1485:
        {
            if (_model.num.length != 0) {
            firstCell.textfFiled.text = _model.num;
            }else{
            firstCell.textfFiled.text = @"";
            }
        }
            break;
        default:
            break;
    }
}


-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    switch (textField.tag) {
        case 1480:
        {
            if (textField.text.length > 0 ) {
                _model.shopName = textField.text;
            }else{
                _model.shopName = @"";
            }
        }
            break;
        case 1481:
        {
            if (textField.text.length > 0 ) {
                _model.shopSpecific = textField.text;
            }else{
                _model.shopSpecific = @"";
            }
        }
            break;
        case 1482:
        {
            if (textField.text.length > 0 ) {
                _model.shopMed = textField.text;
            }else{
                _model.shopMed = @"";
            }
        }
            break;
        case 1483:
        {
            if (textField.text.length > 0 ) {
                _model.shopSize = textField.text;
            }else{
                _model.shopSize = @"";
            }
        }
            break;
        case 1484:
        {
            if (textField.text.length > 0 ) {
                _model.shopColor = textField.text;
            }else{
                _model.shopColor = @"";
            }
        }
            break;
        case 1485:
        {
            if (textField.text.length > 0 ) {
                _model.num = textField.text;
            }else{
                _model.num = @"";
            }
        }
            break;
        default:
            break;
    }
}

-(void)textViewDidEndEditing:(UITextView *)textView{
    _model.shopDescribe = textView.text;
}







































@end











































