//
//  ExhibitionViewCell.m
//  Yi_Fei
//
//  Created by yons on 16/11/16.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "ExhibitionViewCell.h"
#import "PureLayout.h"

@interface ExhibitionViewCell ()

@property (strong, nonatomic) UILabel   *titleLabel;
@property (strong, nonatomic) UILabel   *timeLabel;

@end

@implementation ExhibitionViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addViewConstraints];
    }
    return self;
}

- (void)addViewConstraints {
    
    _titleLabel =[[UILabel alloc] init];
    _titleLabel.textColor=[UIColor blackColor];
    _titleLabel.font=[UIFont systemFontOfSize:14.0];
    [_titleLabel sizeToFit];
    _titleLabel.textAlignment=NSTextAlignmentCenter;
    [self addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self).offset(10);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.height.mas_equalTo(20);
    }];
    
    _timeLabel =[[UILabel alloc] init];
    _timeLabel.textColor=[UIColor blackColor];
    _timeLabel.font=[UIFont systemFontOfSize:14.0];
    [_timeLabel sizeToFit];
    _timeLabel.textAlignment=NSTextAlignmentCenter;
    [self addSubview:_timeLabel];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_titleLabel.mas_right).offset(15);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(100, 20));
    }];
}


-(void)setDict:(NSDictionary *)dict
{
    _titleLabel.text = dict[@"title"];
    _timeLabel.text = dict[@"time"];

}





//xym
-(void)setModel:(ExibitionModel *)model{
    _titleLabel.text = model.title;
    
    NSString *  dateStr=[NSString stringWithFormat:@"%@",model.state];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date=[NSDate dateWithTimeIntervalSince1970:(NSTimeInterval)[dateStr doubleValue]/1000];
    
    NSString  *timeString=[formatter stringFromDate:date];
    
    _timeLabel.text = timeString;
    
}






@end













