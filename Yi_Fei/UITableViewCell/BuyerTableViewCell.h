//
//  BuyerTableViewCell.h
//  YiFei
//
//  Created by yangyan on 16/8/30.
//  Copyright © 2016年 yous. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BuyerTableViewCell : UITableViewCell
//图片
@property(nonatomic,strong)UIImageView *imgV;

//商品名称
@property(nonatomic,strong)UILabel *nameShop;

//价格
@property(nonatomic,strong)UILabel *priceL;
@end
