//
//  BuyerAskCell.h
//  Yi_Fei
//
//  Created by yons on 16/12/21.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "OfferPriceModel.h"

@protocol BuyerAskCellDelegate <NSObject>

-(void)clickcell:(UITableViewCell*)cell num:(NSInteger)num;

@end

@interface BuyerAskCell : UITableViewCell

//@property (nonatomic,strong) OfferPriceModel *model;

@property (nonatomic,weak) id<BuyerAskCellDelegate> delegate;

@property(nonatomic,strong)UIButton *selectBtn;

@property (nonatomic,strong) UIImageView *iconImageView;

@property (nonatomic,strong) UILabel *titleLabel;

@property (nonatomic,strong) UILabel *price;


@end
































