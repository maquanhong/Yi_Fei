//
//  BuyerTableViewCell.m
//  YiFei
//
//  Created by yangyan on 16/8/30.
//  Copyright © 2016年 yous. All rights reserved.
//

#import "BuyerTableViewCell.h"
#import "myShopView.h"

@implementation BuyerTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addView];
    }
    return self;
}

-(void)addView{
    self.imgV=[[UIImageView alloc] init];
    [self.imgV sizeToFit];
    _imgV.frame=CGRectMake(5, 10, 60, 60);
    [self.contentView addSubview:_imgV];
    
    self.nameShop=[myShopView creatLableWithBgColor:[UIColor whiteColor] borderColor:[UIColor whiteColor] borderWidth:0 titleColor:[UIColor blackColor] text:nil];
    self.nameShop.textColor=[UIColor blackColor];
    self.nameShop.frame=CGRectMake(CGRectGetMaxX(self.imgV.frame)+20, 10, 100, 30);
    [self.contentView addSubview:self.nameShop];
    
    self.priceL=[myShopView creatLableWithBgColor:[UIColor whiteColor] borderColor:[UIColor whiteColor] borderWidth:0 titleColor:[UIColor blackColor] text:@"北京市某某某科技有限公司"];
    self.priceL.font=[UIFont systemFontOfSize:14.0];
    self.priceL.frame=CGRectMake(CGRectGetMaxX(self.imgV.frame)+20, CGRectGetMaxY(self.nameShop.frame), 200, 30);
    [self.contentView addSubview:self.priceL];

    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
