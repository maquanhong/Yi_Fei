//
//  MyBuyerAskTableViewCell.m
//  YiFei
//
//  Created by yangyan on 16/9/3.
//  Copyright © 2016年 yous. All rights reserved.
//

#import "MyBuyerAskTableViewCell.h"
#import "BUYButton.h"
#import "BuyerLable.h"
#import "ZESegmentedsView.h"
#import "Macro.h"

@interface MyBuyerAskTableViewCell ()<ZESegmentedsViewDelegate>
@property (nonatomic, strong) ZESegmentedsView  *segmentView;
@end
@implementation MyBuyerAskTableViewCell

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
//    _view=[[UIView alloc] init];
//    [_view sizeToFit];
//    _view.frame=CGRectMake(20, 5, WIDTH-20-40, 30);
//    [self.contentView addSubview:_view];
//    
//    NSArray *array=@[@"最新询价",@"留样询价",@"客户预留询价"];
//    for (int i=0; i<3; i++) {
//        UIButton *button=[BUYButton creatBtnWithBgColor:[UIColor whiteColor] borderColor:NAVCOLOR borderWidth:1.0 titleColor:NAVCOLOR text:array[i]];
//        button.frame=CGRectMake((WIDTH-20-40)/3*i, 5, (WIDTH-20-40)/3, 20);
//        button.tag=60+i;
//        button.titleLabel.font=[UIFont systemFontOfSize:12.0];
//        if (i==0) {
//            button.backgroundColor=NAVCOLOR;
//            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];        }
//        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
//        [_view addSubview:button];
//    }
    _segmentView = [[ZESegmentedsView alloc] initWithFrame:CGRectMake(20, 5, WIDTH-40, 30) segmentedCount:3 segmentedTitles:@[@"最新询价",@"留样询价",@"客户预留询价"]];
    _segmentView.delegate = self;
    [self.contentView addSubview:self.segmentView];
    [self addNewAsk];
}

