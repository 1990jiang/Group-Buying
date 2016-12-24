//
//  JJMyViewController.m
//  Group-Buying
//
//  Created by 蒋俊 on 16/12/23.
//  Copyright © 2016年 蒋俊. All rights reserved.
//

#import "JJMyViewController.h"
#import "JJMyMessageCell.h"


@interface JJMyViewController ()<UITableViewDelegate,UITableViewDataSource>

/**headView*/
@property (nonatomic , strong) UIView *headView;
/**loginBackImage*/
@property (nonatomic , strong) UIImageView *loginBackImage;
/**loginBtn*/
@property (nonatomic , strong) UIButton *loginBtn;
/**registerBtn*/
@property (nonatomic , strong) UIButton *registerBtn;

/**tableView*/
@property (nonatomic , strong) UITableView *tableView;

/**存储数组*/
@property (nonatomic , strong) NSArray *sourceArr;


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
    [self.headView addSubview:self.loginBackImage];
    [self.headView addSubview:self.loginBtn];
    [self.headView addSubview:self.registerBtn];
    [self.view addSubview:self.tableView];
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
//展示tableView
-(UITableView *)tableView
{
    if (!_tableView){
       //这里可以先对tableView的frame设置为nil，因为要设置其自动布局约束
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        //让tableView不能滑动还有一种设置方法(前提是这个tableView的大小是固定的)
        //_tableView.scrollEnabled = NO;
        _tableView.bounces = NO;
    }
    return _tableView;
}
//数据数组
-(NSArray *)sourceArr
{
    if (!_sourceArr){
        //这个数组里面嵌套有字典
    _sourceArr = @[
  
   @{@"image":@"我的界面我的收藏图标",@"title":@"我的收藏"},
   @{@"image":@"我的界面意见反馈图标",@"title":@"意见反馈"},
   @{@"image":@"我的界面关于我们图标",@"title":@"关于我们"},
   @{@"image":@"我的界面客服热线图标",@"title":@"客服热线"},
   @{@"image":@"我的界面我的优惠券图标",@"title":@"我的优惠劵"},
   @{@"image":@"我的界面邀请好友图标",@"title":@"邀请好友,立刻赚钱"}
  
   ];
    }
    return _sourceArr;
}

#pragma mark -- tableView代理和数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  4;
}

//返回每行cell的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
   static NSString *ID = @"messageCell";
    JJMyMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[JJMyMessageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    //关键步骤，自己弄假数据就可以这样写
    cell.sourceDic = self.sourceArr[indexPath.row];
   // cell.sourceDic 实际上是调用了cell里面的字典属性的set方法，然后这边传一个字典给这个方法里面，从而给cell的字典属性 sourceDic赋值 [cell setSourceDic:sourceDic];
    
    
    //做判断
    if (indexPath.row == 3) {
        //由于我们的nextImage是没有暴露出来的属性，我们通过KVC暴力获取一下
        UIImageView *nextImage = [cell valueForKey:@"nextImage"];
        //[nextImage removeFromSuperview];
        //nextImage = nil;
        //这里不能把这个nextImage移除了，因为我们在cell的layoutSubViews方法中给nextImage在添加约束，但是当其走到indexPath.row == 3时发现nextImage没有了，程序必然崩溃了
        nextImage.hidden = YES;
        
        
        UILabel *phoneNum = [[UILabel alloc]init];
        phoneNum.text = @"400-820-8820";
        phoneNum.textColor = RGB(122, 124, 128);
        phoneNum.font = [UIFont systemFontOfSize:18];
        phoneNum.textAlignment = NSTextAlignmentRight;
        [cell.contentView addSubview:phoneNum];
        
        __weak typeof(cell) weakSelf = cell;
        [phoneNum mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakSelf.mas_centerY);
            make.right.equalTo(weakSelf.mas_right).offset(-15);
            make.size.mas_equalTo(CGSizeMake(150, 18));
            
        }];
        
    }
    
    return cell;
    
}

//选择cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
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
    
    //tableView
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(weakSelf.view);
        make.height.mas_equalTo(176);
        make.top.equalTo(weakSelf.headView.mas_bottom).offset(35);
    }];
}

@end
