//
//  CustomPresentation.m
//  CustomTransition_wjq
//
//  Created by landixing on 2017/3/13.
//  Copyright © 2017年 landixing. All rights reserved.
//

#import "CustomPresentation.h"

#define CORNER_RADIUS   5.f

@interface CustomPresentation ()<UIViewControllerAnimatedTransitioning>{

    CATransform3D transf3d;
    
    CATransform3D transf3D;
}

@property (nonatomic, strong) UIView *dimmingView; //阴影蒙版
@property (nonatomic, strong) UIView *presentationWrappingView;

@end

@implementation CustomPresentation

//| ------------------------------第一步内容----------------------------------------------
#pragma mark - 重写UIPresentationController个别方法
- (instancetype)initWithPresentedViewController:(UIViewController *)presentedViewController presentingViewController:(UIViewController *)presentingViewController{
    self = [super initWithPresentedViewController:presentedViewController presentingViewController:presentingViewController];
    if (self) {
        // 必须设置 presentedViewController 的 modalPresentationStyle
        // 在自定义动画效果的情况下，苹果强烈建议设置为 UIModalPresentationCustom
        presentedViewController.modalPresentationStyle = UIModalPresentationCustom;
    }
    return  self;
}

- (UIView *)presentedView{
    return self.presentationWrappingView;

}
// 呈现过渡即将开始的时候被调用的
// 可以在此方法创建和设置自定义动画所需的view
- (void)presentationTransitionWillBegin{
    
    UIView *presentedViewControllerView = [super presentedView];
    {
        /**/
        UIView *presentationWrapperView = [[UIView alloc] initWithFrame:self.frameOfPresentedViewInContainerView];
        presentationWrapperView.backgroundColor = [UIColor greenColor];
        presentationWrapperView.layer.shadowOpacity = 0.44f;
        presentationWrapperView.layer.shadowRadius = 5.f;
        presentationWrapperView.layer.shadowOffset = CGSizeMake(0, -6.f);
        self.presentationWrappingView = presentationWrapperView;
        
        /**/
        UIView *presentationRoundedCornerView = [[UIView alloc] initWithFrame:UIEdgeInsetsInsetRect(presentationWrapperView.bounds, UIEdgeInsetsMake(0, 0, -CORNER_RADIUS, 0))];
        presentationRoundedCornerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        presentationRoundedCornerView.layer.cornerRadius = CORNER_RADIUS;
        presentationRoundedCornerView.layer.masksToBounds = YES;
        /* */
        UIView *presentedViewControllerWrapperView = [[UIView alloc] initWithFrame:UIEdgeInsetsInsetRect(presentationRoundedCornerView.bounds, UIEdgeInsetsMake(0, 0, CORNER_RADIUS, 0))];
        presentedViewControllerWrapperView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        // Add presentedViewControllerView -> presentedViewControllerWrapperView.
        presentedViewControllerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        presentedViewControllerView.frame = presentedViewControllerWrapperView.bounds;
        
        [presentedViewControllerWrapperView addSubview:presentedViewControllerView];
        
        // Add presentedViewControllerWrapperView -> presentationRoundedCornerView.
        [presentationRoundedCornerView addSubview:presentedViewControllerWrapperView];
        
        // Add presentationRoundedCornerView -> presentationWrapperView.
        [presentationWrapperView addSubview:presentationRoundedCornerView];
    }
    
    {
        //背景遮罩设置
        UIView * dimmingView = [[UIView alloc]initWithFrame:self.containerView.bounds];
        dimmingView.backgroundColor = [UIColor blackColor];
        dimmingView.opaque = NO; //是否透明
        dimmingView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
        //添加手势
        [dimmingView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapdimmingView:)]];
        self.dimmingView = dimmingView;
        [self.containerView addSubview:dimmingView]; //添加到动画容器中
        
        //转场协调器(Transition Coordinators) 可以在运行转场动画时，并行的运行其他动画。 转场协调器遵从 UIViewControllerTransitionCoordinator 协议。
        id<UIViewControllerTransitionCoordinator> transitionCoordinator = self.presentingViewController.transitionCoordinator;
        
        //蒙版的动画设置
        self.dimmingView.alpha = 0.0f;
        [transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
            self.dimmingView.alpha = 0.5f;
        } completion:NULL];
        
    }
}

