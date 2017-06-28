//
//  SlideTransitionDelegate.h
//  CustomTransition_wjq
//
//  Created by landixing on 2017/3/17.
//  Copyright © 2017年 landixing. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>


@interface SlideTransitionDelegate : NSObject <UITabBarControllerDelegate>

@property (strong , nonatomic) UITabBarController * tabBarController;

@property (nonatomic, strong) UIPanGestureRecognizer *panGestureRecongizer;

@end
