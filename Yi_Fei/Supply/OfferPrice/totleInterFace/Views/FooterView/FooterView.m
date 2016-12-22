//
//  FooterView.m
//  Yi_Fei
//
//  Created by yons on 16/12/21.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "FooterView.h"




@implementation FooterView


- (instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        [self addContentView];
    }
    return self;
}

-(void)addContentView{

    _footerBtn  = [[UIButton alloc] init];
    [_footerBtn setTitle:@"继续添加" forState:UIControlStateNormal];
    _footerBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    _footerBtn.layer.cornerRadius  =  5;
    [_footerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _footerBtn.backgroundColor = BACKCOLOR;
    [self addSubview:_footerBtn];
 
    [_footerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.leading.mas_equalTo(self).offset(60);
        make.trailing.mas_equalTo(self).offset(-60);
        make.height.mas_equalTo(40);
    }];
   [_footerBtn addTarget:self action:@selector(clickBtnNext) forControlEvents:UIControlEventTouchUpInside];
}


-(void)clickBtnNext{
    if ([self.delegate respondsToSelector:@selector(clickBtn)]) {
        [self.delegate clickBtn];
    }
}























@end












