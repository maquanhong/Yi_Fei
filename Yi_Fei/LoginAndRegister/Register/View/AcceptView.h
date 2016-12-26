//
//  AcceptView.h
//  Yi_Fei
//
//  Created by yons on 16/12/26.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AcceptViewDelegate <NSObject>

-(void)clickView:(UIButton*)btn;

@end


@interface AcceptView : UIView

@property (nonatomic,strong) UIButton *selectBtn;

@property(nonatomic,weak)id<AcceptViewDelegate> delegate;

@end




