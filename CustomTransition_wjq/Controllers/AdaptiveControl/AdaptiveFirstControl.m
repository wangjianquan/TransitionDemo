//
//  AdaptiveFirstControl.m
//  CustomTransition_wjq
//
//  Created by landixing on 2017/7/5.
//  Copyright © 2017年 landixing. All rights reserved.
//

#import "AdaptiveFirstControl.h"
#import "AdaptiveSecondControl.h"
#import "AdaptiveAnimator.h"

@interface AdaptiveFirstControl ()

@end

@implementation AdaptiveFirstControl

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"AdaptiveFirstControl";
    
    self.view.backgroundColor = [UIColor yellowColor];
    
    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 100,40)];
    [btn setTitle:@"present" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setBackgroundColor: [UIColor blackColor]];
    
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn];
}


- (void)btnClick:(UIButton *)sender{
    AdaptiveSecondControl * secondControll = [[AdaptiveSecondControl alloc]init];
    
    AdaptiveAnimator * presentControll = [[AdaptiveAnimator alloc]initWithPresentedViewController:secondControll presentingViewController:self];
    secondControll.transitioningDelegate = presentControll;
    
    [self presentViewController:secondControll animated:YES completion:NULL];
    
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
