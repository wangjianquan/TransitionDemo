//
//  SwipeTransitioning.h
//  CustomTransition_wjq
//
//  Created by landixing on 2017/3/16.
//  Copyright © 2017年 landixing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface SwipeTransitioning : NSObject<UIViewControllerTransitioningDelegate>


@property (nonatomic, strong) UIScreenEdgePanGestureRecognizer *gestureRecognizer;

@property (nonatomic, readwrite) UIRectEdge targetEdge;



@end
