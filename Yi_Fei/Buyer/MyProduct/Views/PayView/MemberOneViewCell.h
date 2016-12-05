//
//  MemberViewCell.h
//  Yi_Fei
//
//  Created by yons on 16/11/24.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MemberOneViewCellDelegate <NSObject>

-(void)clickButton:(UIButton*)btn index:(UITableViewCell*)index;

@end

@interface MemberOneViewCell : UITableViewCell


@property (nonatomic,weak) id<MemberOneViewCellDelegate> delegate;


@property (nonatomic, strong) TapButton  *iconImageView;

@property (nonatomic,strong) NSDictionary  *dict;

@end