-(void)addNewAsk{
    for (int i=0; i<2; i++) {
        _askView=[[UIView alloc] init];
        [_askView sizeToFit];
        _askView.hidden=NO;
        _askView.frame=CGRectMake(20, CGRectGetMaxY(self.segmentView.frame)+140*i, WIDTH-20-40, 140);
        [self.contentView addSubview:_askView];
        
        UILabel *shop=[BuyerLable creatLabelTextColor:[UIColor blackColor] text:@"商品："];
        [shop sizeToFit];
        shop.frame=CGRectMake(0, 0, LabelWidth, LabelHeight);
        [_askView addSubview:shop];
        
        UILabel *model=[BuyerLable creatLabelTextColor:[UIColor blackColor] text:@"规格："];
        [model sizeToFit];
        model.frame=CGRectMake(0, CGRectGetMaxY(shop.frame), LabelWidth, LabelHeight);
        [_askView addSubview:model];
        
        UILabel *materialL=[BuyerLable creatLabelTextColor:[UIColor blackColor] text:@"材质："];
        [materialL sizeToFit];
        materialL.frame=CGRectMake(WIDTH/2, CGRectGetMaxY(shop.frame), LabelWidth, LabelHeight);
        [_askView addSubview:materialL];
        
        UILabel *size=[BuyerLable creatLabelTextColor:[UIColor blackColor] text:@"尺寸："];
        [size sizeToFit];
        size.frame=CGRectMake(0, CGRectGetMaxY(model.frame), LabelWidth, LabelHeight);
        [_askView addSubview:size];
        
        UILabel *color=[BuyerLable creatLabelTextColor:[UIColor blackColor] text:@"颜色："];
        [color sizeToFit];
        color.frame=CGRectMake(WIDTH/2, CGRectGetMaxY(materialL.frame), LabelWidth, LabelHeight);
        [_askView addSubview:color];
        
        UILabel *count=[BuyerLable creatLabelTextColor:[UIColor blackColor] text:@"数量："];
        [count sizeToFit];
        count.frame=CGRectMake(0, CGRectGetMaxY(size.frame), LabelWidth, LabelHeight);
        [_askView addSubview:count];
        
        UILabel *noteL=[BuyerLable creatLabelTextColor:[UIColor blackColor] text:@"备注："];
        [noteL sizeToFit];
        noteL.frame=CGRectMake(0, CGRectGetMaxY(count.frame), LabelWidth, LabelHeight);
        [_askView addSubview:noteL];
        
        UIButton *answerB=[BUYButton creatBtnWithBgColor:[UIColor whiteColor] borderColor:NAVCOLOR borderWidth:1.0 titleColor:NAVCOLOR text:@"回复"];
        answerB.frame=CGRectMake(WIDTH-WIDTH/3.5, CGRectGetMaxY(count.frame), LabelWidth, 20);
        answerB.titleLabel.font=[UIFont systemFontOfSize:14.0];
        [answerB addTarget:self action:@selector(answerBClick:) forControlEvents:UIControlEventTouchUpInside];
        [_askView addSubview:answerB];
        
        _shopL=[BuyerLable creatLabelTextColor:[UIColor blackColor] text:@"复古吊灯绣花灯"];
        [_shopL sizeToFit];
        _shopL.frame=CGRectMake(CGRectGetMaxX(shop.frame), 0, WIDTH/2, 25);
        _shopL.font=[UIFont systemFontOfSize:15.0];
        [_askView addSubview:_shopL];
        
        _modelL=[BuyerLable creatLabelTextColor:[UIColor grayColor] text:@"按钮式开关"];
        [_modelL sizeToFit];
        _modelL.frame=CGRectMake(CGRectGetMaxX(size.frame), CGRectGetMaxY(shop.frame), WIDTH/2, LabelHeight);
        [_askView addSubview:_modelL];
        
        _materialL=[BuyerLable creatLabelTextColor:[UIColor grayColor] text:@"PVC塑料"];
        [_materialL sizeToFit];
        _materialL.frame=CGRectMake(CGRectGetMaxX(materialL.frame), CGRectGetMaxY(shop.frame), WIDTH/2, LabelHeight);
        [_askView addSubview:_materialL];
        
        _sizeL=[BuyerLable creatLabelTextColor:[UIColor grayColor] text:@"按钮式开关"];
        [_sizeL sizeToFit];
        _sizeL.frame=CGRectMake(CGRectGetMaxX(size.frame), CGRectGetMaxY(model.frame), WIDTH/2, LabelHeight);
        [_askView addSubview:_sizeL];
        
        
        _colorL=[BuyerLable creatLabelTextColor:[UIColor grayColor] text:@"米黄色"];
        [_colorL sizeToFit];
        _colorL.frame=CGRectMake(CGRectGetMaxX(color.frame), CGRectGetMaxY(materialL.frame), WIDTH/2, LabelHeight);
        [_askView addSubview:_colorL];
        
        
        _countL=[BuyerLable creatLabelTextColor:[UIColor grayColor] text:@"30"];
        [_countL sizeToFit];
        _countL.frame=CGRectMake(CGRectGetMaxX(count.frame), CGRectGetMaxY(size.frame), WIDTH/2, LabelHeight);
        [_askView addSubview:_countL];
        
        _noteL=[BuyerLable creatLabelTextColor:[UIColor grayColor] text:@"吊灯价格最低在哪个范围能接受？"];
        [_noteL sizeToFit];
        _noteL.frame=CGRectMake(CGRectGetMaxX(noteL.frame), CGRectGetMaxY(count.frame), WIDTH/1.2, LabelHeight);
        [_askView addSubview:_noteL];
        
        UIView *lineV=[[UIView alloc] init];
        [lineV sizeToFit];
        lineV.frame=CGRectMake(10, CGRectGetMaxY(noteL.frame)+5, CGRectGetMaxX(_askView.frame)-20, 1);
        lineV.backgroundColor=[UIColor groupTableViewBackgroundColor];
        [_askView addSubview:lineV];
    }
    [self addLeaveView];
}

