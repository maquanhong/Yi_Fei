//
//  SelectTableViewCell.h
//  SSPopup
//
//  Created by yons on 16/11/28.
//  Copyright © 2016年 Karthick Baskar. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SelectTableViewCellDelegate <NSObject>

-(void)clickExcelBtn:(NSInteger)number;

-(void)clickPDFBtn:(NSInteger)number;

@end


@interface SelectTableViewCell : UITableViewCell


@property (nonatomic,weak) id<SelectTableViewCellDelegate>  delegate;





@end








