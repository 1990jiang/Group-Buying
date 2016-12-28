//
//  JJAuthCodeView.h
//  Group-Buying
//
//  Created by 蒋俊 on 16/12/27.
//  Copyright © 2016年 蒋俊. All rights reserved.
//

#import <UIKit/UIKit.h>


//这个block传的参数就是验证码，因为输入验证码的那个textField没有暴露出来属性
typedef void(^LandingBlock)(NSString *code);

@interface JJAuthCodeView : UIView

/**记录从注册界面传过来的电话号码*/
@property (nonatomic , copy) NSString *phoneNumString;

/**注册按钮回调block*/
@property (nonatomic , strong) LandingBlock landingblock;



//GCD倒计时方法
-(void)countDownMethod;

@end
