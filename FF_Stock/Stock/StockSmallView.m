//
//  StockSmallView.m
//  PHFinancial
//
//  Created by fanxiaobin on 2017/11/24.
//  Copyright © 2017年 wanghongwei. All rights reserved.
//

#import "StockSmallView.h"
#import "Define.h"
#import <Masonry.h>

@implementation StockSmallView

- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"上证指数";
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont boldSystemFontOfSize:kSCALE(40)];
    }
    return _titleLabel;
}

- (UILabel *)pointLabel{
    if (_pointLabel == nil) {
        _pointLabel = [[UILabel alloc] init];
        _pointLabel.text = @"0.00";
        _pointLabel.textColor = [UIColor colorWithRed:74/255.0 green:169/255.0 blue:3/255.0 alpha:1];
        _pointLabel.textAlignment = NSTextAlignmentCenter;
        _pointLabel.font = [UIFont boldSystemFontOfSize:kSCALE(52)];
    }
    return _pointLabel;
}

- (UILabel *)priceLabel{
    if (_priceLabel == nil) {
        _priceLabel = [[UILabel alloc] init];
        _priceLabel.text = @"+0.00";
        _priceLabel.textColor = [UIColor colorWithRed:74/255.0 green:169/255.0 blue:3/255.0 alpha:1];
        _priceLabel.textAlignment = NSTextAlignmentRight;
        _priceLabel.font = [UIFont systemFontOfSize:kSCALE(36)];
    }
    return _priceLabel;
}


- (UILabel *)rateLabel{
    if (_rateLabel == nil) {
        _rateLabel = [[UILabel alloc] init];
        _rateLabel.text = @"+0.00%";
        _rateLabel.textColor = [UIColor colorWithRed:74/255.0 green:169/255.0 blue:3/255.0 alpha:1];
        _rateLabel.textAlignment = NSTextAlignmentLeft;
        _rateLabel.font = [UIFont systemFontOfSize:kSCALE(36)];
    }
    return _rateLabel;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        
        [self addSubview:self.titleLabel];
        [self addSubview:self.pointLabel];
        [self addSubview:self.priceLabel];
        [self addSubview:self.rateLabel];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left);
            make.right.equalTo(self.mas_right);
            make.top.equalTo(self.mas_top).offset(kSCALE(50));
        }];
        
        [self.pointLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left);
            make.right.equalTo(self.mas_right);
            make.top.equalTo(self.titleLabel.mas_bottom).offset(kSCALE(13));
        }];
        
        [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            make.right.equalTo(self.mas_centerX).offset(kSCALE(-10));
            make.top.equalTo(self.pointLabel.mas_bottom).offset(kSCALE(10));
        }];

        [self.rateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_centerX).offset(kSCALE(10));
            make.right.equalTo(self.mas_right);
            make.centerY.equalTo(self.priceLabel);
        }];
        
    }
    return self;
}

@end
