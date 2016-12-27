//
//  JJAuthCodeView.m
//  Group-Buying
//
//  Created by 蒋俊 on 16/12/27.
//  Copyright © 2016年 蒋俊. All rights reserved.
//

#import "JJAuthCodeView.h"

@interface JJAuthCodeView ()<UITextFieldDelegate>

@property (strong, nonatomic)   UILabel *tostLabel;              /** 提示验证码发送到哪个手机号的label */
@property (strong, nonatomic)   UILabel *backLabel;              /** 背景label */
@property (strong, nonatomic)   UITextField *codeText;              /** 验证码输入框 */
@property (strong, nonatomic)   UIButton *timeButton;              /** 显示倒计时button */
@property (strong, nonatomic)   UILabel *lineLabel;              /** 竖线 */
@property (strong, nonatomic)   UIButton *landingButton;              /** 注册button */

@end


@implementation JJAuthCodeView

#pragma mark -- 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.tostLabel];
        [self addSubview:self.backLabel];
        [self addSubview:self.codeText];
        [self addSubview:self.timeButton];
        [self addSubview:self.lineLabel];
        [self addSubview:self.landingButton];
    }
    return self;
}

- (UILabel *)tostLabel{
    if (!_tostLabel) {
        _tostLabel = [[UILabel alloc]init];
        _tostLabel.text = @"验证码已经发送到+ 86";
        _tostLabel.font = [UIFont systemFontOfSize:12.0];
    }
    return _tostLabel;
}

- (UILabel *)backLabel{
    if (!_backLabel) {
        _backLabel = [[UILabel alloc]init];
        _backLabel.backgroundColor = [UIColor whiteColor];
        _backLabel.layer.borderWidth = 1;
        _backLabel.layer.borderColor = RGB(188, 188, 188).CGColor;
    }
    return _backLabel;
}

- (UITextField *)codeText{
    if (!_codeText) {
        _codeText = [[UITextField alloc]init];
        _codeText.delegate = self;
        _codeText.placeholder = @"请输入验证码";
        [_codeText addTarget:self action:@selector(codeTextChangeText:) forControlEvents:(UIControlEventEditingChanged)];
        
    }
    return _codeText;
}

- (UIButton *)timeButton{
    if (!_timeButton) {
        _timeButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
       // [_timeButton addTarget:self action:@selector(GCDTime) forControlEvents:(UIControlEventTouchUpInside)];
        [_timeButton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    }
    return _timeButton;
}

- (UILabel *)lineLabel{
    if (!_lineLabel) {
        _lineLabel = [[UILabel alloc]init];
        _lineLabel.backgroundColor = RGB(188, 188, 188);
    }
    return _lineLabel;
}

- (UIButton *)landingButton{
    if (!_landingButton) {
        _landingButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_landingButton setTitle:@"注册" forState:(UIControlStateNormal)];
        _landingButton.backgroundColor = RGB(229, 229, 229);
        _landingButton.userInteractionEnabled = NO;
        [_landingButton setTitleColor:RGB(132, 132, 132) forState:(UIControlStateNormal)];
        [_landingButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateSelected)];
        _landingButton.selected = NO;
       // [_landingButton addTarget:self action:@selector(landingMethod) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _landingButton;
}

#pragma mark -- 布局
- (void)layoutSubviews{
    [super layoutSubviews];
    __weak typeof (self) weakSelf = self;
    
    [_tostLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@35);
        make.top.right.equalTo(weakSelf);
        make.left.equalTo(weakSelf.mas_left).offset(15);
    }];
    
    [_backLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@44);
        make.top.equalTo(weakSelf.tostLabel.mas_bottom);
        make.left.equalTo(weakSelf.mas_left).offset(-1);
        make.right.equalTo(weakSelf.mas_right).offset(1);
    }];
    
    [_codeText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.backLabel.mas_left).offset(15);
        make.top.bottom.equalTo(weakSelf.backLabel);
        make.right.equalTo(weakSelf.backLabel.mas_right).offset(VIEW_WIDTH-110);
    }];
    
    [_timeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 44));
        make.right.top.equalTo(weakSelf.backLabel);
    }];
    
    [_lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(1, 30));
        make.centerY.equalTo(weakSelf.backLabel.mas_centerY);
        make.right.equalTo(weakSelf.timeButton.mas_left).offset(-1);
    }];
    
    [_landingButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).offset(16);
        make.right.equalTo(weakSelf.mas_right).offset(-16);
        make.height.equalTo(@35);
        make.top.equalTo(weakSelf.codeText.mas_bottom).offset(15);
    }];
}


#pragma mark -- 监听方法
- (void)codeTextChangeText:(UITextField *)textField{
    if (textField.text.length == 6) {
        self.landingButton .userInteractionEnabled = YES;
        self.landingButton.backgroundColor = RGB(56, 166, 241);
        self.landingButton.selected = YES;
    }else{
        self.landingButton .userInteractionEnabled = NO;
        self.landingButton.backgroundColor = RGB(229, 229, 229);
        self.landingButton.selected = NO;
    }
}

#pragma mark -- UITextField代理方法
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if (range.location == 6){
        //不需要判断textField是哪一个了，因为只有一个textField
        return  NO;
    }
    return YES;
    
}

@end
