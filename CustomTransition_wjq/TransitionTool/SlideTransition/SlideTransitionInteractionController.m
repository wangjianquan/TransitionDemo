//
//  SlideTransitionInteractionController.m
//  CustomTransition_wjq
//
//  Created by landixing on 2017/3/17.
//  Copyright © 2017年 landixing. All rights reserved.
//

#import "SlideTransitionInteractionController.h"

@interface SlideTransitionInteractionController ()
@property (nonatomic, weak) id<UIViewControllerContextTransitioning> transitionContext;
@property (nonatomic, strong, readonly) UIPanGestureRecognizer *gestureRecognizer;
@property (nonatomic, readwrite) CGPoint initialLocationInContainerView;
@property (nonatomic, readwrite) CGPoint initialTranslationInContainerView;

@end

@implementation SlideTransitionInteractionController

- (instancetype)initWithGestureRecognizer:(UIPanGestureRecognizer *)gestureRecognizer{
    self = [super init];
    if (self) {
        _gestureRecognizer = gestureRecognizer;
        [_gestureRecognizer addTarget:self action:@selector(gestureRecognizeDidUpdate:)];
    }
    return self;
}

//抛异常
- (instancetype)init{
    @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"Use -> initWithGestureRecognizer:" userInfo:nil];
}

- (void)dealloc{
    [_gestureRecognizer removeTarget:self action:@selector(gestureRecognizeDidUpdate:)];
    

}

- (void)startInteractiveTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    //保存transitionContext,初始位置,容器视图。
    self.transitionContext = transitionContext;
    self.initialLocationInContainerView = [self.gestureRecognizer locationInView:transitionContext.containerView];
    self.initialTranslationInContainerView = [self.gestureRecognizer translationInView:transitionContext.containerView];
    [super startInteractiveTransition:transitionContext];
    
}


- (CGFloat)percentForGesture:(UIPanGestureRecognizer *)gesture{

    UIView * transitionContainerView = self.transitionContext.containerView;
    
    CGPoint  transitionInContainerView = [gesture translationInView:transitionContainerView];
    
    if ((transitionInContainerView.x > 0.f && self.initialTranslationInContainerView.x < 0.f)||(transitionInContainerView.x < 0.f && self.initialTranslationInContainerView.x >0.f)) {
        return -1.f;
    }
    //fabs : 处理double类型的取绝对值
    return fabs(transitionInContainerView.x)/CGRectGetWidth(transitionContainerView.bounds);
}


- (void)gestureRecognizeDidUpdate:(UIScreenEdgePanGestureRecognizer *)gestureRecognizer
{
    switch (gestureRecognizer.state) {
        case UIGestureRecognizerStateBegan:
            // The Began state is handled by AAPLSlideTransitionDelegate.  In
            // response to the gesture recognizer transitioning to this state,
            // it will trigger the transition.
            break;
        case UIGestureRecognizerStateChanged:
            // -percentForGesture returns -1.f if the current position of the
            // touch along the horizontal axis has crossed over the initial
            // position.  See the comment in the
            // -beginInteractiveTransitionIfPossible: method of
            // AAPLSlideTransitionDelegate for details.
            if ([self percentForGesture:gestureRecognizer] < 0.f) {
                [self cancelInteractiveTransition];
                // Need to remove our action from the gesture recognizer to
                // ensure it will not be called again before deallocation.
                [self.gestureRecognizer removeTarget:self action:@selector(gestureRecognizeDidUpdate:)];
            } else {
                // We have been dragging! Update the transition context
                // accordingly.
                [self updateInteractiveTransition:[self percentForGesture:gestureRecognizer]];
            }
            break;
        case UIGestureRecognizerStateEnded:
            // Dragging has finished.
            // Complete or cancel, depending on how far we've dragged.
            if ([self percentForGesture:gestureRecognizer] >= 0.4f)
                [self finishInteractiveTransition];
            else
                [self cancelInteractiveTransition];
            break;
        default:
            // Something happened. cancel the transition.
            [self cancelInteractiveTransition];
            break;
    }
}









@end
