//
//  FooterView.h
//  Yi_Fei
//
//  Created by yons on 16/12/21.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FooterViewDelegate <NSObject>

-(void)clickBtn;

@end


@interface FooterView : UIView

@property (nonatomic,weak) id<FooterViewDelegate> delegate;

@property (nonatomic,strong) UIButton *footerBtn;

@end








