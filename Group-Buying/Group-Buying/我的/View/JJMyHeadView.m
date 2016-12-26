//
//  JJMyHeadView.m
//  Group-Buying
//
//  Created by 蒋俊 on 16/12/25.
//  Copyright © 2016年 蒋俊. All rights reserved.
//

#import "JJMyHeadView.h"

@interface JJMyHeadView ()

/**loginBackImage*/
@property (nonatomic , strong) UIImageView *loginBackImage;
/**loginBtn*/
@property (nonatomic , strong) UIButton *loginBtn;
/**registerBtn*/
@property (nonatomic , strong) UIButton *registerBtn;


@end


@implementation JJMyHeadView


//重写初始化方法
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.loginBackImage];
        [self addSubview:self.loginBtn];
        [self addSubview:self.registerBtn];
        
    }
    
    return self;
    
}

#pragma mark -- 初始化子控件
//头部视图背景图片
-(UIImageView *)loginBackImage
{
    if (!_loginBackImage){
        _loginBackImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"我的背景"]];
        
    }
    return _loginBackImage;
}
//登录按钮
-(UIButton *)loginBtn
{
    if (!_loginBtn){
        _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
        [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
       
        _loginBtn.titleLabel.font = [UIFont systemFontOfSize:18.0f];
        
    }
    return _loginBtn;
}
//注册按钮
-(UIButton *)registerBtn
{
    if (!_registerBtn){
        _registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_registerBtn setTitle:@"注册" forState:UIControlStateNormal];
        [_registerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
         [_registerBtn addTarget:self action:@selector(pushToRegisterController) forControlEvents:UIControlEventTouchUpInside];
        _registerBtn.titleLabel.font = [UIFont systemFontOfSize:18.0f];
        
    }
    return _registerBtn;
}

#pragma mark -- 子控件布局 还是放在layoutSubViews中
-(void)layoutSubviews{
    [super layoutSubviews];
    __weak typeof(self) weakSelf = self;
    
    //backImage
    [_loginBackImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(weakSelf);
    }];
    //loginBtn
    [_loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        //让按钮的X轴中心与父视图相等且向左偏移50
        make.centerX.equalTo(weakSelf.mas_centerX).offset(-50);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(60, 30));
    }];
    //registerBtn
    [_registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.mas_centerX).offset(50);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(60, 30));
    }];
}
#pragma mark -- 监听方法
//注册按钮的点击事件
-(void)pushToRegisterController{
    
   //2.调用block
    if (_registerBlock) {
        _registerBlock();
    }
    
    
}

@end
