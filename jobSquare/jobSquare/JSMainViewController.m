//
//  JSMainViewController.m
//  jobSquare
//
//  Created by Geoffrey Heath on 2014-09-22.
//  Copyright (c) 2014 Givery. All rights reserved.
//

#import "JSMainViewController.h"

@interface JSMainViewController ()

@end

@implementation JSMainViewController

- (id) init {
    self = [super init];
    if (self){
        [self setup];
    }
    return self;
}

-(void) setup{
    JSMapViewController *map;
    JSProfileViewController *profile;
    JobDetailViewController *viewController3;
    
    UINavigationController *navviewController1 , *navviewController2, *navviewController3;
    
    [self.tabBar setBarTintColor: [UIColor blackColor]];
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlackTranslucent];
    [self.tabBar setTintColor: [UIColor blackColor]];
    
    profile = [[JSProfileViewController alloc] init];
    //	[profile setTitle:@"This is the second view controller"];
    navviewController1=[[UINavigationController alloc]initWithRootViewController:profile];
    
    map = [[JSMapViewController alloc] init];
    navviewController2=[[UINavigationController alloc]initWithRootViewController:map];
    
    viewController3 = [[JobDetailViewController alloc] init];
    viewController3.jobId = @"ExhFAklqBl";
    navviewController3=[[UINavigationController alloc]initWithRootViewController:viewController3];
    
    self.viewControllers = [NSArray arrayWithObjects: navviewController2, navviewController1, navviewController3, nil];
    
    UITabBarItem *mapItem = [[UITabBarItem alloc]init];
    [mapItem setTitle:@"Map"];
    //[mapItem setImage:@""];
    
    UITabBarItem *accountItem = [[UITabBarItem alloc]init];
    //[accountItem setImage:@""];
    [accountItem setTitle:@"Account"];
    
    UITabBarItem *jobItem = [[UITabBarItem alloc] init];
    [jobItem setTitle:@"Jobs"];
    
    [navviewController1 setTabBarItem:accountItem];
    [navviewController2 setTabBarItem:mapItem];
    [navviewController3 setTabBarItem:jobItem];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
