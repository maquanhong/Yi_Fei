//
//  IconTitleTableViewCell.h
//  YiFei
//
//  Created by maquanhong on 10/23/16.
//  Copyright © 2016 yous. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SendDataViewCellDelegate <NSObject>

-(void)clickBloothBtn:(NSInteger)number;

-(void)clickEmailBtn:(NSInteger)number;

@end

@interface SendDataViewCell : UITableViewCell

@property (nonatomic,weak) id<SendDataViewCellDelegate>  delegate;


@end
