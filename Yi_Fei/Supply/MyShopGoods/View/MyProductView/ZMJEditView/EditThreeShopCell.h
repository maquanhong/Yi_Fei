//
//  EditThreeShopCell.h
//  Yi_Fei
//
//  Created by yons on 16/11/11.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZMJTypeView.h"


@protocol EditThreeShopCellDelegate <NSObject>

-(void)clickViewTag:(NSInteger)tag;
@end

@interface EditThreeShopCell : UITableViewCell

@property(nonatomic,weak)id<EditThreeShopCellDelegate>  delegate;


@property(nonatomic,strong)UILabel *oneLabel;

@property(nonatomic,strong)UILabel *twoLabel;

@property(nonatomic,strong)ZMJTypeView *typeOneView;

@property(nonatomic,strong)ZMJTypeView *typeTwoView;

@property(nonatomic,strong)UITextField *textFThree;







@end












