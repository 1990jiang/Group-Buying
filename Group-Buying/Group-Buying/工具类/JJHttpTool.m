//
//  JJHttpTool.m
//  Group-Buying
//
//  Created by 蒋俊 on 16/12/29.
//  Copyright © 2016年 蒋俊. All rights reserved.
//

#import "JJHttpTool.h"

@implementation JJHttpTool

//写个单例方法
+ (instancetype)share{
    
    static JJHttpTool *manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        manager = [[JJHttpTool alloc]initWithBaseURL:[NSURL URLWithString:@"http://123.57.141.249:8080/beautalk/"]];
        //需要设置才设置的
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    
    });
    
    
    
    
    return manager;
}


//写get请求的方法
+ (void)getData:(NSString *)url param:(NSDictionary *)param success:(requestSuccessBlock)requestSuccess error:(requestErrorBlock)requestError{
    
    
    
    [[JJHttpTool share] GET:url parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (requestSuccess) {
            requestSuccess(responseObject);
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
     
        if (requestError) {
            requestError(error);
        }
    }];
    
}

//POST请求
+ (void)postData:(NSString *)url param:(NSDictionary *)param success:(requestSuccessBlock)requestSuccess error:(requestErrorBlock)requestError{
    
    [[JJHttpTool share] POST:url parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];

    
    
    
}

@end
