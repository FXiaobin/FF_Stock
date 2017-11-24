//
//  ViewController.m
//  FF_Stock
//
//  Created by fanxiaobin on 2017/11/24.
//  Copyright © 2017年 fanxiaobin. All rights reserved.
//

#import "ViewController.h"
#import "StockDataView.h"
#import "Define.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    StockDataView *small = [[StockDataView alloc] initWithFrame:CGRectMake(0, 100, kScreenWidth, kSCALE(260))];
    small.backgroundColor = [UIColor yellowColor];
    
    [self.view addSubview:small];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
