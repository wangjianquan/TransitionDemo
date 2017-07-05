//
//  AdaptiveAnimator.m
//  CustomTransition_wjq
//
//  Created by landixing on 2017/7/5.
//  Copyright © 2017年 landixing. All rights reserved.
//

#import "AdaptiveAnimator.h"

@interface AdaptiveAnimator () <UIViewControllerAnimatedTransitioning>

@property (strong , nonatomic) UIView * presentationWrappingView;
@property (strong , nonatomic) UIButton * dismissBtn;

@end

@implementation AdaptiveAnimator

- (instancetype)initWithPresentedViewController:(UIViewController *)presentedViewController presentingViewController:(UIViewController *)presentingViewController{

    self = [super initWithPresentedViewController:presentedViewController presentingViewController:presentingViewController];
    if (self) {
        presentedViewController.modalPresentationStyle = UIModalPresentationCustom;
    }
    return  self;
}

- (UIView *)presentedView{
    return  self.presentationWrappingView;
}

- (void)presentationTransitionWillBegin{

   UIView * presentedViewControllerView = [super presentedView];
    {
    
        UIView *presentationWrapperView = [[UIView alloc] initWithFrame:CGRectZero];
        presentationWrapperView.backgroundColor = [UIColor redColor];
        presentationWrapperView.layer.shadowOpacity = 0.63f;
        presentationWrapperView.layer.shadowRadius = 17.f;
        self.presentationWrappingView = presentationWrapperView;
        
       
        presentedViewControllerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        //presentedViewControllerView.layer.borderColor = [UIColor grayColor].CGColor;
//        presentedViewControllerView.layer.borderWidth = 2.f;
        [presentationWrapperView addSubview:presentedViewControllerView];
        
        UIButton *dismissButton = [UIButton buttonWithType:UIButtonTypeCustom];
        dismissButton.frame = CGRectMake(0, 0, 26.f, 26.f);
        [dismissButton setImage:[UIImage imageNamed:@"CloseButton"] forState:UIControlStateNormal];
        [dismissButton addTarget:self action:@selector(dismissButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        self.dismissBtn = dismissButton;
        [presentationWrapperView addSubview:dismissButton];
        
    }
    
}

- (void)dismissButtonTapped:(UIButton *)sender{
[self.presentingViewController dismissViewControllerAnimated:YES completion:NULL];
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    
    self.presentationWrappingView.clipsToBounds = YES;
    self.presentationWrappingView.layer.shadowOpacity = 0.f;
    self.presentationWrappingView.layer.shadowRadius = 0.f;
    
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        // Intentionally left blank.
    } completion:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        self.presentationWrappingView.clipsToBounds = NO;
        self.presentationWrappingView.layer.shadowOpacity = 0.63f;
        self.presentationWrappingView.layer.shadowRadius = 17.f;
    }];
}
- (CGSize)sizeForChildContentContainer:(id<UIContentContainer>)container withParentContainerSize:(CGSize)parentSize
{
    if (container == self.presentedViewController)
        return CGSizeMake(parentSize.width/2, parentSize.height/2);
    else
        return [super sizeForChildContentContainer:container withParentContainerSize:parentSize];
}

- (CGRect)frameOfPresentedViewInContainerView
{
    CGRect containerViewBounds = self.containerView.bounds;
    CGSize presentedViewContentSize = [self sizeForChildContentContainer:self.presentedViewController withParentContainerSize:containerViewBounds.size];
    
    
    CGRect frame = CGRectMake(CGRectGetMidX(containerViewBounds) - presentedViewContentSize.width/2,
                              CGRectGetMidY(containerViewBounds) - presentedViewContentSize.height/2,
                              presentedViewContentSize.width, presentedViewContentSize.height);
    
    
    return CGRectInset(frame, -20, -20);
}

- (void)containerViewWillLayoutSubviews
{
    [super containerViewWillLayoutSubviews];
    
    self.presentationWrappingView.frame = self.frameOfPresentedViewInContainerView;
    
   
    self.presentedViewController.view.frame = CGRectInset(self.presentationWrappingView.bounds, 20, 20);
    
    
    self.dismissBtn.center = CGPointMake(CGRectGetMinX(self.presentedViewController.view.frame),
                                            CGRectGetMinY(self.presentedViewController.view.frame));
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return [transitionContext isAnimated] ? 0.35 : 0;
}


//| ----------------------------------------------------------------------------
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *containerView = transitionContext.containerView;
    

    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    
    BOOL isPresenting = (fromViewController == self.presentingViewController);
    

    [containerView addSubview:toView];
    
    if (isPresenting) {
        toView.alpha = 0.f;
        
        
        fromView.frame = [transitionContext finalFrameForViewController:fromViewController];
        toView.frame = [transitionContext finalFrameForViewController:toViewController];
    } else {
       
        toView.frame = [transitionContext finalFrameForViewController:toViewController];
    }
    
    NSTimeInterval transitionDuration = [self transitionDuration:transitionContext];
    
    [UIView animateWithDuration:transitionDuration animations:^{
        if (isPresenting)
            toView.alpha = 1.f;
        else
            fromView.alpha = 0.f;
        
    } completion:^(BOOL finished) {
        
        BOOL wasCancelled = [transitionContext transitionWasCancelled];
        [transitionContext completeTransition:!wasCancelled];
        
        
        if (isPresenting == NO)
            fromView.alpha = 1.f;
    }];
}

#pragma mark -
#pragma mark UIViewControllerTransitioningDelegate

- (UIPresentationController*)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source
{
    NSAssert(self.presentedViewController == presented, @"You didn't initialize %@ with the correct presentedViewController.  Expected %@, got %@.",
             self, presented, self.presentedViewController);
    
    return self;
}



- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return self;
}


- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return self;
}

@end
