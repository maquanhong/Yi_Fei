//
//  SecondViewCell.h
//  Yi_Fei
//
//  Created by yons on 16/12/16.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZMJTypeView.h"

@protocol SecondViewCellDelegate <NSObject>

-(void)clickView;

@end


@interface SecondViewCell : UITableViewCell

@property (nonatomic,weak) id<SecondViewCellDelegate> delegate;

@property (nonatomic,strong) ZMJTypeView *typViewOne;

@end
