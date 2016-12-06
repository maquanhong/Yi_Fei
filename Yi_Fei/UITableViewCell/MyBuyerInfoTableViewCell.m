//
//  MyBuyerInfoTableViewCell.m
//  YiFei
//
//  Created by yangyan on 16/9/3.
//  Copyright © 2016年 yous. All rights reserved.
//

#import "MyBuyerInfoTableViewCell.h"
#import "BUYButton.h"
#import "BuyerLable.h"
#import "ZESegmentedsView.h"
@interface MyBuyerInfoTableViewCell ()<ZESegmentedsViewDelegate>
@property (nonatomic, strong) ZESegmentedsView  *segmentView;
@end
@implementation MyBuyerInfoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addView];
    }
    return self;
}

-(void)addView{
//    UIView *view=[[UIView alloc] init];
//    [view sizeToFit];
//    view.frame=CGRectMake(20, 5, WIDTH-20-40, 30);
//    [self.contentView addSubview:view];
//    
//    NSArray *array=@[@"客户资料",@"交易记录",@"备忘客户爱好"];
//    for (int i=0; i<3; i++) {
//        UIButton *button=[BUYButton creatBtnWithBgColor:[UIColor whiteColor] borderColor:NAVCOLOR borderWidth:1.0 titleColor:NAVCOLOR text:array[i]];
//        button.frame=CGRectMake((WIDTH-20-40)/3*i, 5, (WIDTH-20-40)/3, 20);
//        button.tag=60+i;
//        button.titleLabel.font=[UIFont systemFontOfSize:12.0];
//        if (i==0) {
//            button.backgroundColor=NAVCOLOR;
//            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];        }
//        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
//        [view addSubview:button];
//    }
    _segmentView = [[ZESegmentedsView alloc] initWithFrame:CGRectMake(20, 5, WIDTH-40, 30) segmentedCount:3 segmentedTitles:@[@"客户资料",@"交易记录",@"备忘客户爱好"]];
    _segmentView.delegate = self;
    [self.contentView addSubview:self.segmentView];
    
    _KHView=[[UIView alloc] init];
    [_KHView sizeToFit];
    _KHView.hidden=NO;
    _KHView.frame=CGRectMake(20, CGRectGetMaxY(self.segmentView.frame), WIDTH-20-40, 140);
    [self.contentView addSubview:_KHView];
    
    BuyerLable *name=[BuyerLable creatLabelTextColor:[UIColor blackColor] text:@"姓  名"];
    [name sizeToFit];
    name.frame=CGRectMake(0, 10, WIDTH/7, 20);
    [_KHView addSubview:name];
    
    BuyerLable *tel=[BuyerLable creatLabelTextColor:[UIColor blackColor] text:@"电  话"];
    [tel sizeToFit];
    tel.frame=CGRectMake(WIDTH/3, 10, WIDTH/7, 25);
    [_KHView addSubview:tel];
    
    
    BuyerLable *positionL=[BuyerLable creatLabelTextColor:[UIColor blackColor] text:@"职  位"];
    [positionL sizeToFit];
    positionL.frame=CGRectMake(0, CGRectGetMaxY(name.frame), WIDTH/7, 25);
    [_KHView addSubview:positionL];
    
    
    BuyerLable *EmailL=[BuyerLable creatLabelTextColor:[UIColor blackColor] text:@"邮  箱"];
    [EmailL sizeToFit];
    EmailL.frame=CGRectMake(WIDTH/3, CGRectGetMaxY(name.frame), WIDTH/7, 25);
    [_KHView addSubview:EmailL];
    
    
    BuyerLable *companyL=[BuyerLable creatLabelTextColor:[UIColor blackColor] text:@"公司名称"];
    [companyL sizeToFit];
    companyL.frame=CGRectMake(0, CGRectGetMaxY(positionL.frame), WIDTH/5, 25);
    [_KHView addSubview:companyL];
    
    
    BuyerLable *adressL=[BuyerLable creatLabelTextColor:[UIColor blackColor] text:@"地  址"];
    [adressL sizeToFit];
    adressL.frame=CGRectMake(0, CGRectGetMaxY(companyL.frame), WIDTH/6, 25);
    [_KHView addSubview:adressL];
    
    
    BuyerLable *typeL=[BuyerLable creatLabelTextColor:[UIColor blackColor] text:@"行业类型"];
    [typeL sizeToFit];
    typeL.frame=CGRectMake(0, CGRectGetMaxY(adressL.frame), WIDTH/5, 45);
    [_KHView addSubview:typeL];
    
    _nameL=[BuyerLable creatLabelTextColor:[UIColor grayColor] text:@"周先生"];
    [_nameL sizeToFit];
    _nameL.frame=CGRectMake(CGRectGetMaxX(name.frame), 10, WIDTH/5, 25);
    [_KHView addSubview:_nameL];
    
    _telL=[BuyerLable creatLabelTextColor:[UIColor grayColor] text:@"12345678"];
    [_telL sizeToFit];
    _telL.frame=CGRectMake(CGRectGetMaxX(tel.frame), 10, WIDTH/4, 25);
    [_KHView addSubview:_telL];
    
    _jobL=[BuyerLable creatLabelTextColor:[UIColor grayColor] text:@"总经理"];
    [_jobL sizeToFit];
    _jobL.frame=CGRectMake(CGRectGetMaxX(positionL.frame), CGRectGetMaxY(name.frame), WIDTH/5, 25);
    [_KHView addSubview:_jobL];
    
    _EmailL=[BuyerLable creatLabelTextColor:[UIColor grayColor] text:@"12345678@qq.com"];
    [_EmailL sizeToFit];
    _EmailL.frame=CGRectMake(CGRectGetMaxX(EmailL.frame), CGRectGetMaxY(name.frame), WIDTH/2.5, 25);
    [_KHView addSubview:_EmailL];

    _companyL=[BuyerLable creatLabelTextColor:[UIColor grayColor] text:@"杭州百倍云科技有限公司"];
    [_companyL sizeToFit];
    _companyL.frame=CGRectMake(CGRectGetMaxX(companyL.frame), CGRectGetMaxY(_jobL.frame), WIDTH/2, 25);
    [_KHView addSubview:_companyL];
    
    _adressL=[BuyerLable creatLabelTextColor:[UIColor grayColor] text:@"浙江省杭州市西湖区西部软件园"];
    [_adressL sizeToFit];
    _adressL.frame=CGRectMake(CGRectGetMaxX(adressL.frame), CGRectGetMaxY(_companyL.frame), WIDTH/1.5, 25);
    [_KHView addSubview:_adressL];
    
    _typeL=[BuyerLable creatLabelTextColor:[UIColor grayColor] text:@"建筑及装饰材料设备-建筑材料 涂料/化学类-建筑校/胶带"];
    [_typeL sizeToFit];
    _typeL.frame=CGRectMake(CGRectGetMaxX(typeL.frame), CGRectGetMaxY(_adressL.frame), WIDTH/1.5, 45);
    _typeL.numberOfLines=0;
    [_KHView addSubview:_typeL];
    
    
    _hobbyView=[[UIView alloc] init];
    _hobbyView.hidden=YES;
    [_hobbyView sizeToFit];
    _hobbyView.frame=CGRectMake(20, CGRectGetMaxY(self.segmentView.frame), WIDTH-20-40, 140);
    [self.contentView addSubview:_hobbyView];
    
    BuyerLable *hobby=[BuyerLable creatLabelTextColor:[UIColor blackColor] text:@"爱好"];
    [hobby sizeToFit];
    hobby.frame=CGRectMake(0, 10, WIDTH/6, 25);
    [_hobbyView addSubview:hobby];
    
    _hobbyL=[BuyerLable creatLabelTextColor:[UIColor grayColor] text:@"游泳、爬山、打高尔夫"];
    [_hobbyL sizeToFit];
    _hobbyL.frame=CGRectMake(CGRectGetMaxX(hobby.frame), 10, WIDTH/1.5, 25);
    [_hobbyView addSubview:_hobbyL];
}

#pragma mark ZESegmentedsViewDelegate
- (void)selectedZESegmentedsViewItemAtIndex:(NSInteger )selectedItemIndex {
    switch (selectedItemIndex) {
        case 0:
        {
            _KHView.hidden=NO;
            _hobbyView.hidden=YES;
            break;
        }
        case 1: {
            _KHView.hidden=NO;
            _hobbyView.hidden=YES;
            break;
        }
        case 2: {
            _hobbyView.hidden=NO;
            _KHView.hidden=YES;
            break;
        }
        default:
            break;
    }
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
