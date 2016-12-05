//
//  BuyerEditTableViewCell.m
//  Yi_Fei
//
//  Created by yons on 16/11/24.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "BuyerEditFirstCell.h"

@interface BuyerEditFirstCell ()

@property(nonatomic,strong)UIImageView *iconImageView;

@property(nonatomic,strong)UILabel *paramLabel;

@property(nonatomic,strong)UILabel *englishLabel;

@property(nonatomic,strong)UIView *line;

@property(nonatomic,strong)UILabel *leftNameLableOne;

@property(nonatomic,strong)UILabel *leftNameLableTwo;

@property(nonatomic,strong)UILabel *leftNameLableThree;

@property(nonatomic,strong)UILabel *leftParamLabelOne;

@property(nonatomic,strong)UILabel *leftParamLabelTwo;

@property(nonatomic,strong)UILabel *leftParamLabelThree;

@property(nonatomic,strong)UILabel *rightNameLabelOne;

@property(nonatomic,strong)UILabel *rightNameLabelTwo;

@property(nonatomic,strong)UILabel *rightNameLabelThree;

@property(nonatomic,strong)UILabel *rightParamLabelOne;

@property(nonatomic,strong)UILabel *rightParamLabelTwo;

@property(nonatomic,strong)UILabel *rightParamLabelThree;

@property(nonatomic,strong)UILabel *describLabel;

@property(nonatomic,strong)UILabel *contentLabel;


@end


@implementation BuyerEditFirstCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self addView];
    }
    return self;
}


