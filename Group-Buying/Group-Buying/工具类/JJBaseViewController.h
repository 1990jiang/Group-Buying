//
//  JJBaseViewController.h
//  Group-Buying
//
//  Created by 蒋俊 on 16/12/29.
//  Copyright © 2016年 蒋俊. All rights reserved.
//

#import <UIKit/UIKit.h>

//以block作为参数
typedef void(^requestSuccessBlock)(id responseObject);
typedef void(^requestErrorBlock)(NSError *error);



@interface JJBaseViewController : UIViewController

//写get请求的方法
- (void)getData:(NSString *)url param:(NSDictionary *)param success:(requestSuccessBlock)requestSuccess error:(requestErrorBlock)requestError;

//POST请求
- (void)postData:(NSString *)url param:(NSDictionary *)param success:(requestSuccessBlock)requestSuccess error:(requestErrorBlock)requestError;

@end
