//
//  DownListButton.h
//  YiFei
//
//  Created by maquanhong on 10/16/16.
//  Copyright © 2016 yous. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DownListButton;
@protocol DownListButtonDelegate<NSObject>
@optional
- (void)showList:(DownListButton *)downListBtn;
@end


@interface DownListButton : UIView
@property (nonatomic, weak) id<DownListButtonDelegate> delegate;
@property (nonatomic, strong) UILabel   *btnTitleLabel;
@end
