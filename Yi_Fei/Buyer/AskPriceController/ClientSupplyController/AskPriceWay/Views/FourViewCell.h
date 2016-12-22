//
//  FourViewCell.h
//  Yi_Fei
//
//  Created by yons on 16/12/16.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FourViewCellDelegate <NSObject>

-(void)clickView;

@end


@interface FourViewCell : UITableViewCell

@property (nonatomic,weak) id<FourViewCellDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIButton *setBtn;

@property (weak, nonatomic) IBOutlet UIImageView *imageOne;

@property (weak, nonatomic) IBOutlet UIImageView *imageTwo;

@property (weak, nonatomic) IBOutlet UIImageView *imageThree;


@property (weak, nonatomic) IBOutlet UIImageView *imageFour;

@property (weak, nonatomic) IBOutlet UIView *lineView;




@end
