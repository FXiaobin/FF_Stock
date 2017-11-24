//
//  StockDataView.m
//  PHFinancial
//
//  Created by fanxiaobin on 2017/11/24.
//  Copyright © 2017年 wanghongwei. All rights reserved.
//

#import "StockDataView.h"
#import "StockSmallView.h"
#import "Define.h"
#import "AFNetWorkTool.h"

@implementation StockDataView

- (void)queryShangHai{
    ///上海
    NSString *str = @"http://hq.sinajs.cn/list=s_sh000001";
    [[AFNetWorkTool shareManger] GETStock:str parameters:nil success:^(id responseObject) {
        
        NSArray *arr = responseObject;
        
       [self updateUIWithIndex:0 resultArr:arr];
      
    } failure:^(NSError *error) {
        
    }];
}

- (void)queryShenZhen{
    ///深圳
    NSString *str = @"http://hq.sinajs.cn/list=s_sz399001";
    [[AFNetWorkTool shareManger] GETStock:str parameters:nil success:^(id responseObject) {
        
        NSArray *arr = responseObject;
        
        [self updateUIWithIndex:1 resultArr:arr];
        
    } failure:^(NSError *error) {
        
    }];
}

- (void)queryChuangYeBan{
    ///创业板
    NSString *str = @"http://hq.sinajs.cn/list=s_sz399006";
    [[AFNetWorkTool shareManger] GETStock:str parameters:nil success:^(id responseObject) {
        
        NSArray *arr = responseObject;
        
        [self updateUIWithIndex:2 resultArr:arr];
        
    } failure:^(NSError *error) {
        
    }];
}

- (void)updateUIWithIndex:(NSInteger)tag resultArr:(NSArray *)arr{
    
    StockSmallView *smallView = (StockSmallView *)[self viewWithTag:30000 + tag];
    smallView.titleLabel.text = arr[0];
    
    CGFloat point = [arr[1] floatValue];
    CGFloat price = [arr[2] floatValue];
    CGFloat rate = [arr[3] floatValue];
    
    UIColor *defaultColor = [UIColor colorWithRed:74/255.0 green:169/255.0 blue:3/255.0 alpha:1];
    
    if (price >= 0.0) {
        smallView.priceLabel.textColor = [UIColor redColor];
    }else{
        smallView.priceLabel.textColor = defaultColor;
    }
    
    if (rate >= 0.0) {
        smallView.rateLabel.textColor = [UIColor redColor];
    }else{
        smallView.priceLabel.textColor = defaultColor;
    }
    
    if (price >= 0.0 && rate >= 0.0) {
        smallView.pointLabel.textColor = [UIColor redColor];
    }else{
        smallView.pointLabel.textColor = defaultColor;
    }
   
    smallView.pointLabel.text = [NSString stringWithFormat:@"%.2f",point];
    smallView.priceLabel.text = price >= 0.0 ? [NSString stringWithFormat:@"+%.2f",price] : [NSString stringWithFormat:@"%.2f",price];
    smallView.rateLabel.text = rate >= 0.0 ? [NSString stringWithFormat:@"+%.2f%%",rate] : [NSString stringWithFormat:@"%.2f%%",rate];
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        for (int i = 0; i < 3; i++) {
            StockSmallView *small = [[StockSmallView alloc] initWithFrame:CGRectMake(kScreenWidth / 3.0 * i, 0, kScreenWidth/3, kSCALE(260))];
            small.tag = 30000 + i;
            if (i == 0) {
                small.titleLabel.text = @"上证指数";
            }else if (i == 1) {
                small.titleLabel.text = @"深证成指";
            }else if (i == 2){
                small.titleLabel.text = @"创业板指";
            }
            [self addSubview:small];
        }
        
        ///先初始化数据
        [self updateDate:nil];
        
        ///更新数据
        NSTimer *timer = [NSTimer timerWithTimeInterval:3.0 target:self selector:@selector(updateDate:) userInfo:nil repeats:YES];
        self.timer = timer;
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
        
    }
    return self;
}

- (void)updateDate:(NSTimer *)timer{
    [self queryShangHai];
    [self queryShenZhen];
    [self queryChuangYeBan];
    
}

-(void)dealloc{
    [self.timer invalidate];
}

@end
