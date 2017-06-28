//
//  SwipeTransitionInteractionController.h
//  CustomTransition_wjq
//
//  Created by landixing on 2017/3/16.
//  Copyright © 2017年 landixing. All rights reserved.
//滑动控制器的交互演示。跟踪UIScreenEdgePanGestureRecognizer从指定的屏幕边缘过渡,完成百分比。

#import <UIKit/UIKit.h>

@interface SwipeTransitionInteractionController : UIPercentDrivenInteractiveTransition

- (instancetype)initWithGestureRecognizer:(UIScreenEdgePanGestureRecognizer*)gestureRecognizer edgeForDragging:(UIRectEdge)edge NS_DESIGNATED_INITIALIZER;

- (instancetype)init NS_UNAVAILABLE;




@end
