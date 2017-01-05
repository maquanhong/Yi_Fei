//
//  UIBarButtonItem+AllWork.m
//  HealthMagazine
//
//  Created by 徐友明 on 16/9/8.
//  Copyright © 2016年 yous. All rights reserved.
//

#import "UIBarButtonItem+AllWork.h"
@implementation UIBarButtonItem (AllWork)








+ (UIBarButtonItem *)itemWithImageBJName:(NSString *)titleName target:(id)target action:(SEL)action{
    
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [button setTitle:titleName forState:(UIControlStateNormal)];
    button.frame = CGRectMake(0, 1, 65, 30);
    //监听按钮点击事件
    [button addTarget:target action:action forControlEvents:(UIControlEventTouchUpInside)];
    [button setTitle:titleName forState:(UIControlStateNormal)];
    [button setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    //        button.backgroundColor = [UIColor yellowColor];
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0,75, 30)];
    
    [view addSubview:button];
    
    return [[UIBarButtonItem alloc] initWithCustomView:view];
    
}

@end
