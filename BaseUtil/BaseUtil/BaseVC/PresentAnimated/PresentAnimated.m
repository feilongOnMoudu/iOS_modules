//
//  PresentAnimated.m
//  hschain
//
//  Created by 宋飞龙 on 2018/1/2.
//  Copyright © 2018年 宋飞龙. All rights reserved.
//

#import "PresentAnimated.h"

@implementation PresentAnimated

//1.定义转场动画的时间
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.3;
}

//2.实现转场动画的动画效果
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];   //主页VC
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];     //present的VC
    
    UIView *containerView = transitionContext.containerView;  //转场的容器视图，动画完成后，会消失
    UIView *fromView;
    UIView *toView;
    
    if ([transitionContext respondsToSelector:@selector(viewForKey:)]) {
        fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    } else {
        fromView = fromViewController.view;
        toView = toViewController.view;
    }
    
    //注意这个对应关系
    BOOL isPresenting = (toViewController.presentingViewController == fromViewController);
    
    CGRect fromFrame = [transitionContext initialFrameForViewController:fromViewController];
    CGRect toFrame = [transitionContext finalFrameForViewController:toViewController];
    
    if (isPresenting) {
        fromView.frame = fromFrame;
        toView.frame = CGRectOffset(toFrame, toFrame.size.width, 0);
    }
    
    if (isPresenting)
        [containerView addSubview:toView];
    
    NSTimeInterval transitionDuration = [self transitionDuration:transitionContext];
    
    [UIView animateWithDuration:transitionDuration animations:^{
        if (isPresenting) {
            toView.frame = toFrame;
            fromView.frame = CGRectOffset(fromFrame, fromFrame.size.width * 0.3 * -1, 0);
        }
    } completion:^(BOOL finished) {
        //固定写法
        BOOL wasCancelled = [transitionContext transitionWasCancelled];
        
        if (wasCancelled)
            [toView removeFromSuperview];
        
        [transitionContext completeTransition:!wasCancelled];
    }];
}

@end
