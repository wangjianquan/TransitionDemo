//
//  SwipeTransitionInteractionController.m
//  CustomTransition_wjq
//
//  Created by landixing on 2017/3/16.
//  Copyright © 2017年 landixing. All rights reserved.
//

#import "SwipeTransitionInteractionController.h"

@interface SwipeTransitionInteractionController ()

//上下文
@property (weak, nonatomic) id<UIViewControllerContextTransitioning> transitionContext;

//
@property (strong , readonly,nonatomic) UIScreenEdgePanGestureRecognizer * gestureRecognizer;


@property (readonly , nonatomic) UIRectEdge edge;

@end

@implementation SwipeTransitionInteractionController


//| ----------------------------------------------------------------------------
- (instancetype)initWithGestureRecognizer:(UIScreenEdgePanGestureRecognizer *)gestureRecognizer edgeForDragging:(UIRectEdge)edge
{
    NSAssert(edge == UIRectEdgeTop || edge == UIRectEdgeBottom ||
             edge == UIRectEdgeLeft || edge == UIRectEdgeRight,
             @"edgeForDragging must be one of UIRectEdgeTop, UIRectEdgeBottom, UIRectEdgeLeft, or UIRectEdgeRight.");
    
    self = [super init];
    if (self)
    {
        _gestureRecognizer = gestureRecognizer;
        _edge = edge;
        
        [_gestureRecognizer addTarget:self action:@selector(gestureRecognizerDidUpdate:)];
    }
    return self;
}

- (instancetype)init{
    //抛异常函数
    @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"Use -initWithGestureRecognizer:edgeForDragging:" userInfo:nil];
}

- (void)dealloc
{
    [self.gestureRecognizer removeTarget:self action:@selector(gestureRecognizerDidUpdate:)];
}


//| ----------------------------------------------------------------------------
- (void)startInteractiveTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    // Save the transitionContext for later.
    self.transitionContext = transitionContext;
    
    [super startInteractiveTransition:transitionContext];
}

//计算滑动比例
- (CGFloat)percentForGesture:(UIScreenEdgePanGestureRecognizer *)gesture{
    
    UIView *transitionContainerView = self.transitionContext.containerView;
    
    CGPoint locationInSourceView = [gesture locationInView:transitionContainerView];
    
    
    CGFloat width = CGRectGetWidth(transitionContainerView.bounds);
    CGFloat height = CGRectGetHeight(transitionContainerView.bounds);
    
    //计算比例
    if (self.edge == UIRectEdgeRight)
        
        return (width - locationInSourceView.x) / width;
    
    else if (self.edge == UIRectEdgeLeft)
        
        return locationInSourceView.x / width;
    
    else if (self.edge == UIRectEdgeBottom)
        
        return (height - locationInSourceView.y) / height;
    
    else if (self.edge == UIRectEdgeTop)
        return locationInSourceView.y / height;
    else
        return 0.f;
    
}

// 手势状态
- (void)gestureRecognizerDidUpdate:(UIScreenEdgePanGestureRecognizer * )gestureRecoginzer
{

    switch (gestureRecoginzer.state) {
        case UIGestureRecognizerStateBegan:
            
            break;
        case UIGestureRecognizerStateChanged:
        {
        
            [self updateInteractiveTransition:[self percentForGesture:gestureRecoginzer]];
        }
            break;
        case UIGestureRecognizerStateEnded:
            
        {
            if ([self percentForGesture:gestureRecoginzer] >= 0.5f) {
                [self finishInteractiveTransition];
            } else {
                [self cancelInteractiveTransition];
            }
        
        }
            break;
            
        default:
            [self cancelInteractiveTransition];
            break;
    }
    

}

















@end
