//
//  JJBaseNavigationController.m
//  Group-Buying
//
//  Created by 蒋俊 on 16/12/23.
//  Copyright © 2016年 蒋俊. All rights reserved.
//

#import "JJBaseNavigationController.h"

@interface JJBaseNavigationController ()

@end

@implementation JJBaseNavigationController

/*
 initialize方法相关要点:
 initialize的自然调用是在第一次主动使用当前类的时候（lazy，这一点和Java类的“clinit”的很像）。
 在initialize方法收到调用时，运行环境基本健全。
 initialize的运行过程中是能保证线程安全的。
 和load不同，即使子类不实现initialize方法，会把父类的实现继承过来调用一遍。注意的是在此之前，父类的方法已经被执行过一次了，同样不需要super调用。
 由于initialize的这些特点，使得其应用比load要略微广泛一些。可用来做一些初始化工作，或者单例模式的一种实现方案。
 
 */


+(void)initialize{
  //为什么不把设置导航栏属性的代码方法viewDidLoad方法中，因为如果放在那里面的话，会调用多次(自己试验一下)
    //利用appearance设置导航栏的属性
    UINavigationBar *navBar = [UINavigationBar appearance];
    
    //设置背景图片
    [navBar setBackgroundImage:[UIImage imageNamed:@"nav_backImage"] forBarMetrics:UIBarMetricsDefault];
    //设置标题文字样式
    [ navBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor] , NSFontAttributeName : [UIFont boldSystemFontOfSize:20.0f] }];
}

- (void)viewDidLoad {
    [super viewDidLoad];

 


}

#pragma mark -- 重写方法在跳转的时候隐藏tabBar
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
   // NSLog(@"加载前 %li",self.childViewControllers.count);
    
    //判断一下，如果是有子控制器，证明已经push过了，所以要统一修改放回按钮
    if (self.childViewControllers.count) {
       
        //设置统一的返回按钮
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [backBtn setImage:[UIImage imageNamed:@"详情界面返回按钮"] forState:UIControlStateNormal];
        backBtn.frame = CGRectMake(0, 0, 30, 30);
        [backBtn addTarget:self action:@selector(backToViewController) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
        viewController.navigationItem.leftBarButtonItem = item;
        
        //隐藏tabBar
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
    
}

-(void)backToViewController{
    
    [self popViewControllerAnimated:YES];
    
}























@end
