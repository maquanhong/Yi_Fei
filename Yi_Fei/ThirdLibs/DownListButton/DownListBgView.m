//
//  DownListBgView.m
//  YiFei
//
//  Created by maquanhong on 10/16/16.
//  Copyright © 2016 yous. All rights reserved.
//

#import "DownListBgView.h"

@implementation DownListBgView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    if (self.delegate && [self.delegate respondsToSelector:@selector(dismissDownListView:)]) {
        [self.delegate dismissDownListView:self];
    }
}

@end
