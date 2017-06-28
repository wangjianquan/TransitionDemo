//
//  CustomPresent_side.m
//  CustomTransition_wjq
//
//  Created by landixing on 2017/3/15.
//  Copyright © 2017年 landixing. All rights reserved.
//

#import "CustomPresent_side.h"

#define Duration 0.6


@interface CustomPresent_side ()<UIViewControllerAnimatedTransitioning>
@property (strong , nonatomic) UIView * dismingView;//阴影蒙版

@end

@implementation CustomPresent_side



#pragma mark -- 重写方法

- (instancetype)initWithPresentedViewController:(UIViewController *)presentedViewController presentingViewController:(UIViewController *)presentingViewController{
    
    if (self = [super initWithPresentedViewController:presentedViewController presentingViewController:presentingViewController]) {
        //自定义方法
        presentedViewController.modalPresentationStyle = UIModalPresentationCustom;
        
    }
    return self;
}

//presnt时
- (void)presentationTransitionWillBegin{
    UIView * dismingView = [[UIView alloc]initWithFrame:self.containerView.bounds];
    dismingView.backgroundColor = [UIColor blackColor];
    dismingView.opaque = NO;
    dismingView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    
    //添加手势
    [dismingView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapdismingView:)]];
    self.dismingView = dismingView;
    
    //添加到容器视图
    [self.containerView addSubview:dismingView];
    
    
    //转场调度器: 可以在运行转场动画时并行的执行其他动画,转场调度器遵从UIViewControllerTransitionCoordinator协议
    id<UIViewControllerTransitionCoordinator> transitionCoordinator  = self.presentingViewController.transitionCoordinator;
    
    //蒙版动画
    self.dismingView.alpha = 0.0f;
    [transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        self.dismingView.alpha = 0.5f;
        
    } completion:NULL];
}

- (void)tapdismingView:(UITapGestureRecognizer *)tapGesture{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

//在呈现过渡动画结束时调用,
- (void)presentationTransitionDidEnd:(BOOL)completed
{
    if (completed == NO) {
        self.dismingView = nil;
    }
}

//消失过渡即将开始的时候调用
- (void)dismissalTransitionWillBegin{
    
    id<UIViewControllerTransitionCoordinator> transitionCoordinator = self.presentingViewController.transitionCoordinator;
    [transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        self.dismingView.alpha = 0.0f;
    } completion:NULL];
}

// 消失过渡完成之后调用，此时应该将视图移除，防止强引用
- (void)dismissalTransitionDidEnd:(BOOL)completed{
    if (completed == YES) {
        self.dismingView = nil;
    }
}

#pragma mark -
#pragma mark Layout
//| --------以下四个方法，是按照苹果官方Demo里的，都是为了计算目标控制器View的frame的----------------

- (void)preferredContentSizeDidChangeForChildContentContainer:(id<UIContentContainer>)container{
    [super preferredContentSizeDidChangeForChildContentContainer:container];
    if (container == self.presentedViewController) {
        [self.containerView setNeedsLayout];
    }
}

- (CGSize)sizeForChildContentContainer:(id<UIContentContainer>)container withParentContainerSize:(CGSize)parentSize{
    
    if (container == self.presentedViewController)
        return ((UIViewController * )container).preferredContentSize;
    else
        return [super sizeForChildContentContainer:container withParentContainerSize:parentSize];
}


//在我们的自定义呈现中,被呈现的view并没有完全填充整个屏幕,被呈现的view的过渡动画之后的最终位置,是由UIPresentationViewController来负责的,我们重写该方法来定义这个最终位置
- (CGRect)frameOfPresentedViewInContainerView{
    
    CGRect containerViewBounds = self.containerView.bounds;
    CGSize presentedViewContentSize = [self sizeForChildContentContainer:self.presentedViewController withParentContainerSize:containerViewBounds.size];
    
    // The presented view extends presentedViewContentSize.height points from
    // the bottom edge of the screen.
    CGRect presentedViewControllerFrame = containerViewBounds;
    
    //modal出来的控制器的width 和 x
    presentedViewControllerFrame.size.width = presentedViewContentSize.width;
    presentedViewControllerFrame.origin.x = CGRectGetMaxX(containerViewBounds) - presentedViewContentSize.width;
    return presentedViewControllerFrame;
}

- (void)containerViewWillLayoutSubviews{
    [super containerViewWillLayoutSubviews];
    self.dismingView.frame = self.containerView.frame;
}


//==========================================================//


#pragma mark -- UIViewControllerContextTransitioning
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext{
    return [transitionContext isAnimated] ? Duration : 0;
    
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
    
    //    fromView.frame = [transitionContext finalFrameForViewController:fromViewControll];
    //    toView.frame = [transitionContext finalFrameForViewController:toViewControll];
    
    //容器视图 //添加到上下文
    UIView * containerView = [transitionContext containerView];
    
    //添加到容器视图
    [containerView addSubview:toView];
    
    
    // presented or  dismiss
    BOOL isPresenting = (fromViewControll == self.presentingViewController);
    
    
    //fromView最初的Frame / 加载完成后的Frame(fromView)
    CGRect __unused fromViewInitialFrame = [transitionContext initialFrameForViewController:fromViewControll];
    CGRect fromViewFinalFrame = [transitionContext finalFrameForViewController:fromViewControll];
    
    /*toView最初的Frame / 加载完成后的Frame*/
    CGRect toViewInitialFrame = [transitionContext initialFrameForViewController:toViewControll];
    CGRect toViewFinalFrame = [transitionContext finalFrameForViewController:toViewControll];
    
    
    if (isPresenting) {
        toViewInitialFrame.origin = CGPointMake(CGRectGetMaxX(containerView.bounds), CGRectGetMaxY(containerView.bounds));
        toViewInitialFrame.size = toViewFinalFrame.size;
        toView.frame  = toViewFinalFrame;
    } else {
        //dismiss 时
        fromViewFinalFrame = CGRectOffset(fromView.frame, CGRectGetWidth(fromView.frame), 0);
    }
    
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.0f usingSpringWithDamping:1.0f initialSpringVelocity:0.0f options:UIViewAnimationOptionCurveLinear animations:^{
        if (isPresenting) {
            toView.frame=  toViewFinalFrame;
        } else {
            fromView.frame = fromViewFinalFrame;
        }
        
    } completion:^(BOOL finished) {
        // 声明过渡结束时调用 completeTransition: 这个方法
        BOOL wasCanceled = [transitionContext transitionWasCancelled];
        
        //声明过渡时候调用
        [transitionContext completeTransition:!wasCanceled];
    }];
    
}

#pragma mark -
#pragma mark UIViewControllerTransitioningDelegate

- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source{
    NSAssert(self.presentedViewController == presented, @"You didn't initialize %@ with the correct presentedViewController.  Expected %@, got %@.",self, presented, self.presentedViewController);
    return self;
}

// 返回的对象控制Presented时的动画 (开始动画的具体细节负责类)
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    return self;
}

// 由返回的控制器控制dismissed时的动画 (结束动画的具体细节负责类)
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    return self;
}


















@end
