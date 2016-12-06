//
//  TapButton.m
//  YBLogistics
//
//  Created by yons on 16/10/28.
//  Copyright © 2016年 Practice. All rights reserved.
//

#import "TapButton.h"


@implementation TapButton


- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent*)event
{
    
    CGRect bounds = self.bounds;
    //若原热区小于30x30，则放大热区，否则保持原大小不变
    CGFloat widthDelta = MAX(WIDTH - bounds.size.width, 0);
    CGFloat heightDelta = MAX(30.0 - bounds.size.height, 0);
    bounds = CGRectInset(bounds, -1.0 * widthDelta, -1.0 * heightDelta);
    return CGRectContainsPoint(bounds, point);
    
}









@end






























