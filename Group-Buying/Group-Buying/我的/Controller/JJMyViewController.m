//
//  JJMyViewController.m
//  Group-Buying
//
//  Created by 蒋俊 on 16/12/23.
//  Copyright © 2016年 蒋俊. All rights reserved.
//

#import "JJMyViewController.h"
#import "JJMyTableView.h" //自定义tableView
#import "JJMyHeadView.h" //自定义头部视图

@interface JJMyViewController ()

/**headView*/
@property (nonatomic , strong) JJMyHeadView *headView;


/**tableView*/
@property (nonatomic , strong) JJMyTableView *tableView;




@end

@implementation JJMyViewController


#pragma mark -- 视图生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGB(242, 242, 242);

    //设置这个属性是在有导航栏的情况下让布局从导航栏下面开始(不设置的话，会从导航栏顶部开始，我们在布局headView时就会出现问题)
   self.edgesForExtendedLayout = UIRectEdgeNone;
    //添加子控件
    [self.view addSubview:self.headView];
   
    [self.view addSubview:self.tableView];
  
    //调用方法
    [self setUpMasonyUI];
}

#pragma mark -- 懒加载
//头部视图
-(JJMyHeadView *)headView
{
    if (!_headView){
        _headView = [[JJMyHeadView alloc]init];
    }
    return _headView;
}
//展示tableView
-(JJMyTableView *)tableView
{
    if (!_tableView){
       //这里可以先对tableView的frame设置为nil，因为要设置其自动布局约束
        _tableView = [[JJMyTableView alloc]initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStylePlain];
    }
    return _tableView;
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
    
    //tableView
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(weakSelf.view);
        make.height.mas_equalTo(176);
        make.top.equalTo(weakSelf.headView.mas_bottom).offset(35);
    }];
}

@end
