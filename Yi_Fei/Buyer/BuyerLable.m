//
//  BuyerLable.m
//  YiFei
//
//  Created by yangyan on 16/9/5.
//  Copyright © 2016年 yous. All rights reserved.
//

#import "BuyerLable.h"

@implementation BuyerLable

+ (instancetype)creatLabelTextColor:(UIColor *)TextColor text:(NSString *)text
{
    BuyerLable *lable =[[BuyerLable alloc] init];
    //设置属性
    lable.font=[UIFont systemFontOfSize:14.0];
    lable.textColor=TextColor;
    lable.text=text;
    
    return lable;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
