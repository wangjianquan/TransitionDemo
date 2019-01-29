//
//  CustomPresentation.h
//  CustomTransition_wjq
//
//  Created by landixing on 2017/3/13.
//  Copyright © 2017年 WJQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomPresentation : UIPresentationController<UIViewControllerTransitioningDelegate>


@property (strong , nonatomic) UIViewController * fromViewControll;
@property (strong , nonatomic) UIViewController * toViewControll;

@property (strong , nonatomic) UIView * fromView;
@property (strong , nonatomic) UIView * toView;

@end
