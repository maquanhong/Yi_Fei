//
//  ZMJAddGoodsTwoView.h
//  Yi_Fei
//
//  Created by yons on 16/11/9.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZMJTypeView.h"

@protocol ZMJAddGoodsTwoViewDelegate <NSObject>

-(void)clickViewTag:(NSInteger)tag;

@end

@interface ZMJAddGoodsTwoView : UIView<UITextFieldDelegate>

@property(nonatomic,weak)id<ZMJAddGoodsTwoViewDelegate> delegate;

@property(nonatomic,strong)UILabel *nameLabel;

@property(nonatomic,strong)UITextField *textFOne;

@property(nonatomic,strong)UITextField *textFTwo;

@property(nonatomic,strong)ZMJTypeView *typeOneView;

@property(nonatomic,strong)ZMJTypeView *typeTwoView;

@property(nonatomic,strong)UITextField *textFThree;


@end



















