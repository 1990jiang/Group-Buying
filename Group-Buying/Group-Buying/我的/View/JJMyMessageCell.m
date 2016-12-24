//
//  JJMyMessageCell.m
//  Group-Buying
//
//  Created by 蒋俊 on 16/12/24.
//  Copyright © 2016年 蒋俊. All rights reserved.
//

#import "JJMyMessageCell.h"

//类扩展
@interface JJMyMessageCell ()

/**iconImage*/
@property (nonatomic , strong) UIImageView *iconImage;
/**titleLabel*/
@property (nonatomic , strong) UILabel *titleLabel;
/**nextImage*/
@property (nonatomic , strong) UIImageView *nextImage;
/**lineLabel*/
//还可以用label做分割线的
@property (nonatomic , strong) UILabel *lineLabel;



@end


@implementation JJMyMessageCell

//纯代码设置cell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifie{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifie];
    if (self) {
        
        [self addSubview:self.iconImage];
        [self addSubview:self.titleLabel];
        [self addSubview:self.nextImage];
        [self addSubview:self.lineLabel];
        
        
    }
    
    
    return self;
}

#pragma mark -- 懒加载初始化各个控件
-(UIImageView *)iconImage
{
    if (!_iconImage){
        _iconImage = [[UIImageView alloc]init];
    }
    return _iconImage;
}
-(UILabel *)titleLabel
{
    if (!_titleLabel){
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont systemFontOfSize:15.0f];
        _titleLabel.textColor = [UIColor blackColor];
    }
    return _titleLabel;
}
-(UIImageView *)nextImage
{
    if (!_nextImage){
        _nextImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"下一步"]];
    }
    return _nextImage;
}
-(UILabel *)lineLabel
{
    if (!_lineLabel){
        _lineLabel = [[UILabel alloc]init];
        _lineLabel.backgroundColor = RGB(242, 242, 242);
    }
    return _lineLabel;
}

#pragma mark -- 给各个控件添加约束
-(void)layoutSubviews{
    //不要忘记调用父类
    [super layoutSubviews];
    
    __weak typeof(self) weakSelf = self;
    
    [_iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.left.equalTo(weakSelf.mas_left).offset(15);
        make.centerY.equalTo(weakSelf.mas_centerY);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(140, 15));
         make.centerY.equalTo(weakSelf.mas_centerY);
        make.left.equalTo(weakSelf.iconImage.mas_right).offset(15);
        
    }];
    
    [_nextImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(10, 14));
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.right.equalTo(weakSelf.mas_right).offset(-15);
    }];
    
    [_lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.height.mas_equalTo(1);
        make.left.equalTo(weakSelf.titleLabel.mas_left);
        make.right.equalTo(weakSelf.mas_right);
        make.bottom.equalTo(weakSelf.mas_bottom);
    }];
    
    
    
    
}








- (void)awakeFromNib {
    [super awakeFromNib];
   

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

@end
