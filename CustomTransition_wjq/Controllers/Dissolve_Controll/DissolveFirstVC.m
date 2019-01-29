//
//  DissolveFirstVC.m
//  CustomTransition_wjq
//
//  Created by landixing on 2017/3/14.
//  Copyright © 2017年 landixing. All rights reserved.
//

#import "DissolveFirstVC.h"
#import "DissolveSecondVC.h"
#import "DissolveTransitionAnimator.h"


@interface DissolveFirstVC ()<UIViewControllerTransitioningDelegate>

@end

@implementation DissolveFirstVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Dissolve";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(rightBarButtonItemClick)];
    self.view.backgroundColor = [UIColor colorWithDisplayP3Red:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1.0];

}

- (void)rightBarButtonItemClick{
    DissolveSecondVC * seconed = [[DissolveSecondVC alloc]init];
    

    seconed.modalPresentationStyle = UIModalPresentationFullScreen;

    seconed.transitioningDelegate = self;
    
    
    
    [self presentViewController:seconed animated:YES completion:nil];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    return [DissolveTransitionAnimator new];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    return [DissolveTransitionAnimator new];

}


@end
