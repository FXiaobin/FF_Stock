//
//  AFNetWorkTool.m
//  https
//
//  Created by 王红威 on 16/12/15.
//  Copyright © 2016年 王红威. All rights reserved.
//

#import "AFNetWorkTool.h"
#import <AFNetworking.h>



@implementation AFNetWorkTool
static AFNetWorkTool *  instnce = nil;
static AFNetworkReachabilityStatus _status;
static AFNetworkReachabilityManager *_reachability;
static AFHTTPSessionManager *_manager;
+(void)initialize{
    //监控网略
    _reachability = [AFNetworkReachabilityManager sharedManager];
    _status = _reachability.networkReachabilityStatus;
    _manager = [AFHTTPSessionManager manager];
    [self Reachlity];
}
+(void)Reachlity{
[_reachability setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
    switch (status) {
            case AFNetworkReachabilityStatusNotReachable://无法连接
            _status=AFNetworkReachabilityStatusNotReachable;
            //[SVProgressHUD showInfoWithStatus:@"网略异常，请查看网略"];
            break;
            case AFNetworkReachabilityStatusReachableViaWiFi://wifi
            _status=AFNetworkReachabilityStatusReachableViaWiFi;
            break;
            case AFNetworkReachabilityStatusReachableViaWWAN://4G、3G、2G
            _status=AFNetworkReachabilityStatusReachableViaWWAN;
            break;
            case AFNetworkReachabilityStatusUnknown://位置网路
            _status=AFNetworkReachabilityStatusUnknown;
            break;
    }
}];
    [_reachability startMonitoring];
}
+(AFNetworkReachabilityStatus)getNetWorkState
{
    return _status;
}
/**
 初始化方法
 @return 唯一的实力对象
 */
+(instancetype)shareManger{
    instnce = [[self alloc] init];
    return instnce;
}
/**
 通过alloc  实力对象
 */
+(instancetype)allocWithZone:(struct _NSZone *)zone{
    if (instnce ==nil) {
        
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
        instnce = [super allocWithZone:zone];

        });
    }
    return instnce;
}
//通过copy  实力对象
-(id)copyWithZone:(NSZone *)zone{
    
    return instnce;
}

- (void)GETStock:(NSString *)URLString parameters:(NSDictionary *)parameters success:(void (^)(id responseObject))success failure:(void (^) (NSError *error))failure{
 
    [_manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    _manager.requestSerializer.timeoutInterval = 15.f;
    [_manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
 
    _manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    _manager.responseSerializer.acceptableContentTypes = [_manager.responseSerializer.acceptableContentTypes setByAddingObject:@"application/x-javascript"];
  
    [_manager GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
        NSString *obj = [[NSString alloc] initWithData:responseObject encoding:enc];
        //NSLog(@"JSON: %@", obj);
        
        NSString *info = [obj componentsSeparatedByString:@"=\""].lastObject;
        NSArray *result = [info componentsSeparatedByString:@","];
        
        success(result);
      
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

        if (error) {
            //ShowAlert(error.localizedDescription);
        }
        failure(error);
    }];
}

     

@end
