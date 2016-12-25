//
//  JJMyTableView.m
//  Group-Buying
//
//  Created by 蒋俊 on 16/12/25.
//  Copyright © 2016年 蒋俊. All rights reserved.
//

#import "JJMyTableView.h"
#import "JJMyMessageCell.h"



//自定义tableView，其实就是将tableView从控制器中分离出来

@interface JJMyTableView () <UITableViewDelegate,UITableViewDataSource>

/**存储数组*/
@property (nonatomic , strong) NSArray *sourceArr;


@end

@implementation JJMyTableView

//重写初始化方法
-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    
    if (self) {
        
        self.delegate = self;
        self.dataSource = self;
        //让tableView不能滑动还有一种设置方法(前提是这个tableView的大小是固定的)
        //_tableView.scrollEnabled = NO;
        self.bounces = NO;
    }
    
    
    return self;
}
#pragma mark -- 初始化数据
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



@end
