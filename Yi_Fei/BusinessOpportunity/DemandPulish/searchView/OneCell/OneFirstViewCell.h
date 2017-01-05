//
//  OneFirstViewCell.h
//  Yi_Fei
//
//  Created by yons on 16/12/28.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.

#import <UIKit/UIKit.h>
#import "TypeListView.h"

@protocol OneFirstViewCellDelegate <NSObject>

-(void)clickViewCell:(UITableViewCell*)cell;

@end


@interface OneFirstViewCell : UITableViewCell

@property (nonatomic,weak) id<OneFirstViewCellDelegate> delegate;

@property (nonatomic,strong) UILabel *titleLabel;

@property (nonatomic,strong) TypeListView *typeView;


@end























