//
//  EditSelectViewCell.h
//  Yi_Fei
//
//  Created by yons on 16/12/16.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZMJTypeView.h"

@protocol EditSelectViewCellDelegate <NSObject>

-(void)clickOneView:(ZMJTypeView*)view;

@end

@interface EditSelectViewCell : UITableViewCell

@property (nonatomic,weak) id<EditSelectViewCellDelegate> delegate;

@property (nonatomic,strong) ZMJTypeView *typeOne;

@property (nonatomic,strong) UILabel  *typeLabel;


@end



