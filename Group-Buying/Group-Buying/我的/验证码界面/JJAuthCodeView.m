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
        _tostLabel.font = [UIFont systemFontOfSize:15.0];
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
       [_timeButton addTarget:self action:@selector(countDownMethod) forControlEvents:(UIControlEventTouchUpInside)];
        [_timeButton setTitleColor:RGB(56, 166, 243) forState:(UIControlStateNormal)];
         [_timeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
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
#pragma mark -- setter方法
- (void)setPhoneNumString:(NSString *)phoneNumString{
    
    _phoneNumString = phoneNumString;
    _tostLabel.attributedText = [self makeTostLabelAttributed];
    
}

#pragma mark -- 辅助方法
//制作tostLabel的属性文本
- (NSMutableAttributedString *)makeTostLabelAttributed{
    NSMutableAttributedString *string1 = [[NSMutableAttributedString alloc]initWithString:@"验证码已经发送到 " attributes:@{NSForegroundColorAttributeName:RGB(139, 139, 139)}];
    NSMutableAttributedString *string2 = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"+86 %@",_phoneNumString] attributes:@{NSForegroundColorAttributeName:RGB(56, 166, 243), NSFontAttributeName : [UIFont systemFontOfSize:16]}];
    //拼接一下
    [string1 insertAttributedString:string2 atIndex:string1.length];
    return string1;
}
//制作timeButton的属性文本
- (NSMutableAttributedString *)makeTimeButtonAttributed:(NSInteger)time{
    NSMutableAttributedString *string3 = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%li",time] attributes:@{NSForegroundColorAttributeName:RGB(56, 166, 243)}];
    NSMutableAttributedString *string4 = [[NSMutableAttributedString alloc]initWithString:@"秒后重试" attributes:@{NSForegroundColorAttributeName:RGB(139, 139, 139)}];
    
    [string3 insertAttributedString:string4 atIndex:string3.length];
    return string3;
}

//获取验证码按钮倒计时方法
//也可以把这个方法直接放在viewDidLoad中，这样直接进入页面就开始调用了
-(void)countDownMethod{
    //GCD的倒计时方法(直接敲dispatch_source_t回车就好)
   
      __block NSInteger time = 5;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    /*
     参数:
     <#dispatchQueue#>:
     <#intervalInSeconds#>:时间间隔
     <#leewayInSeconds#>:执行时间(输入0,就是让其立即执行)
     <#code to be executed when timer fires#>:执行内容
     */
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, ^{
        if (time < 1) {
           //结束定时器
            dispatch_source_cancel(timer);
          //重新设置timeBtn标题
            NSMutableAttributedString *string = [[NSMutableAttributedString alloc]initWithString:@"重新发送" attributes:@{NSForegroundColorAttributeName:RGB(56, 166, 243)}];
            //在主线程中更新UI
            dispatch_async(dispatch_get_main_queue(), ^{
                _timeButton.userInteractionEnabled = YES;
                [_timeButton setAttributedTitle:string forState:(UIControlStateNormal)];
            });
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                _timeButton.userInteractionEnabled = NO;
                [_timeButton setAttributedTitle:[self makeTimeButtonAttributed:time] forState:(UIControlStateNormal)];
            });
            time --;
        }
    });
    dispatch_resume(timer);
    
    
    
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
