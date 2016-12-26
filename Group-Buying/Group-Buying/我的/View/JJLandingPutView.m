//
//  JJLandingPutView.m
//  Group-Buying
//
//  Created by 蒋俊 on 16/12/26.
//  Copyright © 2016年 蒋俊. All rights reserved.
//

#import "JJLandingPutView.h"

@interface JJLandingPutView() <UITextFieldDelegate>
@property (strong, nonatomic)   UILabel *tostLabel;              /** 提示label */
@property (strong, nonatomic)   UITextField *userNameText;              /** 手机号text */
@property (strong, nonatomic)   UITextField *passwordText;              /** 密码text */
@property (strong, nonatomic)   UIButton *nextBtn;              /** 下一步button */
@property (strong, nonatomic)   UIButton *goLoginBtn;              /** 去登录 */
@property (strong, nonatomic)   UILabel *textBackLabel;              /** 输入框背景图 */
@property (strong, nonatomic)   UILabel *textLineLabel;              /** text中间的分割线 */
@end


@implementation JJLandingPutView

//重写初始化方法
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.tostLabel];
        [self addSubview:self.textBackLabel];
        [self addSubview:self.userNameText];
        [self addSubview:self.passwordText];
        [self addSubview:self.textLineLabel];
        [self addSubview:self.nextBtn];
        [self addSubview:self.goLoginBtn];
    }
    return self;
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

- (UILabel *)textBackLabel{
    if (!_textBackLabel) {
        _textBackLabel = [[UILabel alloc]init];
        _textBackLabel.backgroundColor = [UIColor whiteColor];
        _textBackLabel.layer.borderWidth = 1;
        _textBackLabel.layer.borderColor = RGB(188, 188, 188).CGColor;
    }
    return _textBackLabel;
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

- (UILabel *)textLineLabel{
    if (!_textLineLabel) {
        _textLineLabel = [[UILabel alloc]init];
        _textLineLabel.backgroundColor = RGB(188, 188, 188);
    }
    return _textLineLabel;
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

#pragma mark -- 布局子控件
- (void)layoutSubviews{
    [super layoutSubviews];
    
    __weak typeof (self) weakSelf = self;
    
    [_tostLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@35);
        make.top.right.equalTo(weakSelf);
        make.left.equalTo(weakSelf.mas_left).offset(15);
    }];
    
    [_textBackLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@89);
        make.top.equalTo(weakSelf.tostLabel.mas_bottom);
        make.left.equalTo(weakSelf.mas_left).offset(-1);
        make.right.equalTo(weakSelf.mas_right).offset(1);
    }];
    
    [_userNameText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(weakSelf).offset(15);
        make.height.equalTo(@44);
        make.top.equalTo(weakSelf.textBackLabel.mas_top);
    }];
    
    [_passwordText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(weakSelf).offset(15);
        make.height.equalTo(@44);
        make.top.equalTo(weakSelf.userNameText.mas_bottom).offset(1);
    }];
    
    [_textLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@1);
        make.left.equalTo(weakSelf.textBackLabel.mas_left).offset(15);
        make.right.equalTo(weakSelf.textBackLabel.mas_right).offset(-15);
        make.centerY.equalTo(weakSelf.textBackLabel.mas_centerY);
    }];
    
    [_nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).offset(16);
        make.right.equalTo(weakSelf.mas_right).offset(-16);
        make.height.equalTo(@35);
        make.top.equalTo(weakSelf.passwordText.mas_bottom).offset(15);
    }];
    
    [_goLoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(70, 16));
        make.right.equalTo(weakSelf.mas_right).offset(-15);
        make.top.equalTo(weakSelf.nextBtn.mas_bottom).offset(23);
    }];
}




#pragma mark - UITextField监听事件
-(void)userNameTextChangeText:(UITextField *)textField{
    
    if (textField.text.length == 11 && _passwordText.text.length > 5) {
        self.nextBtn.backgroundColor = RGB(56, 165, 241);
        self.nextBtn.userInteractionEnabled = YES;
    }else{
         self.nextBtn.backgroundColor = RGB(229, 229, 229);
          self.nextBtn.userInteractionEnabled = NO;
    }
}

-(void)passwordTextChangeText:(UITextField *)textField{
    
    if (textField.text.length > 5 && _userNameText.text.length == 11) {
        self.nextBtn.backgroundColor = RGB(56, 165, 241);
        self.nextBtn.userInteractionEnabled = YES;

    }else{
        
        self.nextBtn.backgroundColor = RGB(229, 229, 229);
        self.nextBtn.userInteractionEnabled = NO;

    }
}

//下一步按钮监听事件
-(void)pushNextViewController{
    
    
    NSLog(@"可以点G级嘛");
    
    
    
}


#pragma mark - UITextFieldDelegate
/*
 关于注册时，手机号和密码输入时的一些细节
 
 1.当手机号输入到11位时无法继续输入且手机号只能为数字
 2.密码隐藏显示，且有位数限定和输入内容格式限定
 3.只有当手机号和密码输入都达到最低要求时，下一步按钮方才能够点击
 */
//这个代理方法就是返回是否可以进行textField的内容输入
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textField == self.userNameText && range.location > 10) {
        //当检测到userNameText中输入的内容大于11位时，禁止其输入
        return NO;
        
    }
    return YES;
}








@end
