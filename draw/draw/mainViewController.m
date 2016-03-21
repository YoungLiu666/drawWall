//
//  mainViewController.m
//  draw
//
//  Created by liuyang on 15/9/9.
//  Copyright (c) 2015年 ly. All rights reserved.
//

#import "mainViewController.h"
#import "GZPDrawController.h"
#import "UIBarButtonItem+LY.h"
@interface mainViewController ()
@property(nonatomic,weak)UIButton * button;
@end

@implementation mainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    self.button = button;
    [button setBackgroundColor:[UIColor redColor]];
    button.frame = CGRectMake(200, 200, 100, 100);
    [self.view addSubview:button];
    [button addTarget:self action:@selector(resetingClick) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"点击进入" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:17];

    
    UIImage *image = [UIImage imageNamed:@"aph"];
    [self.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    [self.navigationBar setShadowImage:image];
}


-(void)resetingClick
{
    GZPDrawController * drawController = [GZPDrawController drawController];
    
    [self pushViewController:drawController animated:YES];
    [self.button removeFromSuperview];
    
}

@end
