//
//  SlideTransitionInteractionController.h
//  CustomTransition_wjq
//
//  Created by landixing on 2017/3/17.
//  Copyright © 2017年 landixing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SlideTransitionInteractionController : UIPercentDrivenInteractiveTransition


- (instancetype)initWithGestureRecognizer:(UIPanGestureRecognizer *)gestureRecognizer NS_DESIGNATED_INITIALIZER;

- (instancetype)init NS_UNAVAILABLE;

@end
