//
//  JJAuthCodeController.m
//  Group-Buying
//
//  Created by 蒋俊 on 16/12/27.
//  Copyright © 2016年 蒋俊. All rights reserved.
//

#import "JJAuthCodeController.h"
#import "JJAuthCodeView.h" //验证码界面自定义View


@interface JJAuthCodeController ()

@property (strong, nonatomic)   JJAuthCodeView *nextLandingView;              /** 下一步view */

@end

@implementation JJAuthCodeController

- (void)viewDidLoad {
    [super viewDidLoad];
  self.title = @"验证码";
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





@end
