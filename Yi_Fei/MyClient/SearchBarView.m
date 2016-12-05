//
//  SearchBarView.m
//  Yi_Fei
//
//  Created by maquanhong on 2016/12/3.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "SearchBarView.h"
#import "PureLayout.h"

@interface SearchBarView()
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UIButton  *searchBtn;
@end

@implementation SearchBarView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _searchBar = [[UISearchBar alloc] initForAutoLayout];
        [self addSubview:self.searchBar];
        _searchBtn = [[UIButton alloc] initForAutoLayout];
        [_searchBtn addTarget:self action:@selector(search) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.searchBtn];
        [self addViewConstraints];
    }
    return self;
}

- (void)addViewConstraints {
    [self.searchBtn autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [self.searchBtn autoSetDimension:ALDimensionHeight toSize:30];
    [self.searchBtn autoSetDimension:ALDimensionWidth toSize:50];
    [self.searchBtn autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:5];
    [self.searchBar autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [self.searchBar autoPinEdge:ALEdgeTrailing toEdge:ALEdgeLeading ofView:self.searchBtn withOffset:3];
    [self.searchBar autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:3];
    [self.searchBar autoSetDimension:ALDimensionHeight toSize:30];
}

- (void)search {
    if (self.deleate && [self.deleate respondsToSelector:@selector(searchProduct:barView:)]) {
        [self.deleate searchProduct:self.searchBar.text barView:self];
    }
}

@end
