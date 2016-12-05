//
//  SendDataTwoViewCell.h
//  Yi_Fei
//
//  Created by yons on 16/11/26.
//  Copyright © 2016年 Practice. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol SendDataTwoViewCellDelegate <NSObject>

-(void)clickOneBtn:(NSInteger)num;

-(void)clickTwoBtn:(NSInteger)num;

@end

@interface SendDataTwoViewCell : UITableViewCell

@property (nonatomic,weak) id<SendDataTwoViewCellDelegate>  delegate;



@end
