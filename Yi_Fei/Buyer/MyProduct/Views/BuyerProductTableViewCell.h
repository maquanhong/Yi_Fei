//
//  BuyerProductTableViewCell.h
//  Yi_Fei
//
//  Created by yons on 16/11/24.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BuyerEditProductController.h"
#import "BuyerDetailViewController.h"

@protocol ZMJMyProductionCellDelegate <NSObject>


//第二张表
-(void)clickView:(BuyerEditProductController*)View num:(UITableViewCell*)num;

-(void)clickView:(BuyerDetailViewController*)View row:(UITableViewCell*)row;


@end


@interface BuyerProductTableViewCell : UITableViewCell

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






















