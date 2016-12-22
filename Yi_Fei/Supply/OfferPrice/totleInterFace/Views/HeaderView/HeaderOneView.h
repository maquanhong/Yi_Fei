//
//  HeaderOneView.h
//  Yi_Fei
//
//  Created by yons on 16/12/21.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZMJTypeView.h"

@protocol HeaderOneViewDelegate <NSObject>

-(void)clickPiceDate;

@end

@interface HeaderOneView : UIView

@property (nonatomic,strong) UILabel *titleLabel;

@property (nonatomic,strong) ZMJTypeView *typeTwo;


@property (nonatomic,weak) id<HeaderOneViewDelegate> delegate;



@end







