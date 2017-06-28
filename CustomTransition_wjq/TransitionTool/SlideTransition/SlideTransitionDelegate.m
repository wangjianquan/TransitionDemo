//
//  SlideTransitionDelegate.m
//  CustomTransition_wjq
//
//  Created by landixing on 2017/3/17.
//  Copyright © 2017年 landixing. All rights reserved.
//

#import "SlideTransitionDelegate.h"

#import "SlideTransitionAnimator.h"
#import "SlideTransitionInteractionController.h"
#import <objc/runtime.h>

const char * SlideTabBarAssociationKey = "SlideTabBarAssociationKey";


@interface SlideTransitionDelegate ()


@end

@implementation SlideTransitionDelegate

- (UIPanGestureRecognizer*)panGestureRecognizer
{
    if (!_panGestureRecongizer){
        _panGestureRecongizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognizerDidPan:)];
    }
    return _panGestureRecongizer;
}

- (void)setTabBarController:(UITabBarController *)tabBarController{

    //移除tabBarController旧的关联
    objc_setAssociatedObject(_tabBarController, SlideTabBarAssociationKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [_tabBarController.view removeGestureRecognizer:self.panGestureRecongizer];
    if (_tabBarController.delegate == self)
        _tabBarController.delegate = nil;
    
        _tabBarController = tabBarController;
    
    _tabBarController.delegate = self;
    [_tabBarController.view addGestureRecognizer:self.panGestureRecongizer];
    
    //将这个对象与新的标签栏控制器。这将确保该对象不会被被收回。
    objc_setAssociatedObject(_tabBarController, SlideTabBarAssociationKey, self, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

}

- (void)panGestureRecognizerDidPan:(UIPanGestureRecognizer*)sender{
    if (self.tabBarController.transitionCoordinator) {
        return;
    }
    if (sender.state == UIGestureRecognizerStateBegan || sender.state == UIGestureRecognizerStateChanged) {
        [self beginInteractiveTransitionIfPossible:sender];
    }

}

- (void)beginInteractiveTransitionIfPossible:(UIPanGestureRecognizer *)sender
{

    //平移点
    CGPoint translation = [sender translationInView:self.tabBarController.view];
    
    if (translation.x > 0.f && self.tabBarController.selectedIndex > 0) {
       
        //平移,过渡到左视图控制器。
        self.tabBarController.selectedIndex-- ;
        
    } else if (translation.x < 0.f && self.tabBarController.selectedIndex + 1 < self.tabBarController.viewControllers.count){

        //平移,过渡到右视图控制器。
        self.tabBarController.selectedIndex++;
    }else{
    
        if (!CGPointEqualToPoint(translation, CGPointZero)) {
            sender.enabled = NO;
            sender.enabled = YES;
        }
    }
    
    [self.tabBarController.transitionCoordinator animateAlongsideTransition:NULL completion:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        if ([context isCancelled] && sender.state == UIGestureRecognizerStateChanged)
            [self beginInteractiveTransitionIfPossible:sender];
    }];

}


//#pragma mark -
//#pragma mark UITabBarControllerDelegate
//
//- (id<UIViewControllerAnimatedTransitioning>)tabBarController:(UITabBarController *)tabBarController animationControllerForTransitionFromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
//    NSAssert(tabBarController == self.tabBarController, @"%@ is not the tab bar controller currently associated with %@", tabBarController, self);
//
//    NSArray * viewControllers = tabBarController.viewControllers;
//    if ([viewControllers indexOfObject:toVC] > [viewControllers indexOfObject:fromVC]) {
//        return [[SlideTransitionAnimator alloc]initWithTargetEdge:UIRectEdgeLeft];
//    } else {
//        return [[SlideTransitionAnimator alloc]initWithTargetEdge:UIRectEdgeRight];
//    }
//
//}
//- (id<UIViewControllerInteractiveTransitioning>)tabBarController:(UITabBarController *)tabBarController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController{
//    NSAssert(tabBarController == self.tabBarController, @"%@ is not the tab bar controller currently associated with %@", tabBarController, self);
//    if (self.panGestureRecongizer.state == UIGestureRecognizerStateChanged || self.panGestureRecongizer.state == UIGestureRecognizerStateBegan) {
//        return [[SlideTransitionInteractionController alloc]initWithGestureRecognizer:self.panGestureRecongizer];
//    }else{
//        return nil;
//    }
//    
//}











@end
