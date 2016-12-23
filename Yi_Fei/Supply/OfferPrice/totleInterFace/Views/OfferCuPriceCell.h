//
//  OfferPriceCell.h
//  Yi_Fei
//
//  Created by yons on 16/12/21.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol OfferCuPriceCellDelegate <NSObject>

-(void)clickCell:(UITableViewCell*)cell index:(NSInteger)index;

@end


@interface OfferCuPriceCell : UITableViewCell


@property (nonatomic,weak) id<OfferCuPriceCellDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;


@property (weak, nonatomic) IBOutlet UILabel *titleLabel;


@property (weak, nonatomic) IBOutlet UIButton *nextBtn;

@property (weak, nonatomic) IBOutlet UIButton *oneBtn;



@property (weak, nonatomic) IBOutlet UIView *lineView;




@end





