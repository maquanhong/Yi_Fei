//
//  SectionOneCell.h
//  Yi_Fei
//
//  Created by yons on 16/12/22.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZMJTypeView.h"


@protocol SectionOneCellDelegate <NSObject>

-(void)clickView:(NSInteger)index;

@end


@interface SectionOneCell : UITableViewCell

@property (nonatomic,strong) id<SectionOneCellDelegate> delegate;


@property (nonatomic,strong) UILabel *titleLabel;

@property (nonatomic,strong) UITextField *textFiled;

@property (nonatomic,strong) UILabel *nextLabel;

@property (nonatomic,strong) ZMJTypeView *typeOne;


@end

