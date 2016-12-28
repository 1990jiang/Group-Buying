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
    
    [self requestCodeNumber];
}

#pragma mark -- 初始化
- (JJAuthCodeView *)nextLandingView
{
    if (!_nextLandingView){
        _nextLandingView = [[JJAuthCodeView alloc]init];
        //给其属性赋值
        _nextLandingView.phoneNumString = self.userMessageDic[@"userName"];
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

//验证码网络请求
//只要能够进入验证码界面，就说明用户是输入了一个11位的手机号，至于这个手机号正不正确就交由后台服务器去判断了
-(void)requestCodeNumber{
    
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




@end
