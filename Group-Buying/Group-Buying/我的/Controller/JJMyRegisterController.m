//
//  JJMyRegisterController.m
//  Group-Buying
//
//  Created by 蒋俊 on 16/12/25.
//  Copyright © 2016年 蒋俊. All rights reserved.
//

#import "JJMyRegisterController.h"

@interface JJMyRegisterController ()<UITextFieldDelegate>

/**提示label*/
@property (nonatomic , strong) UILabel *tostLabel;

/**手机号*/
@property (nonatomic , strong) UITextField *userNameText;
/**密码*/
@property (nonatomic , strong) UITextField *passwordText;
/**下一步*/
@property (nonatomic , strong) UIButton *nextBtn;
/**去登陆*/
@property (nonatomic , strong) UIButton *goLoginBtn;
/**QQ登录*/
@property (nonatomic , strong) UIButton *qqLoginBtn;
/**微信*/
@property (nonatomic , strong) UIButton *wxLoginBtn;
/**微博*/
@property (nonatomic , strong) UIButton *sinaLoginBtn;
/**一键登录*/
@property (nonatomic , strong) UILabel *oneLogin;


@end

@implementation JJMyRegisterController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = MainColor;
    self.edgesForExtendedLayout = 0;
    //添加子控件
    [self.view addSubview:self.tostLabel];
    [self.view addSubview:self.userNameText];
    [self.view addSubview:self.passwordText];
    [self.view addSubview:self.oneLogin];
    [self.view addSubview:self.goLoginBtn];
   [self.view addSubview:self.nextBtn];
    [self.view addSubview:self.qqLoginBtn];
    [self.view addSubview:self.wxLoginBtn];
     [self.view addSubview:self.sinaLoginBtn];
  
    //调用方法
    [self setUpMasonry];

    
}

#pragma mark -- 初始化子控件
- (UILabel *)tostLabel{
    if (!_tostLabel) {
        _tostLabel = [[UILabel alloc]init];
        _tostLabel.text = @"请输入手机号码注册新用户";
        _tostLabel.font = [UIFont systemFontOfSize:14.0];
        _tostLabel.textColor = RGB(81, 81, 81);
    }
    return _tostLabel;
}
- (UITextField *)userNameText{
    if (!_userNameText) {
        _userNameText = [[UITextField alloc]init];
        _userNameText.delegate = self;
        _userNameText.placeholder = @"请输入手机号码";
        [_userNameText addTarget:self action:@selector(userNameTextChangeText:) forControlEvents:(UIControlEventEditingChanged)];
    }
    return _userNameText;
}
- (UITextField *)passwordText{
    if (!_passwordText) {
        _passwordText = [[UITextField alloc]init];
        _passwordText.delegate = self;
        _passwordText.placeholder = @"设置账号密码";
        _passwordText.secureTextEntry = YES;
        [_passwordText addTarget:self action:@selector(passwordTextChangeText:) forControlEvents:(UIControlEventEditingChanged)];
    }
    return _passwordText;
}

- (UIButton *)nextBtn{
    if (!_nextBtn) {
        _nextBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_nextBtn setTitle:@"下一步" forState:(UIControlStateNormal)];
        _nextBtn.backgroundColor = RGB(229, 229, 229);
        _nextBtn.userInteractionEnabled = NO;
        [_nextBtn setTitleColor:RGB(132, 132, 132) forState:(UIControlStateNormal)];
        [_nextBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateSelected)];
        _nextBtn.selected = NO;
        
        [_nextBtn addTarget:self action:@selector(pushNextViewController) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _nextBtn;
}

- (UIButton *)goLoginBtn{
    if (!_goLoginBtn) {
        _goLoginBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_goLoginBtn setTitle:@"去登录" forState:(UIControlStateNormal)];
        [_goLoginBtn setTitleColor:RGB(56, 145, 241) forState:(UIControlStateNormal)];
        _goLoginBtn.backgroundColor = MainColor;
    }
    return _goLoginBtn;
}

- (UILabel *)oneLogin{
    if (!_oneLogin) {
        _oneLogin = [[UILabel alloc]init];
        _oneLogin.text = @"一键登录";
        _oneLogin.textColor = RGB(190, 190, 190);
        _oneLogin.backgroundColor = MainColor;
        _oneLogin.textAlignment = NSTextAlignmentCenter;
        _oneLogin.font = [UIFont systemFontOfSize:16.0];
    }
    return _oneLogin;
}

- (UIButton *)qqLoginBtn{
    if (!_qqLoginBtn) {
        _qqLoginBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_qqLoginBtn setImage:[UIImage imageNamed:@"登录界面qq登陆"] forState:(UIControlStateNormal)];
        [_qqLoginBtn addTarget:self action:@selector(qqLandingBtnMethod) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _qqLoginBtn;
}

- (UIButton *)wxLoginBtn{
    if (!_wxLoginBtn) {
        _wxLoginBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_wxLoginBtn setImage:[UIImage imageNamed:@"登录界面微信登录"] forState:(UIControlStateNormal)];
    }
    return _wxLoginBtn;
}

- (UIButton *)sinaLoginBtn{
    if (!_sinaLoginBtn) {
        _sinaLoginBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_sinaLoginBtn setImage:[UIImage imageNamed:@"登陆界面微博登录"] forState:(UIControlStateNormal)];
    }
    return _sinaLoginBtn;
}

#pragma mark -- 辅助方法
//添加约束
-(void)setUpMasonry{
    
    __weak typeof (self) weakSelf = self;
    
    [_tostLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@35);
        make.top.right.equalTo(weakSelf.view);
        make.left.equalTo(weakSelf.view.mas_left).offset(15);
    }];
    

    
    [_userNameText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(weakSelf.view).offset(15);
        make.height.equalTo(@44);
        make.top.equalTo(weakSelf.tostLabel.mas_bottom);
    }];
    
    [_passwordText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(weakSelf.view).offset(15);
        make.height.equalTo(@44);
        make.top.equalTo(weakSelf.userNameText.mas_bottom).offset(1);
    }];
    
    
    [_nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view.mas_left).offset(16);
        make.right.equalTo(weakSelf.view.mas_right).offset(-16);
        make.height.equalTo(@35);
        make.top.equalTo(weakSelf.passwordText.mas_bottom).offset(15);
    }];
    
    [_goLoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(70, 16));
        make.right.equalTo(weakSelf.view.mas_right).offset(-15);
        make.top.equalTo(weakSelf.nextBtn.mas_bottom).offset(23);
    }];

}















@end
