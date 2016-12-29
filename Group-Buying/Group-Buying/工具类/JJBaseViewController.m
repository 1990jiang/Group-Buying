//
//  JJBaseViewController.m
//  Group-Buying
//
//  Created by 蒋俊 on 16/12/29.
//  Copyright © 2016年 蒋俊. All rights reserved.
//

#import "JJBaseViewController.h"
#import "JJHttpTool.h"
#import <SVProgressHUD.h>

@interface JJBaseViewController ()

@end

/*
 为什么要写这样一个基类:
 
 1.在每一个控制器中，每做一次网络请求，貌似我们都会去弄一个模拟网络加载的，这样是相当麻烦的
 
 */

@implementation JJBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    
}

#pragma mark -- 实现网络请求方法
//写get请求的方法
- (void)getData:(NSString *)url param:(NSDictionary *)param success:(requestSuccessBlock)requestSuccess error:(requestErrorBlock)requestError{
    
    //网络加载模拟
    [SVProgressHUD show];
    
    [JJHttpTool getData:url param:param success:^(id responseObject) {
      
        [SVProgressHUD dismiss];
        //调用block
        if (requestSuccess) {
            requestSuccess(responseObject);
        }

        
        
    } error:^(NSError *error) {
        [SVProgressHUD dismiss];
        //调用block
        if (requestError) {
            requestError(error);
        }

        
        
    }];
    
    
}

//POST请求
- (void)postData:(NSString *)url param:(NSDictionary *)param success:(requestSuccessBlock)requestSuccess error:(requestErrorBlock)requestError{
    
    [JJHttpTool postData:url param:param success:^(id responseObject){
        
        //调用block
        if (requestSuccess) {
            requestSuccess(responseObject);
        }
        

        
    } error:^(NSError *error) {
        //调用block
        if (requestError) {
            requestError(error);
        }
        

    }];
    
    
    
    
}





@end
