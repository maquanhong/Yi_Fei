//
//  DownListButton.m
//  YiFei
//
//  Created by maquanhong on 10/16/16.
//  Copyright © 2016 yous. All rights reserved.
//

#import "DownListButton.h"
#import "PureLayout.h"
@interface DownListButton ()
@property (nonatomic, strong) UIImageView  *downImageView;
@property (nonatomic, strong) UIImageView  *lineImageView;
@end

@implementation DownListButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initForAutoLayout {
    self = [super initForAutoLayout];
    if (self) {
        self.layer.borderColor = NAVCOLOR.CGColor;
        self.layer.borderWidth = 1.0;
        self.layer.cornerRadius = 7.0;
        [self addSubview:self.btnTitleLabel];
        [self addSubview:self.lineImageView];
        [self addSubview:self.downImageView];
        [self addViewConstraints];
    }
    return self;
}

- (void)addViewConstraints {
    UIImage *image = [UIImage imageNamed:@"down.jpg"];
    [self.btnTitleLabel autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [self.btnTitleLabel autoPinEdgeToSuperviewEdge:ALEdgeLeading];
    [self.btnTitleLabel autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    [self.btnTitleLabel autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:image.size.width];
    
    [self.lineImageView autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [self.lineImageView autoSetDimension:ALDimensionWidth toSize:1];
    [self.lineImageView autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    [self.lineImageView autoPinEdge:ALEdgeLeading toEdge:ALEdgeTrailing ofView:self.btnTitleLabel];
    
    [self.downImageView autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [self.downImageView autoPinEdgeToSuperviewEdge:ALEdgeTrailing];
    [self.downImageView autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    [self.downImageView autoPinEdge:ALEdgeLeading toEdge:ALEdgeTrailing ofView:self.lineImageView withOffset:1];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    if (self.delegate && [self.delegate respondsToSelector:@selector(showList:)]) {
        [self.delegate showList:self];
    }
}

- (UILabel *)btnTitleLabel {
    if (!_btnTitleLabel) {
        _btnTitleLabel = [[UILabel alloc] initForAutoLayout];
        _btnTitleLabel.backgroundColor = [UIColor clearColor];
        _btnTitleLabel.textAlignment = NSTextAlignmentCenter;
        _btnTitleLabel.textColor = NAVCOLOR;
        _btnTitleLabel.font = [UIFont systemFontOfSize:14];
    }
    return _btnTitleLabel;
}

- (UIImageView *)downImageView {
    if (!_downImageView) {
        _downImageView = [[UIImageView alloc] initForAutoLayout];
        _downImageView.image = [UIImage imageNamed:@"down.jpg"];
        _downImageView.contentMode = UIViewContentModeCenter;
    }
    return _downImageView;
}

- (UIImageView *)lineImageView {
    if (!_lineImageView) {
        _lineImageView = [[UIImageView alloc] initForAutoLayout];
        _lineImageView.backgroundColor = NAVCOLOR;
        _lineImageView.contentMode = UIViewContentModeCenter;
    }
    return _lineImageView;
}

@end
