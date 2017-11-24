//
//  AFNetWorkTool.h
//  https
//
//  Created by 王红威 on 16/12/15.
//  Copyright © 2016年 王红威. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface AFNetWorkTool : NSObject

/**
  快速创建单例
 */
+(instancetype)shareManger;


- (void)GETStock:(NSString *)URLString parameters:(NSDictionary *)parameters success:(void (^)(id responseObject))success failure:(void (^) (NSError *error))failure;


@end
