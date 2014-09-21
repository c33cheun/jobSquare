//
//  JSProfileViewController.m
//  jobSquare
//
//  Created by iseki on 2014/09/21.
//  Copyright (c) 2014年 Givery. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSProfileViewController.h"

@interface JSProfileViewController ()
@end

@implementation JSProfileViewController

- (void)loadView{
	[super loadView];
}

- (void)viewDidLoad {
	[super viewDidLoad];
	UIButton *login = [[UIButton alloc]initWithFrame:CGRectMake(100, 500, 100, 50)];
	[self.view setBackgroundColor:[UIColor whiteColor]];
	[login setBackgroundColor:[UIColor blueColor]];
	[login addTarget:self action:@selector(loginUserClick) forControlEvents:UIControlEventAllTouchEvents];
	[self.view addSubview:login];
	
	UIButton *logout = [[UIButton alloc]initWithFrame:CGRectMake(100, 200, 100, 50)];
	[self.view setBackgroundColor:[UIColor whiteColor]];
	[logout setBackgroundColor:[UIColor redColor]];
	[logout addTarget:self action:@selector(logoutUserClick) forControlEvents:UIControlEventAllTouchEvents];
	[self.view addSubview:logout];
	
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

@end