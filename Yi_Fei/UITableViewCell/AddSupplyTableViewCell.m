//
//  AddSupplyTableViewCell.m
//  YiFei
//
//  Created by yangyan on 16/9/7.
//  Copyright © 2016年 yous. All rights reserved.
//

#import "AddSupplyTableViewCell.h"
@interface AddSupplyTableViewCell ()<UITextFieldDelegate>
@end

@implementation AddSupplyTableViewCell

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
    UIView *leftV=[[UIView alloc] init];
    [leftV sizeToFit];
    leftV.backgroundColor=[UIColor whiteColor];
    leftV.frame=CGRectMake(0, 10, WIDTH/5, 60);
    [self.contentView addSubview:leftV];
    
    _label=[[UILabel alloc] init];
    [_label sizeToFit];
    _label.frame=CGRectMake(0, 10, WIDTH/5, 40);
    _label.textColor=COLOR;
    _label.font=[UIFont systemFontOfSize:15.0];
    _label.textAlignment=NSTextAlignmentCenter;
    [leftV addSubview:_label];
    
    UIView *lineView=[[UIView alloc] init];
    lineView.frame=CGRectMake(CGRectGetMaxX(leftV.frame), 10, 1, 60);
    [self.contentView addSubview:lineView];
    
    UIView *rightV=[[UIView alloc] init];
    [rightV sizeToFit];
    rightV.backgroundColor=[UIColor whiteColor];
    rightV.frame=CGRectMake(CGRectGetMaxX(leftV.frame)+1, 10,WIDTH-WIDTH/6, 60);
    [self.contentView addSubview:rightV];
    
    
    _valueTF=[[UITextField alloc] init];
    _valueTF.delegate = self;
    [_valueTF sizeToFit];
    _valueTF.frame=CGRectMake(10, 0, WIDTH/1.5, 60);
    _valueTF.textColor=[UIColor blackColor];
    _valueTF.font=[UIFont systemFontOfSize:16.0];
    [rightV addSubview:_valueTF];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
