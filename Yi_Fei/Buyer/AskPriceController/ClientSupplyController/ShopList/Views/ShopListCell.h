//
//  ShopListCell.h
//  Yi_Fei
//
//  Created by yons on 16/12/13.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BuyerEditProductController.h"
#import "ShopListDetailController.h"

@protocol ShopListCellDelegate <NSObject>

//第一张表
-(void)clickLabelView:(BuyerEditProductController*)controller index:(UITableViewCell*)index;

-(void)clickView:(ShopListDetailController*)controller index:(UITableViewCell*)index;

@end



@interface ShopListCell : UITableViewCell

@property(nonatomic,weak)id<ShopListCellDelegate> delegate;

//声明数据模型
@property(nonatomic,strong)shopData *shopObject;

//商品图片
@property(nonatomic,strong)UIImageView *imgV;
//商品名称
@property(nonatomic,strong)UILabel *nameShop;
//价格
@property(nonatomic,strong)UILabel *priceL;

@property(nonatomic,strong)UIButton *selectBtn;

@end












