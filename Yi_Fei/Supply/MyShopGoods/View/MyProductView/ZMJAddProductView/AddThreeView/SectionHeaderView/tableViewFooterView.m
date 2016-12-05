
//
//  tableViewFooterView.m
//  Yi_Fei
//
//  Created by ZMJ on 16/11/9.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "tableViewFooterView.h"

@implementation tableViewFooterView

- (instancetype)init{
    self = [super init];
    if (!self) {
        return nil;
    }
    [self createSubView];
    return  self;
}


-(void)createSubView
{
    _certainBtn = [[UIButton alloc] init];
    [_certainBtn setTitle:@"确定" forState:UIControlStateNormal];
    [_certainBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _certainBtn.backgroundColor = BACKCOLOR;
    [self addSubview:_certainBtn];
    [_certainBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(100, 20));
    }];
    
}





















@end

























