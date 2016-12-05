//
//  DownListBgView.h
//  YiFei
//
//  Created by maquanhong on 10/16/16.
//  Copyright © 2016 yous. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DownListBgView;
@protocol DownListBgViewDelegate <NSObject>
@optional
- (void)dismissDownListView:(DownListBgView *)downListView;

@end

@interface DownListBgView : UIView
@property (nonatomic, weak) id<DownListBgViewDelegate> delegate;
@end
