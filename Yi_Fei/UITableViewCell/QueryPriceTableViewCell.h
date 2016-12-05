//
//  QueryPriceTableViewCell.h
//  Yi_Fei
//
//  Created by maquanhong on 2016/12/4.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import <UIKit/UIKit.h>
@class  QueryPriceTableViewCell;
@protocol QueryPriceTableViewCellDelegate<NSObject>
@optional
- (void)queryPrice:(QueryPriceTableViewCell *)cell;
- (void)imageQueryPrice:(QueryPriceTableViewCell *)cell;
@end


@interface QueryPriceTableViewCell : UITableViewCell
@property (nonatomic, weak) id<QueryPriceTableViewCellDelegate> delegate;
@property (nonatomic, strong, readonly) UIButton *selectBtn;
@property (nonatomic, strong, readonly) UIImageView *productImageView;
@property (nonatomic, strong, readonly) UILabel *nameLabel;
@property (nonatomic, strong, readonly) UILabel *pricelabel;
@property (nonatomic, strong, readonly) UIButton *queryBtn;
@property (nonatomic, strong, readonly) UIButton *imageQueryBtn;
@end
