//
//  ShareActivity.h
//  iDuShare
//
//  Created by duxinfeng on 14-5-7.
//  Copyright (c) 2014年 新风作浪. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol ShareActivityDelegate <NSObject>

-(void)clickButtonView:(NSInteger)index button:(UIButton*)btn;

@end



@interface ShareActivity : UIView


@property (nonatomic,weak)id<ShareActivityDelegate>  delegate;


-(instancetype)initShareActivityView;

-(void)show;


@end
