//
//  TwoTableViewCell.h
//  Yi_Fei
//
//  Created by yons on 16/12/29.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZMJTypeView.h"

@protocol TwoTableViewCellDelegate <NSObject>

-(void)clickView:(NSInteger)index;

@end


@interface TwoTableViewCell : UITableViewCell

@property (nonatomic,weak) id<TwoTableViewCellDelegate> delegate;


@property (nonatomic,strong) ZMJTypeView *typeOne;

@property (nonatomic,strong) ZMJTypeView *typeTwo;

@property (nonatomic,strong) ZMJTypeView *typeThree;

@property (nonatomic,strong) ZMJTypeView *typeFour;

@property (nonatomic,strong) UILabel *titleLabel;




@end
