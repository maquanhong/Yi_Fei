//
//  myShopTableViewCell.m
//  YiFei
//
//  Created by yangyan on 16/8/30.
//  Copyright © 2016年 yous. All rights reserved.
//

#import "ZMJMyProductionCell.h"
#import "BUYButton.h"
#import "myShopView.h"



@implementation ZMJMyProductionCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addView];
    }
    return self;
}


-(void)addView{
    
    _imgV=[[UIImageView alloc] init];
    _imgV.layer.cornerRadius = 5;
    _imgV.layer.masksToBounds = YES;
    [self.imgV sizeToFit];
    [self.contentView addSubview:_imgV];
    [_imgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self).offset(10);
        make.centerY.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(90, 90));
        
    }];
    
    _nameShop=[myShopView creatLableWithBgColor:[UIColor whiteColor] borderColor:[UIColor whiteColor] borderWidth:0 titleColor:[UIColor blackColor] text:nil];
     _nameShop.font=[UIFont systemFontOfSize:20.0];
    [self.contentView addSubview:_nameShop];
    [_nameShop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_imgV.mas_right).offset(10);
        make.top.mas_equalTo(_imgV.mas_top);
        make.trailing.mas_equalTo(self).offset(-10);
        make.height.mas_equalTo(20);
    }];
    
    UILabel *priceL=[[UILabel alloc] init];
    [priceL sizeToFit];
    priceL=[myShopView creatLableWithBgColor:[UIColor whiteColor] borderColor:[UIColor whiteColor] borderWidth:0 titleColor:[UIColor blackColor] text:@"价格"];
    priceL.font=[UIFont systemFontOfSize:14.0];
    [self.contentView addSubview:priceL];
    [priceL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(_nameShop);
        make.top.mas_equalTo(_nameShop.mas_bottom).offset(10);
        make.size.mas_equalTo(CGSizeMake(30, 20));
    }];
    
    self.priceL=[myShopView creatLableWithBgColor:[UIColor whiteColor] borderColor:[UIColor whiteColor] borderWidth:0 titleColor:[UIColor orangeColor] text:nil];
    [self.priceL sizeToFit];
    _priceL.textColor = [UIColor orangeColor];
    self.priceL.font=[UIFont systemFontOfSize:14.0];
    [self.contentView addSubview:self.priceL];
    [_priceL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(priceL.mas_right).offset(10);
        make.centerY.mas_equalTo(priceL.mas_centerY);
        make.trailing.mas_equalTo(self).offset(-10);
        make.height.mas_equalTo(20);
    }];
    
        NSArray *array=@[@"编辑",@"详情"];
        for (int i=0; i<2; i++) {
            
            UIButton *button=[BUYButton creatBtnWithBgColor:[UIColor whiteColor] borderColor:[UIColor lightGrayColor] borderWidth:1.0 titleColor:[UIColor lightGrayColor] text:array[i]];
            button.titleLabel.font=[UIFont systemFontOfSize:14.0];
            button.tag=10000+i;
  [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            if (i == 0) {
    button.frame=CGRectMake(110, 70, 60, 25);
            }else{
    button.frame=CGRectMake(180, 70, 60, 25);
            }
    [self.contentView addSubview:button];
    }
    
    UIView *backView = [[UIView alloc] init];
    backView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.mas_bottom);
        make.leading.mas_equalTo(self);
        make.trailing.mas_equalTo(self);
        make.height.mas_equalTo(1);
    }];
}



//重写set方法
-(void)setShopObject:(shopData *)shopObject{
    //对应赋值
    _nameShop.text=shopObject.shopName;
    _priceL.text=shopObject.shopPrice;
    _imgV.image=[UIImage imageNamed:shopObject.shopPicture];
    _shopObject=shopObject;
}


-(void)buttonClick:(UIButton *)sender{
    
    switch (sender.tag) {
        case 10000:
        {
    ZMJEditViewController  *editVC = [[ZMJEditViewController alloc] init];
        if ([self.delegate respondsToSelector:@selector(clickLabelView:index:)]) {
            [self.delegate clickLabelView:editVC index:self];
        }
  }
            break;
        case 10001:
        {
    ZMJGoodsDetailController *detailVC = [[ZMJGoodsDetailController alloc] init];
        if ([self.delegate respondsToSelector:@selector(clickView:index:)]) {
            [self.delegate clickView:detailVC index:self];
         }
    }
        break;
        default:
            break;
    }
}















@end

















