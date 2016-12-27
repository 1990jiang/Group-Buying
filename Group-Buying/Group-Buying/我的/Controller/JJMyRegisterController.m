//
//  JJMyRegisterController.m
//  Group-Buying
//
//  Created by 蒋俊 on 16/12/25.
//  Copyright © 2016年 蒋俊. All rights reserved.
//

#import "JJMyRegisterController.h"
#import "JJLandingPutView.h" //注册界面输入View
#import "JJThirdLoginView.h" //第三方登录View
#import "JJAuthCodeController.h" //验证码控制器

@interface JJMyRegisterController ()

/**注册界面View*/
@property (nonatomic , strong) JJLandingPutView *landingPutView;

/**第三方登录View*/
@property (nonatomic , strong) JJThirdLoginView *thirdLoginView;



@end

@implementation JJMyRegisterController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"注册";
    self.view.backgroundColor = MainColor;
    self.edgesForExtendedLayout = 0;
    //添加子控件
    [self.view addSubview:self.landingPutView];
    [self.view addSubview:self.thirdLoginView];
    
    
    //调用方法
    [self setUpMasonry];

    
}

#pragma mark -- 初始化子控件
- (JJLandingPutView *)landingPutView
{
    if (!_landingPutView){
        _landingPutView = [[JJLandingPutView alloc]init];
        
        __weak typeof(self) weakSelf = self;
        _landingPutView.nextBlock = ^(NSDictionary *dic){
            JJAuthCodeController *vc = [[JJAuthCodeController alloc]init];
            vc.userMessageDic = dic;
            [weakSelf.navigationController pushViewController:vc animated:YES];
            };
        
    }
    return _landingPutView;
}

- (JJThirdLoginView *)thirdLoginView
{
    if (!_thirdLoginView){
        _thirdLoginView = [[JJThirdLoginView alloc]init];
    }
    return _thirdLoginView;
}


#pragma mark -- 辅助方法
//添加约束
-(void)setUpMasonry{
    
    __weak typeof (self) weakSelf = self;
    
   [_landingPutView mas_makeConstraints:^(MASConstraintMaker *make) {
      
       make.top.equalTo(weakSelf.view);
       make.left.right.equalTo(weakSelf.view);
       make.height.mas_offset(230);
    }];
    
    [_thirdLoginView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.landingPutView.mas_bottom);
        make.left.right.equalTo(weakSelf.view);
        make.height.mas_equalTo(85);
    }];
    
}















@end
