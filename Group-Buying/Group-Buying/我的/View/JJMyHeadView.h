//
//  JJMyHeadView.h
//  Group-Buying
//
//  Created by 蒋俊 on 16/12/25.
//  Copyright © 2016年 蒋俊. All rights reserved.
//

#import <UIKit/UIKit.h>

//对于注册按钮来说，不想暴露出属性，又想在主控制器获得其监听方法，就用block

/*
 
 对于block使用的三大步骤
 1.定义block,有参数返回值等，设置block属性
 2.内部调用block
 3.外部实现block
 */
typedef void(^registerBtnBlock)();

@interface JJMyHeadView : UIView

//定义block属性
//1.注册按钮block
@property (nonatomic , copy) registerBtnBlock registerBlock;


@end