-(void)addView{
    
    UIView *backView = [[UIView alloc] init];
    backView.backgroundColor = [UIColor whiteColor];
    backView.layer.cornerRadius = 10 ;
    [self addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self).offset(10);
        make.trailing.mas_equalTo(self).offset(-10);
        make.top.mas_equalTo(self.mas_top).offset(10);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-10);
    }];
    
    _iconImageView= [[UIImageView alloc] init];
    _iconImageView.image = [UIImage imageNamed:@"canshu_icon"];
    [backView addSubview:_iconImageView];
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(backView).offset(10);
        make.top.mas_equalTo(backView.mas_top).offset(10);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    
    _paramLabel = [[UILabel alloc] init];
    _paramLabel.text = @"商品参数";
    [backView addSubview:_paramLabel];
    [_paramLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_iconImageView.mas_right).offset(10);
        make.centerY.mas_equalTo(_iconImageView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(70, 30));
    }];
    
    _englishLabel = [[UILabel alloc] init];
    _englishLabel.text = @"Parameters";
    _englishLabel.font = [UIFont systemFontOfSize:14];
    [backView addSubview:_englishLabel];
    [_englishLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_paramLabel.mas_right).offset(10);
        make.centerY.mas_equalTo(_paramLabel.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(100, 30));
    }];
    
    _line = [[UIView alloc] init];
    _line.backgroundColor = [UIColor grayColor];
    [backView addSubview:_line];
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(backView);
        make.trailing.mas_equalTo(backView);
        make.top.mas_equalTo(_iconImageView.mas_bottom).offset(10);
        make.height.mas_equalTo(1);
    }];
    
    _leftNameLableOne = [[UILabel alloc] init];
    _leftNameLableOne.text = @"公司货号";
    _leftNameLableOne.font = [UIFont systemFontOfSize:14];
    [backView addSubview:_leftNameLableOne];
    [_leftNameLableOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(backView).offset(10);
        make.top.mas_equalTo(_line.mas_bottom).offset(10);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(20);
    }];
    
    
    _leftParamLabelOne = [[UILabel alloc] init];
    _leftParamLabelOne.font = [UIFont systemFontOfSize:14];
    [backView addSubview:_leftParamLabelOne];
    [_leftParamLabelOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_leftNameLableOne.mas_right).offset(5);
        make.centerY.mas_equalTo(_leftNameLableOne.mas_centerY);
        make.width.mas_equalTo(85);
        make.height.mas_equalTo(20);
    }];
    
    
    
    _leftNameLableTwo = [[UILabel alloc] init];
    _leftNameLableTwo.text = @"公司尺寸";
    _leftNameLableTwo.font = [UIFont systemFontOfSize:14];
    [backView addSubview:_leftNameLableTwo];
    [_leftNameLableTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(_leftNameLableOne);
        make.top.mas_equalTo(_leftNameLableOne.mas_bottom).offset(5);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(20);
    }];
    
    _leftParamLabelTwo = [[UILabel alloc] init];
    _leftParamLabelTwo.font = [UIFont systemFontOfSize:14];
    [backView addSubview:_leftParamLabelTwo];
    [_leftParamLabelTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_leftNameLableTwo.mas_right).offset(5);
        make.centerY.mas_equalTo(_leftNameLableTwo.mas_centerY);
        make.width.mas_equalTo(85);
        make.height.mas_equalTo(20);
    }];
    
    _leftNameLableThree = [[UILabel alloc] init];
    _leftNameLableThree.text = @"报价日期";
    _leftNameLableThree.font = [UIFont systemFontOfSize:14];
    [backView addSubview:_leftNameLableThree];
    [_leftNameLableThree mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(_leftNameLableTwo);
        make.top.mas_equalTo(_leftNameLableTwo.mas_bottom).offset(5);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(20);
    }];
    
    _leftParamLabelThree = [[UILabel alloc] init];
    _leftParamLabelThree.font = [UIFont systemFontOfSize:14];
    [backView addSubview:_leftParamLabelThree];
    [_leftParamLabelThree mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_leftNameLableThree.mas_right).offset(5);
        make.centerY.mas_equalTo(_leftNameLableThree.mas_centerY);
        make.width.mas_equalTo(85);
        make.height.mas_equalTo(20);
    }];
    
    _rightNameLabelOne = [[UILabel alloc] init];
    _rightNameLabelOne.text = @"材质";
    _rightNameLabelOne.textAlignment = NSTextAlignmentCenter;
    _rightNameLabelOne.font = [UIFont systemFontOfSize:14];
    [backView addSubview:_rightNameLabelOne];
    [_rightNameLabelOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_leftParamLabelOne.mas_right).offset(5);
        make.centerY.mas_equalTo(_leftParamLabelOne.mas_centerY);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(20);
    }];
    
    _rightParamLabelOne = [[UILabel alloc] init];
    _rightParamLabelOne.font = [UIFont systemFontOfSize:14];
    [backView addSubview:_rightParamLabelOne];
    [_rightParamLabelOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_rightNameLabelOne.mas_right).offset(5);
        make.centerY.mas_equalTo(_rightNameLabelOne.mas_centerY);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(20);
    }];
    
    _rightNameLabelTwo = [[UILabel alloc] init];
    _rightNameLabelTwo.text = @"颜色";
    _rightNameLabelTwo.textAlignment = NSTextAlignmentCenter;
    _rightNameLabelTwo.font = [UIFont systemFontOfSize:14];
    [backView addSubview:_rightNameLabelTwo];
    [_rightNameLabelTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_leftParamLabelTwo.mas_right).offset(5);
        make.centerY.mas_equalTo(_leftParamLabelTwo.mas_centerY);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(20);
    }];
    
    _rightParamLabelTwo = [[UILabel alloc] init];
    _rightParamLabelTwo.font = [UIFont systemFontOfSize:14];
    [backView addSubview:_rightParamLabelTwo];
    [_rightParamLabelTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_rightNameLabelTwo.mas_right).offset(5);
        make.centerY.mas_equalTo(_rightNameLabelTwo.mas_centerY);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(20);
    }];
    
    
    _rightNameLabelThree = [[UILabel alloc] init];
    _rightNameLabelThree.text = @"条款";
    _rightNameLabelThree.textAlignment = NSTextAlignmentCenter;
    _rightNameLabelThree.font = [UIFont systemFontOfSize:14];
    [backView addSubview:_rightNameLabelThree];
    [_rightNameLabelThree mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_leftParamLabelThree.mas_right).offset(5);
        make.centerY.mas_equalTo(_leftParamLabelThree.mas_centerY);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(20);
    }];
    
    _rightParamLabelThree = [[UILabel alloc] init];
    _rightParamLabelThree.font = [UIFont systemFontOfSize:14];
    [backView addSubview:_rightParamLabelThree];
    [_rightParamLabelThree mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_rightNameLabelThree.mas_right).offset(5);
        make.centerY.mas_equalTo(_rightNameLabelThree.mas_centerY);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(20);
    }];
    
    _describLabel =[[UILabel alloc] init];
    _describLabel.text = @"备       注";
    _describLabel.font = [UIFont systemFontOfSize:14];
    [backView addSubview:_describLabel];
    [_describLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(_leftNameLableThree);
        make.top.mas_equalTo(_leftNameLableThree.mas_bottom).offset(10);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(20);
    }];
    
    
    _contentLabel =[[UILabel alloc] init];
    _contentLabel.font = [UIFont systemFontOfSize:14];
    _contentLabel.numberOfLines = 0;
    [backView addSubview:_contentLabel];
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_describLabel.mas_right).offset(5);
        make.trailing.mas_equalTo(backView).offset(-10);
        make.top.mas_equalTo(_describLabel.mas_top);
    }];
}

- (void)setProductionObjc:(ProductionData *)productionObjc{
    
    _productionObjc = productionObjc;
    _leftParamLabelOne.text = productionObjc.companyID;
    _leftParamLabelTwo.text = productionObjc.shopSize;
    _leftParamLabelThree.text = @"2016-11-22";
    _rightParamLabelOne.text = productionObjc.shopMed;
    _rightParamLabelTwo.text = productionObjc.shopColor;
    _rightParamLabelThree.text = productionObjc.shopTiaoK;
    _contentLabel.text = productionObjc.shopDescribe;
    
}











@end





















