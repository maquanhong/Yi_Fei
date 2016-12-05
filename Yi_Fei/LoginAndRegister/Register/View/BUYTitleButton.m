//
//  MBTitleButton.m
//  高仿微博
//
//  Created by yangxiaofei on 16/3/6.
//  Copyright (c) 2016年 yangxiaofei. All rights reserved.
//

#import "BUYTitleButton.h"
#import "UIView+Layout.h"

@implementation BUYTitleButton

//重写initWithFrame方法
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //不需要设置大小，添加到标题的时候会自动设置
        //所以，初始化的时候设置好需要的属性
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return self;
}

//重写布局，将图片放到右边，将文字放到左边
- (void)layoutSubviews
{
    
    [super layoutSubviews];
    //将图片和文字框互换
    //方法1:
        self.titleLabel.x = 3;
        [self setImageEdgeInsets:UIEdgeInsetsMake(12, self.titleLabel.width+8, 10, 8)];
}


//重写一下title和imageview的set方法，分别设置这两个控件的大小
- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    
    //确定使该控件的大小自适应
    [self sizeToFit];
}
- (void)setImage:(UIImage *)image forState:(UIControlState)state
{
    [super setImage:image forState:state];
    
    [self sizeToFit];
}


@end
