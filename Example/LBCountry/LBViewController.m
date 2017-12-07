//
//  LBViewController.m
//  LBCountry
//
//  Created by 294842586@qq.com on 12/06/2017.
//  Copyright (c) 2017 294842586@qq.com. All rights reserved.
//

#import "LBViewController.h"
#import "LBCountryVC.h"

@interface LBViewController ()

@end

@implementation LBViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"Find country" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor greenColor]];
    btn.frame = CGRectMake(0, 0, 200, 50);
    btn.center = self.view.center;
    [btn addTarget:self action:@selector(findAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)findAction:(UIButton *)sender {
    LBCountryVC *vc = [LBCountryVC new];
    [self.navigationController pushViewController:vc animated:YES];
    
}

@end
