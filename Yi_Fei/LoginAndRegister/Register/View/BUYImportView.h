//
//  BUYImportView.h
//  YiFei
//
//  Created by yons on 16/8/26.
//  Copyright © 2016年 yous. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BUYImportViewDelegate <NSObject>

@optional
- (void) judgeMail;

@end

@interface BUYImportView : UIView

@property (nonatomic,copy) UIColor *borderColor;

+ (instancetype)creatImportViewWithStr:(NSString *)placehold flag:(BOOL) isflag leftImg:(NSString *) leftimg;

//代理
@property (nonatomic,weak) id<BUYImportViewDelegate> delegate;

@property (nonatomic,weak) UITextField *field;

@end
