//
//  BUYTextView.h
//  YiFei
//
//  Created by yons on 16/8/26.
//  Copyright © 2016年 yous. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BUYTextView;

@protocol BUYTextViewDelegate <NSObject>

@optional
- (void) pushViewcontroller:(BUYTextView *)BuyTextView;

@end

@interface BUYTextView : UIView

+ (instancetype) creatTextView;

//代理属性
@property (nonatomic,weak) id<BUYTextViewDelegate> delegate;

@end
