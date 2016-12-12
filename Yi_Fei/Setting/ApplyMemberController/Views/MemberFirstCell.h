//
//  MemberFirstCell.h
//  Yi_Fei
//
//  Created by yons on 16/12/12.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZMJTypeView.h"

@protocol MemberFirstCellDelegate <NSObject>

-(void)clickButton:(UIButton*)btn index:(UITableViewCell*)index;

@end

@interface MemberFirstCell : UITableViewCell

@property (nonatomic,weak) id<MemberFirstCellDelegate> delegate;

@property (nonatomic,strong) ZMJTypeView *typeView;

@end







