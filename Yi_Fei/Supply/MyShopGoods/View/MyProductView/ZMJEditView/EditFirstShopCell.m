//
//  editShopTableViewCell.m
//  YiFei
//
//  Created by yangyan on 16/9/9.
//  Copyright © 2016年 yous. All rights reserved.
//

#import "EditFirstShopCell.h"


@implementation EditFirstShopCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
  
        [self addView];
    }
    return self;
}


-(void)addView{
   
    _nameLabel=[[UILabel alloc] init];
    _nameLabel.textColor=[UIColor blackColor];
    _nameLabel.font=[UIFont systemFontOfSize:14.0];
    [_nameLabel sizeToFit];
    _nameLabel.textAlignment=NSTextAlignmentCenter;
    [self addSubview:_nameLabel];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self).offset(10);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.height.mas_equalTo(25);
        make.width.mas_equalTo(60);
    }];
    
    UIView *lineV=[[UIView alloc] init];
    lineV.backgroundColor=[UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1.0];
    [self addSubview:lineV];
    [lineV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self);
        make.trailing.mas_equalTo(self);
        make.bottom.mas_equalTo(self.mas_bottom);
        make.height.mas_equalTo(1.0);
    }];
    
    _textF=[[UITextField alloc] init];
    _textF.font=[UIFont systemFontOfSize:14.0];
    [_textF sizeToFit];
    [self addSubview:_textF];
    [_textF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_nameLabel.mas_right).offset(15);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.trailing.mas_equalTo(self).offset(-10);
        make.height.mas_equalTo(25);
    }];
    
    
}





- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
