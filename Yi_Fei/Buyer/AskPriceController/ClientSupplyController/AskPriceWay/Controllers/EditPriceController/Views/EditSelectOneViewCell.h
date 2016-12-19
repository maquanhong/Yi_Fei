//
//  EditSelectOneViewCell.h
//  Yi_Fei
//
//  Created by ZMJ on 16/12/19.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZMJTypeView.h"

@protocol EditSelectOneViewCellDelegate <NSObject>

-(void)clickTwoView:(ZMJTypeView*)view;

@end


@interface EditSelectOneViewCell : UITableViewCell

@property (nonatomic,weak) id<EditSelectOneViewCellDelegate> delegate;

@property (nonatomic,strong) ZMJTypeView *typeOne;
@property (nonatomic,strong) UITextField *textFiled;

@property (nonatomic,strong) UILabel  *typeLabel;

@end
