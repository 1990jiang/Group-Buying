//
//  JJLandingPutView.h
//  Group-Buying
//
//  Created by 蒋俊 on 16/12/26.
//  Copyright © 2016年 蒋俊. All rights reserved.
//

#import <UIKit/UIKit.h>

//定义block,将手机号和密码传到下一个界面中
typedef void(^nextViewControllerBlock)(NSDictionary *dic);

@interface JJLandingPutView : UIView

/**block*/
@property (nonatomic , copy) nextViewControllerBlock nextBlock;



@end
