//
//  ZESegmentedsView.m
//  
//
//  Created by wzm on 16/4/8.
//  Copyright © 2016年 wzm. All rights reserved.
//

#import "ZESegmentedsView.h"
@interface ZESegmentedsView()
@property (nonatomic,assign) NSInteger  selectIndex;
@end


@implementation ZESegmentedsView

- (instancetype)initWithFrame:(CGRect)frame segmentedCount:(NSInteger)segmentedCount segmentedTitles:(NSArray *)titleArr selectIndex:(NSInteger)index
{
    self.selectIndex = index;
    NSInteger semtViewWidth  = frame.size.width - ((NSInteger)frame.size.width%segmentedCount);
    NSInteger semtViewHeight = frame.size.height;
    
    if (self == [super initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, semtViewWidth, semtViewHeight)]) {
        
        
        NSInteger itemsWidth = semtViewWidth/segmentedCount;
        NSInteger itemsHeight = semtViewHeight;
        
        int j;
        
        for (int i = 0; i < segmentedCount; i++) {
            
            //NSLog(@"添加了%d个btn",i);
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            CGFloat x = i * itemsWidth;
            CGFloat y = 0;
            
            btn.frame = CGRectMake(x, y, itemsWidth, itemsHeight);
            if (_selectIndex == i) {
                btn.backgroundColor = [UIColor colorWithRed:36/255.0 green:127/255.0 blue:211/255.0 alpha:1.0f];
                [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            } else {
                btn.backgroundColor = [UIColor clearColor];
                [btn setTitleColor:[UIColor colorWithRed:36/255.0 green:127/255.0 blue:211/255.0 alpha:1.0f] forState:UIControlStateNormal];
            }
            
            btn.tag = 1000 + i;
            btn.layer.masksToBounds = YES;
            
            [btn setTitle:titleArr[i] forState:UIControlStateNormal];
            
            [btn.titleLabel setFont:[UIFont systemFontOfSize:15]];
            
            [self addSubview:btn];
            j = i;
            if (i < segmentedCount - 1) {
                UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake( x+ itemsWidth, y, 1, itemsHeight)];
                lineView.backgroundColor = [UIColor colorWithRed:36/255.0 green:127/255.0 blue:211/255.0 alpha:1.0f];
                [self addSubview:lineView];
                
            }
            [btn addTarget:self action:@selector(clickItem:) forControlEvents:UIControlEventTouchUpInside];
            
            
            
        }
        
        
    }
    
    self.layer.borderColor = [UIColor colorWithRed:36/255.0 green:127/255.0 blue:211/255.0 alpha:1.0f].CGColor;
    self.layer.borderWidth = 1.0f;
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;
    
    
    
    return self;

}

- (instancetype)initWithFrame:(CGRect)frame
               segmentedCount:(NSInteger)segmentedCount
              segmentedTitles:(NSArray *)titleArr {
    return [self initWithFrame:frame segmentedCount:segmentedCount segmentedTitles:titleArr selectIndex:0];
}


#pragma mark - 按钮点击事件


- (void)clickItem:(UIButton *)btn {

    //NSLog(@"点击了btn");
    NSInteger currentSelectIndex = btn.tag - 1000;
    if (currentSelectIndex == self.selectIndex) {
        return;
    }
    
    UIButton *lastBtn = (UIButton *)[self viewWithTag:self.selectIndex + 1000];
    lastBtn.backgroundColor = [UIColor clearColor];
    [lastBtn setTitleColor:[UIColor colorWithRed:36/255.0 green:127/255.0 blue:211/255.0 alpha:1.0f] forState:UIControlStateNormal];
    btn.selected = !btn.selected;
    self.selectIndex = currentSelectIndex;
    btn.backgroundColor = [UIColor colorWithRed:36/255.0 green:127/255.0 blue:211/255.0 alpha:1.0f];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    
    if (_delegate && [_delegate respondsToSelector:@selector(selectedZESegmentedsViewItemAtIndex:zeView:)]) {
        
        [_delegate selectedZESegmentedsViewItemAtIndex:btn.tag - 1000 zeView:self];
        
    }
    


}

@end
