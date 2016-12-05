//
//  MemberTwoViewCell.h
//  Yi_Fei
//
//  Created by yons on 16/11/24.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import <UIKit/UIKit.h>



@protocol MemberTwoViewCellDelegate <NSObject>

-(void)payWay:(UIButton*)btn num:(UITableViewCell*)num;

@end


@interface MemberTwoViewCell : UITableViewCell

@property (nonatomic,weak) id<MemberTwoViewCellDelegate> delegate;

@property (nonatomic,strong) NSDictionary  *dict;

@property (nonatomic, strong) TapButton  *iconImageView;

@end






