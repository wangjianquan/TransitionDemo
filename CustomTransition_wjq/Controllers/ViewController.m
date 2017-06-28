//
//  ViewController.m
//  CustomTransition_wjq
//
//  Created by landixing on 2017/3/14.
//  Copyright © 2017年 landixing. All rights reserved.
//

#import "ViewController.h"
#import "CustomPresentationFirstVC.h"
#import "CustomPresent_sideFirstVC.h"
#import "DissolveFirstVC.h"
#import "Swipe_First_VC.h"



@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong , nonatomic) UITableView * tableView;
@property (strong , nonatomic) NSMutableArray * dataSouce;
@end

@implementation ViewController

- (NSMutableArray *)dataSouce{
    if (!_dataSouce) {
        _dataSouce = [NSMutableArray array];
    }
    return _dataSouce;
}
- (UITableView *)tableView{
    
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view
                      .bounds];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"SecondViewController";
    
    self.view.backgroundColor = [UIColor redColor];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];

    self.dataSouce = [NSMutableArray arrayWithObjects:@"custompresent_Botom",@"custompresent_right", @"Dissolve",@"Swipe",nil];
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSouce.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = _dataSouce[indexPath.row];
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    switch (indexPath.row) {
        case 0:
        {
            CustomPresentationFirstVC * first = [[CustomPresentationFirstVC alloc]init];
            [self.navigationController pushViewController:first animated:YES];
        }
            break;
            
        case 1:
        {
            CustomPresent_sideFirstVC * first = [[CustomPresent_sideFirstVC alloc]init];
            [self.navigationController pushViewController:first animated:YES];
        }
            break;

        case 2:
        {
            DissolveFirstVC * dissolve = [[DissolveFirstVC alloc]init];
            [self.navigationController pushViewController:dissolve animated:YES];

        }
            break;
        case 3:
        {
            Swipe_First_VC * swipe = [[Swipe_First_VC alloc]init];
            [self.navigationController pushViewController:swipe animated:YES];
        }
            break;
        default:
            break;
    }
}



































@end
