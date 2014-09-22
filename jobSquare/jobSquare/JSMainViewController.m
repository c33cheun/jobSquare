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
    //JobDetailViewController *viewController3;
    
    UINavigationController *navviewController1 , *navviewController2 /*,*navviewController3*/;
    
    [self.tabBar setBarTintColor:[UIColor blackColor]];
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlackTranslucent];
    [self.tabBar setTintColor: [UIColor blackColor]];
    [self.tabBar setSelectedImageTintColor: [UIColor whiteColor]];
    
    profile = [[JSProfileViewController alloc] init];
    //	[profile setTitle:@"This is the second view controller"];
    navviewController1=[[UINavigationController alloc]initWithRootViewController:profile];
    
    map = [[JSMapViewController alloc] init];
    navviewController2=[[UINavigationController alloc]initWithRootViewController:map];
    
//    viewController3 = [[JobDetailViewController alloc] init];
//    viewController3.jobId = @"ExhFAklqBl";
//    navviewController3=[[UINavigationController alloc]initWithRootViewController:viewController3];
    
    self.viewControllers = [NSArray arrayWithObjects: navviewController2, navviewController1, /*navviewController3,*/ nil];
    
    UITabBarItem *mapItem = [[UITabBarItem alloc]init];
    [mapItem setTitle:@""];
    UIImage *mapIcon = [UIImage imageNamed:@"nav_icon_01.png"];
    UIImage *mapIconOn = [UIImage imageNamed:@"nav_icon_01on.png"];
    mapIcon = [mapIcon resizeImage:mapIcon withScale:2.0f];
    mapIconOn = [mapIconOn resizeImage:mapIconOn withScale:2.0f];
    [mapItem setImage:mapIcon];
    [mapItem setSelectedImage:mapIconOn];
    mapItem.imageInsets = UIEdgeInsetsMake(7, 0, -5, 0);
    
    UITabBarItem *accountItem = [[UITabBarItem alloc]init];
    UIImage *accountIcon = [UIImage imageNamed:@"nav_icon_03.png"];
    UIImage *accountIconOn = [UIImage imageNamed:@"nav_icon_03_on.png"];
    accountIcon = [accountIcon resizeImage:accountIcon withScale:2.0f];
    accountIconOn = [accountIconOn resizeImage:accountIconOn withScale:2.0f];
    [accountItem setImage:accountIcon];
    [accountItem setTitle:@""];
    [accountItem setSelectedImage:accountIconOn];
    accountItem.imageInsets = UIEdgeInsetsMake(7, 0, -5, 0);
    
//    UITabBarItem *jobItem = [[UITabBarItem alloc] init];
//    UIImage *jobIcon = [UIImage imageNamed:@"nav_icon_04.png"];
//    UIImage *jobIconOn = [UIImage imageNamed:@"nav_icon_04on.png"];
//    jobIcon = resizeImage(jobIcon);
//    jobIconOn = resizeImage(jobIconOn);
//    [jobItem setImage:jobIcon];
//    [jobItem setTitle:@""];
//    [jobItem setSelectedImage:jobIconOn];
//    jobItem.imageInsets = UIEdgeInsetsMake(7, 0, -5, 0);
    
    [navviewController1 setTabBarItem:accountItem];
    [navviewController2 setTabBarItem:mapItem];
    //[navviewController3 setTabBarItem:jobItem];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle) preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
         

@end
