//
//  UABaseNavigationController.m
//  demo
//
//  Created by perfayMini on 2018/11/23.
//  Copyright © 2018 huawei. All rights reserved.
//

#import "UABaseNavigationController.h"

@interface UABaseNavigationController ()<UINavigationControllerDelegate,UIGestureRecognizerDelegate>
@property (nonatomic, weak) id popDelegate;
@property (nonatomic,strong) UIPercentDrivenInteractiveTransition *interactivePopTransition;
@property (nonatomic,strong) UIScreenEdgePanGestureRecognizer *popRecognizer;
@property(nonatomic,assign) BOOL isSystemSlidBack;//是否开启系统右滑返回
@end

@implementation UABaseNavigationController

//APP生命周期中 只会执行一次
+ (void)initialize
{
    //导航栏主题 title文字属性
    UINavigationBar *navBar = [UINavigationBar appearance];
    //导航栏背景图
    [navBar setTintColor:[UIColor whiteColor]];
    [navBar setTitleTextAttributes:@{NSForegroundColorAttributeName :[UIColor blackColor], NSFontAttributeName : [UIFont systemFontOfSize:18]}];
    //    UIImage *colorImage = [UIImage imageWithColor:[UIColor whiteColor]];
    //    [navBar setBackgroundImage:colorImage forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    navBar.barTintColor = [UIColor whiteColor];
    navBar.tintColor = [UIColor blackColor];
    //    [navBar setBackgroundImage:[UIImage imageNamed:@"com_ic_bg"] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    //    navBar.translucent = NO;
    //    navBar.layer.masksToBounds = YES;
    //af78fb 5296fc
    //    [navBar setShadowImage:[UIImage new]];//去掉阴影线
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

/**
 *  返回到指定的类视图
 *
 *  @param ClassName 类名
 *  @param animated  是否动画
 */
-(BOOL)popToAppointViewController:(NSString *)ClassName animated:(BOOL)animated
{
    id vc = [self getCurrentViewControllerClass:ClassName];
    if(vc != nil && [vc isKindOfClass:[UIViewController class]])
    {
        [self popToViewController:vc animated:animated];
        return YES;
    }
    
    return NO;
}

/*!
 *  获得当前导航器显示的视图
 *
 *  @param ClassName 要获取的视图的名称
 *
 *  @return 成功返回对应的对象，失败返回nil;
 */
-(instancetype)getCurrentViewControllerClass:(NSString *)ClassName
{
    Class classObj = NSClassFromString(ClassName);
    NSArray * szArray =  self.viewControllers;
    for (id vc in szArray) {
        if([vc isMemberOfClass:classObj])
        {
            return vc;
        }
    }
    return nil;
}


-(UIViewController *)childViewControllerForStatusBarStyle{
    return self.topViewController;
}


#pragma mark ————— 转场动画区 —————
/*
 //navigation切换是会走这个代理
 -(id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
 {
 NSLog(@"转场动画代理方法");
 self.isSystemSlidBack = YES;
 //如果来源VC和目标VC都实现协议，那么都做动画
 if ([fromVC conformsToProtocol:@protocol(XYTransitionProtocol)] && [toVC conformsToProtocol:@protocol(XYTransitionProtocol)]) {
 
 BOOL pinterestNedd = [self isNeedTransition:fromVC:toVC];
 XYTransition *transion = [XYTransition new];
 if (operation == UINavigationControllerOperationPush && pinterestNedd) {
 transion.isPush = YES;
 
 //暂时屏蔽带动画的右划返回
 self.isSystemSlidBack = NO;
 //            self.isSystemSlidBack = YES;
 }
 else if(operation == UINavigationControllerOperationPop && pinterestNedd)
 {
 //暂时屏蔽带动画的右划返回
 //            return nil;
 
 transion.isPush = NO;
 self.isSystemSlidBack = NO;
 }
 else{
 return nil;
 }
 return transion;
 }else if([toVC conformsToProtocol:@protocol(XYTransitionProtocol)]){
 //如果只有目标VC开启动画，那么isSystemSlidBack也要随之改变
 BOOL pinterestNedd = [self isNeedTransition:toVC];
 self.isSystemSlidBack = !pinterestNedd;
 return nil;
 }
 return nil;
 }
 
 
 //判断fromVC和toVC是否需要实现pinterest效果
 -(BOOL)isNeedTransition:(UIViewController<XYTransitionProtocol> *)fromVC :(UIViewController<XYTransitionProtocol> *)toVC
 {
 BOOL a = NO;
 BOOL b = NO;
 if ([fromVC respondsToSelector:@selector(isNeedTransition)] && [fromVC isNeedTransition]) {
 a = YES;
 }
 if ([toVC respondsToSelector:@selector(isNeedTransition)] && [toVC isNeedTransition]) {
 b = YES;
 }
 return (a && b) ;
 
 }
 //判断fromVC和toVC是否需要实现pinterest效果
 -(BOOL)isNeedTransition:(UIViewController<XYTransitionProtocol> *)toVC
 {
 BOOL b = NO;
 if ([toVC respondsToSelector:@selector(isNeedTransition)] && [toVC isNeedTransition]) {
 b = YES;
 }
 return b;
 
 }
 
 #pragma mark -- NavitionContollerDelegate
 - (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
 interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController
 {
 if (!self.interactivePopTransition) { return nil; }
 return self.interactivePopTransition;
 }
 */

#pragma mark UIGestureRecognizer handlers

- (void)handleNavigationTransition:(UIScreenEdgePanGestureRecognizer*)recognizer
{
    CGFloat progress = [recognizer translationInView:self.view].x / (self.view.bounds.size.width);
    //    progress = MIN(1.0, MAX(0.0, progress));
    NSLog(@"右划progress %.2f",progress);
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        self.interactivePopTransition = [[UIPercentDrivenInteractiveTransition alloc] init];
        [self popViewControllerAnimated:YES];
    }
    else if (recognizer.state == UIGestureRecognizerStateChanged) {
        [self.interactivePopTransition updateInteractiveTransition:progress];
    }
    else if (recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == UIGestureRecognizerStateCancelled) {
        CGPoint velocity = [recognizer velocityInView:recognizer.view];
        
        if (progress > 0.5 || velocity.x >100) {
            [self.interactivePopTransition finishInteractiveTransition];
        }
        else {
            [self.interactivePopTransition cancelInteractiveTransition];
        }
        self.interactivePopTransition = nil;
    }
}

@end
