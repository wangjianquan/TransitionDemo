//
//  AdaptiveSecondControl.m
//  CustomTransition_wjq
//
//  Created by landixing on 2017/7/5.
//  Copyright © 2017年 landixing. All rights reserved.
//

#import "AdaptiveSecondControl.h"
#import "AdaptiveAnimator.h"


@interface AdaptiveSecondControl () <UIAdaptivePresentationControllerDelegate>


@end

@implementation AdaptiveSecondControl

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
    
    UIBarButtonItem *dismissButton = [[UIBarButtonItem alloc] initWithTitle:@"Dismiss" style:UIBarButtonItemStylePlain target:self action:@selector(dismissButtonAction:)];
    self.navigationItem.leftBarButtonItem = dismissButton;
}

- (void)dismissButtonAction:(UIBarButtonItem * )sender{

    [self dismissViewControllerAnimated:YES completion:nil];


}
- (void)setTransitioningDelegate:(id<UIViewControllerTransitioningDelegate>)transitioningDelegate
{
    [super setTransitioningDelegate:transitioningDelegate];
    
    
    self.presentationController.delegate = self;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller
{
    
    return UIModalPresentationFullScreen;
}

- (UIViewController*)presentationController:(UIPresentationController *)controller viewControllerForAdaptivePresentationStyle:(UIModalPresentationStyle)style
{
    return [[UINavigationController alloc] initWithRootViewController:controller.presentedViewController];
}


@end
