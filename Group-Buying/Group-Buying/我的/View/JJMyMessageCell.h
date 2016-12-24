//
//  JJMyMessageCell.h
//  Group-Buying
//
//  Created by 蒋俊 on 16/12/24.
//  Copyright © 2016年 蒋俊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JJMyMessageCell : UITableViewCell


/**iconImage*/
@property (nonatomic , strong) UIImageView *iconImage;
/**titleLabel*/
@property (nonatomic , strong) UILabel *titleLabel;


/**存储cell数据的字典*/
@property (nonatomic , strong) NSDictionary *sourceDic;
//这里设置一个字典来接收那边数组里面的字典




@end
