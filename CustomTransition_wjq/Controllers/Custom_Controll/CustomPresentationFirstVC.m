//
//  FirstViewController.m
//  CustomTransition_wjq
//
//  Created by landixing on 2017/3/13.
//  Copyright © 2017年 landixing. All rights reserved.
//

#import "CustomPresentationFirstVC.H"
#import "CustomPresentation.h"
#import "CustomPresentationSecondVC.h"

@interface CustomPresentationFirstVC ()

@end

@implementation CustomPresentationFirstVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"FirstViewController";

    self.view.backgroundColor = [UIColor yellowColor];
    
    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 100,40)];
    [btn setTitle:@"present" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setBackgroundColor: [UIColor blackColor]];

    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn];
}


- (void)btnClick:(UIButton *)sender{
    
    CustomPresentationSecondVC * secondControll = [[CustomPresentationSecondVC alloc]init];
    
    CustomPresentation * presentControll = [[CustomPresentation alloc]initWithPresentedViewController:secondControll presentingViewController:self];
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
