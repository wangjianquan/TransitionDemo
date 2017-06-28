//
//  SwipeTransitioning.m
//  CustomTransition_wjq
//
//  Created by landixing on 2017/3/16.
//  Copyright © 2017年 landixing. All rights reserved.
//

#import "SwipeTransitioning.h"
#import "SwipeTransitionAnimator.h"
#import "SwipeTransitionInteractionController.h"



@implementation SwipeTransitioning


//present
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    return [[SwipeTransitionAnimator alloc]initWithTargetEdge:self.targetEdge];
}

//dismiss 
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    return [[SwipeTransitionAnimator alloc] initWithTargetEdge:self.targetEdge];

}

- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id <UIViewControllerAnimatedTransitioning>)animator{
    if (self.gestureRecognizer) {
        return [[SwipeTransitionInteractionController alloc]initWithGestureRecognizer:self.gestureRecognizer edgeForDragging:self.targetEdge];
    }
    return nil;
}

- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator{
    if (self.gestureRecognizer) {
        return [[SwipeTransitionInteractionController alloc]initWithGestureRecognizer:self.gestureRecognizer edgeForDragging:self.targetEdge];
    }
    return nil;
}

@end
