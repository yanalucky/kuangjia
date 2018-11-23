//
//  UABaseNavigationController.h
//  demo
//
//  Created by perfayMini on 2018/11/23.
//  Copyright © 2018 huawei. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UABaseNavigationController : UINavigationController

/*!
 *  返回到指定的类视图
 *
 *  @param ClassName 类名
 *  @param animated  是否动画
 */
-(BOOL)popToAppointViewController:(NSString *)ClassName animated:(BOOL)animated;

-(instancetype)getCurrentViewControllerClass:(NSString *)ClassName;


@end

NS_ASSUME_NONNULL_END
