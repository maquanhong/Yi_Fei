//
//  AskPriceCell.h
//  Yi_Fei
//
//  Created by yons on 16/12/13.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AskPriceCellDelegate <NSObject>

-(void)clickcell:(UITableViewCell*)cell num:(NSInteger)num;

@end



@interface AskPriceCell : UITableViewCell

@property (nonatomic,weak) id<AskPriceCellDelegate> delegate;

@property (nonatomic,strong) UIImageView *iconImageView;

@property (nonatomic,strong) UILabel *titleLabel;

@property (nonatomic,strong) UILabel *price;

@property(nonatomic,strong)UIButton *selectBtn;

@end









