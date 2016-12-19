//
//  SelectTwoView.h
//  Yi_Fei
//
//  Created by ZMJ on 16/12/19.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZMJTypeView.h"

@protocol SelectTwoViewDelegate <NSObject>

-(void)clicTypeTwoView:(ZMJTypeView*)view;

@end

@interface SelectTwoView : UITableViewCell


@property (nonatomic,weak) id<SelectTwoViewDelegate> delegate;

@property (nonatomic,strong) ZMJTypeView *typeOne;

@property (nonatomic,strong) UILabel  *typeLabel;




@end
