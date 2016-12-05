//
//  addShopTableViewCell.h
//  YiFei
//
//  Created by yangyan on 16/8/29.
//  Copyright © 2016年 yous. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "shopData.h"

@interface ZMJAddGoodsOneCell : UITableViewCell<UITextFieldDelegate,UITextViewDelegate>

@property(nonatomic,strong)UITextField *textF;

@property(nonatomic,strong)UILabel *label;

@end
