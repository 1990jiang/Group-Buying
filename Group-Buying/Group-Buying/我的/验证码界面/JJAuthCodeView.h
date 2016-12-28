//
//  JJAuthCodeView.h
//  Group-Buying
//
//  Created by 蒋俊 on 16/12/27.
//  Copyright © 2016年 蒋俊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JJAuthCodeView : UIView

/**记录从注册界面传过来的电话号码*/
@property (nonatomic , copy) NSString *phoneNumString;

//GCD倒计时方法
-(void)countDownMethod;

@end
