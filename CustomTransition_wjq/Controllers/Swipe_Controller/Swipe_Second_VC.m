//
//  Swipe_Second_VC.m
//  CustomTransition_wjq
//
//  Created by landixing on 2017/3/16.
//  Copyright © 2017年 landixing. All rights reserved.
//

#import "Swipe_Second_VC.h"
#import "SwipeTransitioning.h"



@interface Swipe_Second_VC ()<UIViewControllerTransitioningDelegate>

@end

@implementation Swipe_Second_VC


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithDisplayP3Red:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1.0];

    UIScreenEdgePanGestureRecognizer * recognizer = [[UIScreenEdgePanGestureRecognizer alloc]initWithTarget:self action:@selector(action:)];
    recognizer.edges = UIRectEdgeLeft;
    [self.view addGestureRecognizer:recognizer];

    
}

- (void)action:(UIScreenEdgePanGestureRecognizer *)recognizer
{
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        if ([self.transitioningDelegate isKindOfClass:SwipeTransitioning.class])
        {
            SwipeTransitioning *transitionDelegate = self.transitioningDelegate;
           
            if ([recognizer isKindOfClass:UIGestureRecognizer.class])
                
                transitionDelegate.gestureRecognizer = recognizer;
            
            else
                transitionDelegate.gestureRecognizer = nil;
            
               transitionDelegate.targetEdge = UIRectEdgeLeft;
           
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
