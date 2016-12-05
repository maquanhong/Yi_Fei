//
//  SearchBarView.h
//  Yi_Fei
//
//  Created by maquanhong on 2016/12/3.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SearchBarView;
@protocol SearchBarViewDelegate<NSObject>
@optional
- (void)searchProduct:(NSString *)key barView:(SearchBarView *)barView;
@end

@interface SearchBarView : UIView
@property (nonatomic, strong, readonly) UISearchBar *searchBar;
@property (nonatomic, strong, readonly) UIButton  *searchBtn;
@property (nonatomic, weak) id<SearchBarViewDelegate> deleate;
@end
