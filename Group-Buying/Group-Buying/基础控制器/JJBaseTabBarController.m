//
//  JJBaseTabBarController.m
//  Group-Buying
//
//  Created by 蒋俊 on 16/12/22.
//  Copyright © 2016年 蒋俊. All rights reserved.
//

#import "JJBaseTabBarController.h"
#import "JJBaseNavigationController.h"

@interface JJBaseTabBarController ()

/**存放子控制器信息数组*/
@property (nonatomic , strong) NSArray *viewControllerArrays;


@end

@implementation JJBaseTabBarController

#pragma mark -- 懒加载
-(NSArray *)viewControllerArrays
{
    if (!_viewControllerArrays){
        //从bundle中加载plist文件
        _viewControllerArrays = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"JJTabBarViewController" ofType:@"plist"]];
    }
    return _viewControllerArrays;
}


#pragma mark -- 视图生命周期
- (void)viewDidLoad {
    [super viewDidLoad];

    //通过appearance对tabBarItem 的标题属性进行设置
    //未选中时的文字属性
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:132/255.0 green:132/255.0 blue:132/255.0 alpha:1]} forState:(UIControlStateNormal)];
     //选中时的文字属性
     [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:56/255.0 green:165/255.0 blue:241/255.0 alpha:1]} forState:(UIControlStateSelected)];
    //设置tabBar背景图片
    [self.tabBar setBackgroundImage:[UIImage imageNamed:@"tabbar_back"]];
    
    //从字典数组中取出各个子控制器进行属性设置
    for (NSDictionary *dic in self.viewControllerArrays) {
       
        //从plist里面取出来的只是一个类名(NSString的)
        Class view = NSClassFromString(dic[@"viewController"]);
        
        //这里为什么要用view alloc:因为只有这样创建，创建出来的类才是我们对应的那四个控制器
        UIViewController *viewController = [[view alloc]init];
        
        viewController.tabBarItem.image = [UIImage imageNamed:dic[@"image"]];
        viewController.tabBarItem.selectedImage = [UIImage imageNamed:dic[@"selectImage"]];
        //设置的是控制器的导航栏标题
        viewController.title = dic[@"title"];
        
        JJBaseNavigationController *nav = [[JJBaseNavigationController alloc]initWithRootViewController:viewController];
        [self addChildViewController:nav];
    }

    
}






@end
