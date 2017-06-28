//
//  SlideTransitionAnimator.m
//  CustomTransition_wjq
//
//  Created by landixing on 2017/3/17.
//  Copyright © 2017年 landixing. All rights reserved.
//

#import "SlideTransitionAnimator.h"

@implementation SlideTransitionAnimator

- (instancetype)initWithTargetEdge:(UIRectEdge)targetEdge{
    if ( self = [super init]) {
        _targetEdge = targetEdge;
    }
    return self;
}


- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return [transitionContext isAnimated] ? 0.35 : 0;
}


- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    UIViewController * fromViewControll = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController * toViewControll = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView * fromView ;
    UIView * toView ;
    if ([transitionContext respondsToSelector:@selector(viewForKey:)]) {
        fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        toView =[transitionContext viewForKey:UITransitionContextToViewKey];
    }else{
        fromView = fromViewControll.view;
        toView = toViewControll.view;
    }
    UIView * containerView = [transitionContext containerView];
    
    [containerView addSubview:toView];
    
    CGRect fromViewFrame = [transitionContext initialFrameForViewController:fromViewControll];
    
    CGRect toViewFrame = [transitionContext finalFrameForViewController:toViewControll];
    
    CGVector offset;
    
    if (self.targetEdge == UIRectEdgeLeft) {
        offset = CGVectorMake(-1.f, 0.f);
    }else if (self.targetEdge == UIRectEdgeRight){
        offset =CGVectorMake(1.f, 0.f);
    }else{
        NSAssert(NO, @"targetEdge must be one of UIRectEdgeLeft, or UIRectEdgeRight.");
    }
   
    
    fromView.frame = fromViewFrame;
    toView.frame = CGRectOffset(toViewFrame, toViewFrame.size.width * offset.dx * -1, toViewFrame.size.height * offset.dy * -1);
 
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        
        fromView.frame = CGRectOffset(fromViewFrame, fromViewFrame.size.width * offset.dx, fromViewFrame.size.height * offset.dy);
        toView.frame = toViewFrame;
        
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
    
}


@end
