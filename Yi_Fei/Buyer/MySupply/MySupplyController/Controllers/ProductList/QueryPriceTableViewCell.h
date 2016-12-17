//
//  QueryPriceTableViewCell.h
//  Yi_Fei
//
//  Created by yons on 16/12/17.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import <UIKit/UIKit.h>

@class  QueryPriceTableViewCell;
@protocol QueryPriceTableViewCellDelegate<NSObject>
@optional

- (void)queryPrice:(QueryPriceTableViewCell *)index;

- (void)imageQueryPrice:(QueryPriceTableViewCell *)index;

@end


@interface QueryPriceTableViewCell : UITableViewCell

@property (nonatomic, weak) id<QueryPriceTableViewCellDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIImageView *iconImage;


@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *priceLabel;


@end
