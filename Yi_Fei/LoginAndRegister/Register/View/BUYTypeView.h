//
//  BUYTypeView.h
//  YiFei
//
//  Created by yons on 16/8/26.
//  Copyright © 2016年 yous. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TypeView.h"

@protocol BUYTypeViewDelegate <NSObject>

-(void)clickViewTag:(NSInteger)tag;

@end




@interface BUYTypeView : UIView

@property(nonatomic,weak)id<BUYTypeViewDelegate> delegate;

@property (nonatomic,strong) TypeView *typeOne;

@property (nonatomic,strong) TypeView *typeTwo;

@property (nonatomic,strong) TypeView *typeThree;

@property (nonatomic,strong) TypeView *typeFour;



@end