#pragma mark 点击手势事件
- (void)tapdimmingView:(UITapGestureRecognizer *)tap{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

// 在呈现过渡结束时被调用的，并且该方法提供一个布尔变量来判断过渡效果是否完成
- (void)presentationTransitionDidEnd:(BOOL)completed{
    if (completed == NO) {
        self.dimmingView = nil;
        self.presentationWrappingView = nil;
    }
    
}

//消失过渡即将开始的时候调用
- (void)dismissalTransitionWillBegin{
    
    id<UIViewControllerTransitionCoordinator> transitionCoordinator = self.presentingViewController.transitionCoordinator;

    [transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        self.dimmingView.alpha = 0.f;
    } completion:NULL];
}

// 消失过渡完成之后调用，此时应该将视图移除，防止强引用
- (void)dismissalTransitionDidEnd:(BOOL)completed{
    if (completed == YES) {
        self.presentationWrappingView = nil;
        self.dimmingView = nil;
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
        return ((UIViewController *)container).preferredContentSize;
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
    presentedViewControllerFrame.size.height = presentedViewContentSize.height;
    presentedViewControllerFrame.origin.y = CGRectGetMaxY(containerViewBounds) - presentedViewContentSize.height;
    return presentedViewControllerFrame;

}

- (void)containerViewWillLayoutSubviews{
    [super containerViewWillLayoutSubviews];
    self.dimmingView.frame = self.containerView.bounds;
    self.presentationWrappingView.frame = self.frameOfPresentedViewInContainerView;
}

//| ------------------------------第二步内容----------------------------------------------

#pragma mark -- 动画控制器 (Animation Controllers) 遵从 UIViewControllerAnimatedTransitioning 协议，并且负责实际执行动画。
#pragma mark -- 动画执行时间
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext{

    return [transitionContext isAnimated] ? 0.5 : 0 ;
}

// 核心，动画效果的实现
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{

    //起始ViewController
    self.fromViewControll = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    //目标ViewControll
    self.toViewControll = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];

     self.fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
     self.toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    
    
    //判断是否present or dismiss
    BOOL isPresenting = (self.fromViewControll == self.presentingViewController);
    
    //fromView最初的Frame / 加载完成后的Frame(fromView)
    CGRect __unused fromViewInitialFrame = [transitionContext initialFrameForViewController:_fromViewControll];
    CGRect fromViewFinalFrame = [transitionContext finalFrameForViewController:_fromViewControll];

    /*toView最初的Frame / 加载完成后的Frame*/
    CGRect toViewInitialFrame = [transitionContext initialFrameForViewController:_toViewControll];
    CGRect toViewFinalFrame = [transitionContext finalFrameForViewController:_toViewControll];

    //容器视图
    UIView *containerView = [transitionContext containerView];

    [containerView addSubview:_toView]; //添加到上下文
    
    NSTimeInterval transitionDuration = [self transitionDuration:transitionContext];

    if (isPresenting) {
        toViewInitialFrame.origin = CGPointMake(CGRectGetMinX(containerView.bounds), CGRectGetMaxY(containerView.bounds));
        toViewInitialFrame.size = toViewFinalFrame.size;
        _toView.frame  = toViewFinalFrame;
    } else {
        fromViewFinalFrame = CGRectOffset(_fromView.frame, 0, CGRectGetHeight(_fromView.frame));
    }
    
    [UIView animateWithDuration:transitionDuration animations:^{
        
        if (isPresenting) {
            _toView.frame = toViewFinalFrame;
        }else{
            _fromView.frame = fromViewFinalFrame;
        }
        
    } completion:^(BOOL finished) {
        
        // 声明过渡结束时调用 completeTransition: 这个方法
        BOOL wasCanceled = [transitionContext transitionWasCancelled];
        [transitionContext completeTransition:!wasCanceled];
    }];
}

//| ------------------------------第三步内容----------------------------------------------

#pragma mark -
#pragma mark UIViewControllerTransitioningDelegate

- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source{
    NSAssert(self.presentedViewController == presented, @"You didn't initialize %@ with the correct presentedViewController.  Expected %@, got %@.",
             self, presented, self.presentedViewController);
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
