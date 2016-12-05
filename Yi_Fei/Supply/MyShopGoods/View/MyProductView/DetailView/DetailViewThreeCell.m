
//
//  DetailViewThreeCell.m
//  Yi_Fei
//
//  Created by yons on 16/11/12.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "DetailViewThreeCell.h"

@interface DetailViewThreeCell ()

@property(nonatomic,strong)UIImageView *iconImageView;

@property(nonatomic,strong)UILabel *paramLabel;

@property(nonatomic,strong)UILabel *englishLabel;

@property(nonatomic,strong)UIView *line;

@property(nonatomic,strong)UILabel *customerLabel;

@property(nonatomic,strong)UILabel *customerContentLabel;

@property(nonatomic,strong)UILabel *offerLabel;

@property(nonatomic,strong)UILabel *offerContentLabel;

@property(nonatomic,strong)UILabel *dateLabel;

@property(nonatomic,strong)UILabel *dateContentLabel;


@end

@implementation DetailViewThreeCell

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
        make.top.mas_equalTo(self.mas_top);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-10);
    }];
    
    _iconImageView= [[UIImageView alloc] init];
    _iconImageView.image = [UIImage imageNamed:@"jieshao_icon"];
    [backView addSubview:_iconImageView];
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(backView).offset(10);
        make.top.mas_equalTo(backView.mas_top).offset(10);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    
    _paramLabel = [[UILabel alloc] init];
    _paramLabel.text = @"询价客户";
    [backView addSubview:_paramLabel];
    [_paramLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_iconImageView.mas_right).offset(10);
        make.centerY.mas_equalTo(_iconImageView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(70, 30));
    }];
    
    _englishLabel = [[UILabel alloc] init];
    _englishLabel.text = @"Inquiry";
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
    
    
    for (NSInteger i = 0 ; i < 6; i++) {
        
        _customerLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(backView.frame) + 10, CGRectGetMinY(backView.frame) + 50 + 30 * i , 30, 20 )];
        _customerLabel.text = @"客户";
        _customerLabel.font = [UIFont systemFontOfSize:14];
        [backView addSubview:_customerLabel];
        
        _customerContentLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_customerLabel.frame), CGRectGetMinY(backView.frame) + 50 + 30 * i , 60, 20 )];
        _customerContentLabel.text = @"aaaaaa";
      _customerContentLabel.font = [UIFont systemFontOfSize:14];
        [backView addSubview:_customerContentLabel];
        
    }
    

    
    for (NSInteger i = 0 ; i < 6; i++) {
        
        _offerLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_customerContentLabel.frame) + 5, CGRectGetMinY(backView.frame) + 50 + 30 * i , 30, 20 )];
       _offerLabel.text = @"报价";
     _offerLabel.font = [UIFont systemFontOfSize:14];
        [backView addSubview:_offerLabel];
        
        _offerContentLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_offerLabel.frame), CGRectGetMinY(backView.frame) + 50 + 30 * i , 60, 20 )];
        _offerContentLabel.text = @"bbbbbb";
     _offerContentLabel.font = [UIFont systemFontOfSize:14];
        [backView addSubview:_offerContentLabel];
        
    }
    
    
    for (NSInteger i = 0 ; i < 6; i++) {
        
        _dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_offerContentLabel.frame) + 5, CGRectGetMinY(backView.frame) + 50 + 30 * i , 30, 20 )];
        _dateLabel.text = @"日期";
        _dateLabel.font = [UIFont systemFontOfSize:14];
        [backView addSubview:_dateLabel];
        
        _dateContentLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_dateLabel.frame), CGRectGetMinY(backView.frame) + 50 + 30 * i , 60, 20 )];
        _dateContentLabel.text = @"cccccc";
        _dateContentLabel.font = [UIFont systemFontOfSize:14];

        [backView addSubview:_dateContentLabel];
        
    }
    
}


































- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}








@end




















