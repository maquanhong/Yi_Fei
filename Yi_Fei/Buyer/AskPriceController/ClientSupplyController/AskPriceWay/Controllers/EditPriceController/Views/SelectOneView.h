//
//  SelectOneView.h
//  Yi_Fei
//
//  Created by ZMJ on 16/12/18.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZMJTypeView.h"

@protocol SelectOneViewDelegate <NSObject>

-(void)clicTypeOnekView:(ZMJTypeView*)view;

@end

@interface SelectOneView : UITableViewCell

@property (nonatomic,weak) id<SelectOneViewDelegate> delegate;

@property (nonatomic,strong) ZMJTypeView *typeOne;

@property (nonatomic,strong) UILabel  *typeLabel;


@end




