//
//  JJAuthCodeController.m
//  Group-Buying
//
//  Created by 蒋俊 on 16/12/27.
//  Copyright © 2016年 蒋俊. All rights reserved.
//

#import "JJAuthCodeController.h"
#import "JJAuthCodeView.h" //验证码界面自定义View
#import <AFNetworking.h>
#import "JJHttpTool.h"  //封装的网络请求的工具类

@interface JJAuthCodeController ()

@property (strong, nonatomic)   JJAuthCodeView *nextLandingView;              /** 下一步view */

@end

@implementation JJAuthCodeController

- (void)viewDidLoad {
    [super viewDidLoad];
  self.title = @"验证手机号";
    self.view.backgroundColor = MainColor;
    self.edgesForExtendedLayout = 0;

    //添加控件
    [self.view addSubview:self.nextLandingView];
    //调用方法
    [self setUpMasonry];
    
   
}

#pragma mark -- 初始化
- (JJAuthCodeView *)nextLandingView
{
    if (!_nextLandingView){
        _nextLandingView = [[JJAuthCodeView alloc]init];
        //给其属性赋值
        _nextLandingView.phoneNumString = self.userMessageDic[@"userName"];
        //实现注册按钮block
        __weak typeof(self) weakSelf = self;
        _nextLandingView.landingblock = ^(NSString *code){
          //注册请求的方法是在这个注册按钮的block中调用的
          
            [weakSelf landingMethod:code];
            
            
        };
    }
    return _nextLandingView;
}

#pragma mark -- 辅助方法
-(void)setUpMasonry{
    __weak typeof (self) weakSelf = self;
    [_nextLandingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(weakSelf.view);
        make.height.equalTo(@140);
    }];
}

//验证码网络请求:这个请求是结合手机号向服务器请求一个验证码下来的，所以这个方法可以由验证码按钮点击时调用，也可以进去验证码界面就调用
//只要能够进入验证码界面，就说明用户是输入了一个11位的手机号，至于这个手机号正不正确就交由后台服务器去判断了
-(void)requestCodeNumber{
    
   [ JJHttpTool getData:@"appMember/createCode.do" param:@{@"MemberId":_userMessageDic[@"userName"]} success:^(id responseObject) {
       
        
        NSLog(@"成功了");
        
    } error:^(NSError *error) {
        NSLog(@"失败了");
    }];
    
    
    
   }

//注册网络请求
-(void)landingMethod:(NSString *)code{
   
    [JJHttpTool postData:@"appMember/createCode.do" param:@{@"LoginName":_userMessageDic[@"userName"],
                @"Lpassword":_userMessageDic[@"password"],
                @"Code":code,
                @"Telephone":_userMessageDic[@"userName"]} success:^(id responseObject) {
                  
                    if ([responseObject[@"result"] isEqualToString:@"success"]) {
                        NSLog(@"注册成功");
                        
                    }else if ([responseObject[@"result"] isEqualToString:@"codeError"] ){
                        
                        NSLog(@"验证码错误");
                        
                    }else{
                        NSLog(@"注册失败");
                    }

            } error:^(NSError *error) {
                    
                   NSLog(@"失败是---%@",error);
        }];
}

#pragma mark -- 网络请求未封装的代码
//获取验证码
-(void)getData{
    
 
     AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
     //设置请求的编码格式
     manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
     [manager POST:@"http://123.57.141.249:8080/beautalk/appMember/createCode.do" parameters:@{@"MemberId":_userMessageDic[@"userName"]} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
     if ([responseObject[@"result"] isEqualToString:@"success"]) {
     //现在的思路是我们先进入界面就让其请求，请求成功了，我们就让验证码按钮开始倒计时
     [self.nextLandingView countDownMethod];
     }else if ([responseObject[@"result"] isEqualToString:@"TelephoneExistError"]){
     
     NSLog(@"该手机号已经被注册了");
     }else{
     NSLog(@"验证码请求失败");
     }
     
     
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
     NSLog(@"失败是---%@",error);
     }];
    

    
    
}
//注册
-(void)landingRequest:(NSString *)code{
    
  
     AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
     //设置请求的编码格式
     manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
     
     /*
     将注册需要传入的参数拼接为一个字典
     手机号:LoginName
     密码:Lpassword
     验证码:Code
     手机号:Telephone
     */
    
   
     [manager GET:@"http://" parameters:@{@"LoginName":_userMessageDic[@"userName"],
     @"Lpassword":_userMessageDic[@"password"],
     @"Code":code,
     @"Telephone":_userMessageDic[@"userName"]}
     progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
     if ([responseObject[@"result"] isEqualToString:@"success"]) {
     NSLog(@"注册成功");
     
     }else if ([responseObject[@"result"] isEqualToString:@"codeError"] ){
     
     NSLog(@"验证码错误");
     
     }else{
     NSLog(@"注册失败");
     }
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
     
     }];
     
    

    
}





@end
