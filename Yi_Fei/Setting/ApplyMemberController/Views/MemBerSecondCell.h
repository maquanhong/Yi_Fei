//
//  MemBerSecondCell.h
//  Yi_Fei
//
//  Created by yons on 16/12/12.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MemBerSecondCellDelegate <NSObject>

-(void)payWay:(UIButton*)btn num:(UITableViewCell*)num;

@end



@interface MemBerSecondCell : UITableViewCell

@property (nonatomic,strong) NSDictionary  *dict;

@property (nonatomic,weak) id<MemBerSecondCellDelegate> delegate;

@property (nonatomic, strong) TapButton  *iconImageView;

@end
