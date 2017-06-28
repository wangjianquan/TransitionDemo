//
//  SwipeTransitionAnimator.m
//  CustomTransition_wjq
//
//  Created by landixing on 2017/3/16.
//  Copyright © 2017年 landixing. All rights reserved.
//

#import "SwipeTransitionAnimator.h"

@implementation SwipeTransitionAnimator


- (instancetype)initWithTargetEdge:(UIRectEdge)targetEdge{
    if (self = [super init]) {
        _targetEdge = targetEdge;
    }
    return self;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return [transitionContext isAnimated] ? 0.5 : 0;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{

    UIViewController * fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController * toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView * fromView;
    UIView * toView;
    
    //iOS 8
    if ([transitionContext respondsToSelector:@selector(viewForKey:)]) {
        fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    }else{
        fromView = fromViewController.view;
        toView = toViewController.view;
    }
    
    BOOL isPresenting = (toViewController.presentingViewController == fromViewController);
    
    CGRect fromFrame = [transitionContext initialFrameForViewController:fromViewController];
    CGRect toFrame = [transitionContext finalFrameForViewController:toViewController];
    
    //二维矢量
    CGVector offset;
    if (self.targetEdge == UIRectEdgeTop) {
        
        offset = CGVectorMake(0.f, 1.f);
    } else if(self.targetEdge == UIRectEdgeBottom) {
        offset = CGVectorMake(0.f, -1.0f);
    }else if (self.targetEdge == UIRectEdgeLeft){
        offset = CGVectorMake(1.f, 0.f);
    }else if (self.targetEdge == UIRectEdgeRight){
        offset = CGVectorMake(-1.f, 0.f);
    }else{
        NSAssert(NO, @"targetEdge must be one of UIRectEdgeTop, UIRectEdgeBottom, UIRectEdgeLeft, or UIRectEdgeRight.");
    }
    UIView * containerView = [transitionContext containerView];
    
    if (isPresenting) {
        // For a presentation, the toView starts off-screen and slides in.
        fromView.frame = fromFrame;
        toView.frame = CGRectOffset(toFrame, toFrame.size.width * offset.dx * -1,toFrame.size.height * offset.dy * -1);
    } else {
        fromView.frame = fromFrame;
        toView.frame = toFrame;
    }
    

    if (isPresenting) {
        [containerView addSubview:toView];
    }else{
        [containerView insertSubview:toView belowSubview:fromView];
    }
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.0 usingSpringWithDamping:1.0 initialSpringVelocity:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        
        if (isPresenting) {
            toView.frame = toFrame;
        } else {
            fromView.frame = CGRectOffset(fromFrame, fromFrame.size.width * offset.dx,
                                          fromFrame.size.height * offset.dy);
        }
        
    } completion:^(BOOL finished) {
        BOOL wasCancelled = [transitionContext transitionWasCancelled];
        if(wasCancelled)  [toView removeFromSuperview];
        [transitionContext completeTransition:!wasCancelled];
    }];
    
}

























@end
