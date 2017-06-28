//
//  DissolveTransitionAnimator.m
//  CustomTransition_wjq
//
//  Created by landixing on 2017/3/14.
//  Copyright © 2017年 landixing. All rights reserved.
//

#import "DissolveTransitionAnimator.h"

#define duration 0.8

@interface DissolveTransitionAnimator ()



@end




@implementation DissolveTransitionAnimator



//==========================================================//


#pragma mark -- UIViewControllerContextTransitioning
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext{
    return [transitionContext isAnimated] ? duration : 0;

}

//具体实现
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    //起始ViewControll
    UIViewController * fromViewControll = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    //目标ViewControll
    UIViewController * toViewControll  = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView * fromView ;
    UIView * toView ;
    
    //iOS 8.0
    if ([transitionContext respondsToSelector:@selector(viewForKey:)]) {
        fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    } else {
        fromView = fromViewControll.view;
        toView = toViewControll.view;
    }
    

    
    //容器视图 //添加到上下文
    UIView * containerView = [transitionContext containerView];
    
    //添加到容器视图
    [containerView addSubview:toView];
    
    fromView.alpha = 1.0;
    toView.alpha = 0.0;
    
    
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        fromView.alpha = 0.0;
        toView.alpha = 1.0;
    } completion:^(BOOL finished) {
        BOOL wasCancelled = [transitionContext transitionWasCancelled];
        [transitionContext completeTransition:!wasCancelled];
    }];

}









@end
