//
//  ThreeOneCell.h
//  Yi_Fei
//
//  Created by yons on 16/12/22.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZMJTypeView.h"

@protocol ThreeOneCellDelegate <NSObject>

-(void)clickView:(NSInteger)index;

@end

@interface ThreeOneCell : UITableViewCell

@property (nonatomic,strong) id<ThreeOneCellDelegate> delegate;

@property (nonatomic,strong) UILabel *titleLabel;

@property (nonatomic,strong) ZMJTypeView *typeOne;

@property (nonatomic,strong) UITextField *textFiled;

@end














