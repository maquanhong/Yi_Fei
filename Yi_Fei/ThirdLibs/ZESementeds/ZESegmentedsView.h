//
//  ZESegmentedsView.h
//  
//
//  Created by wzm on 16/4/8.
//  Copyright © 2016年 wzm. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZESegmentedsView;
@protocol ZESegmentedsViewDelegate <NSObject>

@required

- (void)selectedZESegmentedsViewItemAtIndex:(NSInteger )selectedItemIndex zeView:(ZESegmentedsView *)zeView;

@end


@interface ZESegmentedsView : UIView

//代理对象
@property (nonatomic,weak)id<ZESegmentedsViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame
               segmentedCount:(NSInteger)segmentedCount
              segmentedTitles:(NSArray *)titleArr;

- (instancetype)initWithFrame:(CGRect)frame
               segmentedCount:(NSInteger)segmentedCount
              segmentedTitles:(NSArray *)titleArr
                  selectIndex:(NSInteger)index;


@end
