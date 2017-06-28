//
//  Swipe_First_VC.m
//  CustomTransition_wjq
//
//  Created by landixing on 2017/3/16.
//  Copyright © 2017年 landixing. All rights reserved.
//

#import "Swipe_First_VC.h"
#import "SwipeTransitioning.h"



#import "Swipe_Second_VC.h"


@interface Swipe_First_VC ()

@property (strong , nonatomic) SwipeTransitioning * transitioning;

@end

@implementation Swipe_First_VC


- (SwipeTransitioning *)transitioning
{
    if (_transitioning == nil)
        _transitioning = [[SwipeTransitioning alloc] init];
    
    return _transitioning;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithDisplayP3Red:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1.0];

    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 100,40)];
    [btn setTitle:@"present" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setBackgroundColor: [UIColor blackColor]];
    
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn];
    
    UIScreenEdgePanGestureRecognizer *interactiveTransitionRecognizer = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(action:)];
    interactiveTransitionRecognizer.edges = UIRectEdgeRight;
    [self.view addGestureRecognizer:interactiveTransitionRecognizer];
    
   
}

- (void)btnClick:(UIButton *)sender{
//
    Swipe_Second_VC *swipe = [[Swipe_Second_VC alloc]init];
    SwipeTransitioning *transitionDelegate = self.transitioning;
    
    transitionDelegate.targetEdge = UIRectEdgeRight;
    swipe.transitioningDelegate = transitionDelegate;
    swipe.modalPresentationStyle = UIModalPresentationCustom;
    [self presentViewController:swipe animated:YES completion:nil];

}

- (void)action:(UIScreenEdgePanGestureRecognizer *)sender{
    Swipe_Second_VC * swipe = [[Swipe_Second_VC alloc]init];
    SwipeTransitioning * transitioning = self.transitioning;

    if ([sender isKindOfClass:UIGestureRecognizer.class])
        transitioning.gestureRecognizer = sender;
    else
        transitioning.gestureRecognizer = nil;

    transitioning.targetEdge = UIRectEdgeRight;
    swipe.transitioningDelegate = transitioning;
    swipe.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:swipe animated:YES completion:nil];

}



























@end
