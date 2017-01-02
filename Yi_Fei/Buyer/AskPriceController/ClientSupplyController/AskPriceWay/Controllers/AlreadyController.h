//
//  AlreadyController.h
//  Yi_Fei
//
//  Created by yons on 16/12/13.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AlreadyControllerDelegate <NSObject>

-(void)clickView:(NSArray*)array index:(NSInteger)index;

@end



@interface AlreadyController : UIViewController

@property (nonatomic,weak)id<AlreadyControllerDelegate> delegate;

@property (nonatomic,strong)SupplyModel *model;


@end