-(void)addLeaveView{
    for (int i=0; i<2; i++) {
        _leaveView=[[UIView alloc] init];
        [_leaveView sizeToFit];
        _leaveView.hidden=YES;
        _leaveView.frame=CGRectMake(20, CGRectGetMaxY(self.segmentView.frame)+220*i, WIDTH-20-40, 220);
        [self.contentView addSubview:_leaveView];
        
        UILabel *shop=[BuyerLable creatLabelTextColor:[UIColor blackColor] text:@"商品："];
        [shop sizeToFit];
        shop.frame=CGRectMake(0, 0, LabelWidth, LabelHeight);
        [_leaveView addSubview:shop];
        
        UILabel *model=[BuyerLable creatLabelTextColor:[UIColor blackColor] text:@"规格："];
        [model sizeToFit];
        model.frame=CGRectMake(0, CGRectGetMaxY(shop.frame), LabelWidth, LabelHeight);
        [_leaveView addSubview:model];
        
        UILabel *materialL=[BuyerLable creatLabelTextColor:[UIColor blackColor] text:@"材质："];
        [materialL sizeToFit];
        materialL.frame=CGRectMake(WIDTH/2, CGRectGetMaxY(shop.frame), LabelWidth, LabelHeight);
        [_leaveView addSubview:materialL];
        
        UILabel *size=[BuyerLable creatLabelTextColor:[UIColor blackColor] text:@"尺寸："];
        [size sizeToFit];
        size.frame=CGRectMake(0, CGRectGetMaxY(model.frame), LabelWidth, LabelHeight);
        [_leaveView addSubview:size];
        
        UILabel *color=[BuyerLable creatLabelTextColor:[UIColor blackColor] text:@"颜色："];
        [color sizeToFit];
        color.frame=CGRectMake(WIDTH/2, CGRectGetMaxY(materialL.frame), LabelWidth, LabelHeight);
        [_leaveView addSubview:color];
        
        UILabel *count=[BuyerLable creatLabelTextColor:[UIColor blackColor] text:@"数量："];
        [count sizeToFit];
        count.frame=CGRectMake(0, CGRectGetMaxY(size.frame), LabelWidth, LabelHeight);
        [_leaveView addSubview:count];
        
        UIView *lineV=[[UIView alloc] init];
        [lineV sizeToFit];
        lineV.frame=CGRectMake(10, CGRectGetMaxY(count.frame)+5, CGRectGetMaxX(_leaveView.frame)-20, 1);
        lineV.backgroundColor=[UIColor groupTableViewBackgroundColor];
        [_leaveView addSubview:lineV];
        
        _shopView=[[UIView alloc] init];
        [_shopView sizeToFit];
        _shopView.frame=CGRectMake(20, CGRectGetMaxY(lineV.frame), WIDTH-20-40, 125);
        [_leaveView addSubview:_shopView];
        
        _shopModelL=[BuyerLable creatLabelTextColor:[UIColor blackColor] text:@"商品样本"];
        [_shopModelL sizeToFit];
        _shopModelL.frame=CGRectMake(0, CGRectGetMaxY(count.frame), LabelWidth, LabelHeight);
        [_shopView addSubview:_shopModelL];
        
        for (int j=0; j<4; j++) {
            _imgV=[[UIImageView alloc] init];
            [_imgV sizeToFit];
            _imgV.frame=CGRectMake(0, CGRectGetMaxY(_shopModelL.frame), (CGRectGetMaxX(_shopView.frame)-15)/4, (CGRectGetMaxX(_shopView.frame)-15)/4);
            _imgV.backgroundColor=NAVCOLOR;
            [_shopView addSubview:_imgV];
        }
        
        UILabel *noteL=[BuyerLable creatLabelTextColor:[UIColor blackColor] text:@"备注："];
        [noteL sizeToFit];
        noteL.frame=CGRectMake(0, CGRectGetMaxY(_imgV.frame), LabelWidth, LabelHeight);
        [_leaveView addSubview:noteL];
        
        UIButton *answerB=[BUYButton creatBtnWithBgColor:[UIColor whiteColor] borderColor:NAVCOLOR borderWidth:1.0 titleColor:NAVCOLOR text:@"回复"];
        answerB.frame=CGRectMake(WIDTH-WIDTH/3.5, CGRectGetMaxY(_imgV.frame), LabelWidth, 20);
        answerB.titleLabel.font=[UIFont systemFontOfSize:14.0];
        [answerB addTarget:self action:@selector(answerBClick:) forControlEvents:UIControlEventTouchUpInside];
        [_leaveView addSubview:answerB];
        
        _shopL=[BuyerLable creatLabelTextColor:[UIColor blackColor] text:@"复古吊灯绣花灯"];
        [_shopL sizeToFit];
        _shopL.frame=CGRectMake(CGRectGetMaxX(shop.frame), 0, WIDTH/2, LabelHeight);
        _shopL.font=[UIFont systemFontOfSize:15.0];
        [_leaveView addSubview:_shopL];
        
        _modelL=[BuyerLable creatLabelTextColor:[UIColor grayColor] text:@"按钮式开关"];
        [_modelL sizeToFit];
        _modelL.frame=CGRectMake(CGRectGetMaxX(size.frame), CGRectGetMaxY(shop.frame), WIDTH/2, LabelHeight);
        [_leaveView addSubview:_modelL];
        
        _materialL=[BuyerLable creatLabelTextColor:[UIColor grayColor] text:@"PVC塑料"];
        [_materialL sizeToFit];
        _materialL.frame=CGRectMake(CGRectGetMaxX(materialL.frame), CGRectGetMaxY(shop.frame), WIDTH/2, LabelHeight);
        [_leaveView addSubview:_materialL];
        
        _sizeL=[BuyerLable creatLabelTextColor:[UIColor grayColor] text:@"按钮式开关"];
        [_sizeL sizeToFit];
        _sizeL.frame=CGRectMake(CGRectGetMaxX(size.frame), CGRectGetMaxY(model.frame), WIDTH/2, LabelHeight);
        [_leaveView addSubview:_sizeL];
        
        
        _colorL=[BuyerLable creatLabelTextColor:[UIColor grayColor] text:@"米黄色"];
        [_colorL sizeToFit];
        _colorL.frame=CGRectMake(CGRectGetMaxX(color.frame), CGRectGetMaxY(materialL.frame), WIDTH/2, LabelHeight);
        [_leaveView addSubview:_colorL];
        
        
        _countL=[BuyerLable creatLabelTextColor:[UIColor grayColor] text:@"30"];
        [_countL sizeToFit];
        _countL.frame=CGRectMake(CGRectGetMaxX(count.frame), CGRectGetMaxY(size.frame), WIDTH/2, LabelHeight);
        [_leaveView addSubview:_countL];
        
        _noteL=[BuyerLable creatLabelTextColor:[UIColor grayColor] text:@"吊灯价格最低在哪个范围能接受？"];
        [_noteL sizeToFit];
        _noteL.frame=CGRectMake(CGRectGetMaxX(noteL.frame), CGRectGetMaxY(_imgV.frame), WIDTH/1.2, LabelHeight);
        [_leaveView addSubview:_noteL];
    }
}

#pragma mark 
- (void)selectedZESegmentedsViewItemAtIndex:(NSInteger )selectedItemIndex {
    switch (selectedItemIndex) {
        case 0:
        {
            _askView.hidden=NO;
            _shopView.hidden=YES;
            break;
        }
        case 1: {
            _askView.hidden=YES;
            _shopView.hidden=NO;
            break;
        }
        case 2: {

            break;
        }
        default:
            break;
    }
}



-(void)answerBClick:(UIButton *)sender{
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
