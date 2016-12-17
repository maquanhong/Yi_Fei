//
//  SixCell.h
//  Yi_Fei
//
//  Created by yons on 16/12/14.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZMJTypeView.h"

@protocol SixCellDelegate <NSObject>

-(void)clickViewTag:(NSInteger)tag;

@end


@interface SixCell : UITableViewCell

@property(nonatomic,weak)id<SixCellDelegate> delegate;

@property (nonatomic,strong) ZMJTypeView *typeOneView;

@property (nonatomic,strong) ZMJTypeView *typeTwoView;

@property (nonatomic,strong) ZMJTypeView *typeThreeView;

@property (nonatomic,strong) ZMJTypeView *typeFourView;

@property (nonatomic,strong) UITextField *addressText;


@end
