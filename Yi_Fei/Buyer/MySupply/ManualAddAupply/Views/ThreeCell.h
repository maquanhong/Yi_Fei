//
//  ThreeCell.h
//  Yi_Fei
//
//  Created by yons on 16/12/14.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZMJTypeView.h"

@protocol ThreeCellDelegate <NSObject>

-(void)clickViewTag;

@end

@interface ThreeCell : UITableViewCell

@property (nonatomic,strong) ZMJTypeView *typeOneView;

@property (nonatomic,strong) UITextField *textFiled;

@property(nonatomic,weak)id<ThreeCellDelegate> delegate;


@end
