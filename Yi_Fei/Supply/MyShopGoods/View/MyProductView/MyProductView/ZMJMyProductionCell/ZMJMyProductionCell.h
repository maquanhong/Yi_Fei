//
//  myShopTableViewCell.h
//  YiFei
//
//  Created by yangyan on 16/8/30.
//  Copyright © 2016年 yous. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZMJGoodsDetailController.h"
#import "ZMJEditViewController.h"


@protocol ZMJMyProductionCellDelegate <NSObject>

//第一张表
-(void)clickLabelView:(ZMJEditViewController*)controller index:(UITableViewCell*)index;

-(void)clickView:(ZMJGoodsDetailController*)controller index:(UITableViewCell*)index;


@end


@interface ZMJMyProductionCell : UITableViewCell

@property(nonatomic,weak)id<ZMJMyProductionCellDelegate> delegate;

//声明数据模型
@property(nonatomic,strong)shopData *shopObject;

//商品图片
@property(nonatomic,strong)UIImageView *imgV;
//商品名称
@property(nonatomic,strong)UILabel *nameShop;
//价格
@property(nonatomic,strong)UILabel *priceL;




@end






















