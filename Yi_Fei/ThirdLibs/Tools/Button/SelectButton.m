//
//  SelectButton.m
//  Yi_Fei
//
//  Created by yons on 16/12/13.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "SelectButton.h"

@implementation SelectButton

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent*)event
{
    
    CGRect bounds = self.bounds;
    //若原热区小于30x30，则放大热区，否则保持原大小不变
    CGFloat widthDelta = MAX(130 - bounds.size.width, 0);
    CGFloat heightDelta = MAX(110 - bounds.size.height, 0);
    bounds = CGRectInset(bounds, -1.0 * widthDelta, -1.0 * heightDelta);
    return CGRectContainsPoint(bounds, point);
    
}

@end
