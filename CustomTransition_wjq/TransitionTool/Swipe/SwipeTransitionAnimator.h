//
//  SwipeTransitionAnimator.h
//  CustomTransition_wjq
//
//  Created by landixing on 2017/3/16.
//  Copyright © 2017年 landixing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface SwipeTransitionAnimator : NSObject<UIViewControllerAnimatedTransitioning>

- (instancetype)initWithTargetEdge:(UIRectEdge)targetEdge;

@property (readwrite, nonatomic) UIRectEdge targetEdge;

@end
