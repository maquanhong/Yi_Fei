//
//  SevenCell.h
//  Yi_Fei
//
//  Created by yons on 16/12/14.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZMJTypeView.h"


@protocol SevenDelegate <NSObject>

-(void)clickViewnumber:(NSInteger)tag;

@end


@interface SevenCell : UITableViewCell

@property(nonatomic,weak)id<SevenDelegate> delegate;

@property (nonatomic,strong) ZMJTypeView *typeOneView;

@property (nonatomic,strong) ZMJTypeView *typeTwoView;

@property (nonatomic,strong) ZMJTypeView *typeThreeView;

@property (nonatomic,strong) UITextField *otherText;




@end







