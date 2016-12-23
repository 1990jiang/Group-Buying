//
//  JJMyViewController.m
//  Group-Buying
//
//  Created by 蒋俊 on 16/12/23.
//  Copyright © 2016年 蒋俊. All rights reserved.
//

#import "JJMyViewController.h"

#import <Masonry.h>

@interface JJMyViewController ()

/**headView*/
@property (nonatomic , strong) UIView *headView;
/**loginBackImage*/
@property (nonatomic , strong) UIImageView *loginBackImage;
/**loginBtn*/
@property (nonatomic , strong) UIButton *loginBtn;
/**registerBtn*/
@property (nonatomic , strong) UIButton *registerBtn;


@end

@implementation JJMyViewController


#pragma mark -- 视图生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
 self.view.backgroundColor = [UIColor whiteColor];

    //设置这个属性是在有导航栏的情况下让布局从导航栏下面开始(不设置的话，会从导航栏顶部开始，我们在布局headView时就会出现问题)
   self.edgesForExtendedLayout = UIRectEdgeNone;
    //添加子控件
    [self.view addSubview:self.headView];
    [self.headView addSubview:self.loginBackImage];
    [self.headView addSubview:self.loginBtn];
    [self.headView addSubview:self.registerBtn];
    
    //调用方法
    [self setUpMasonyUI];
}

#pragma mark -- 懒加载
//头部视图
-(UIView *)headView
{
    if (!_headView){
        _headView = [[UIView alloc]init];
    }
    return _headView;
}
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
        _registerBtn.titleLabel.font = [UIFont systemFontOfSize:18.0f];
        
    }
    return _registerBtn;
}

#pragma mark -- 辅助方法
//控件布局代码
-(void)setUpMasonyUI{
   
    /*布局偏移:
     下偏移:正
     上偏移:负
     左偏移:负
     右偏移:正
    */
    
    __weak typeof(self) weakSelf = self;
    //headView
    [_headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(weakSelf.view);
        make.top.equalTo(weakSelf.view);
        make.height.mas_equalTo(125);
    }];
    //backImage
    [_loginBackImage mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.edges.equalTo(_headView);
    }];
    //loginBtn
    [_loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       //让按钮的X轴中心与父视图相等且向左偏移50
        make.centerX.equalTo(weakSelf.headView.mas_centerX).offset(-50);
        make.centerY.equalTo(weakSelf.headView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(60, 30));
    }];
    //registerBtn
    [_registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.headView.mas_centerX).offset(50);
        make.centerY.equalTo(weakSelf.headView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(60, 30));
    }];
    
    
    
    
}

@end
