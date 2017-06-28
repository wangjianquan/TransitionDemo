
//
//  CustomPresent_sideFirstVC.m
//  CustomTransition_wjq
//
//  Created by landixing on 2017/3/15.
//  Copyright © 2017年 landixing. All rights reserved.
//

#import "CustomPresent_sideFirstVC.h"

#import "CustomPresent_sideSecondVC.h"

#import "CustomPresent_side.h"

@interface CustomPresent_sideFirstVC ()

@end

@implementation CustomPresent_sideFirstVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Dissolve";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(rightBarButtonItemClick)];
    self.view.backgroundColor = [UIColor colorWithDisplayP3Red:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1.0];
    
}

- (void)rightBarButtonItemClick{
    CustomPresent_sideSecondVC * seconed = [[CustomPresent_sideSecondVC alloc]init];
    
    CustomPresent_side * present = [[CustomPresent_side alloc]initWithPresentedViewController:seconed presentingViewController:self];
    
    seconed.transitioningDelegate = present;
    
    [self presentViewController:seconed animated:YES completion:nil];
}

@end
