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
        JSMapViewController *map;        
        JSProfileViewController *profile;
        JobDetailViewController *viewController3;
        
        UINavigationController *navviewController1 , *navviewController2, *navviewController3;
        
        //set colors
        [self.tabBar setBarTintColor: [UIColor blackColor]];
        [self.tabBar setTintColor: [UIColor blackColor]];
        [self.tabBar setSelectedImageTintColor: [UIColor whiteColor]];
        
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
        UIImage *mapIcon = [UIImage imageNamed:@"nav_icon_01.png"];
        UIImage *mapIconOn = [UIImage imageNamed:@"nav_icon_01on.png"];
        mapIcon = resizeImage(mapIcon);
        mapIconOn = resizeImage(mapIconOn);
        [mapItem setImage:mapIcon];
        [mapItem setSelectedImage:mapIconOn];
        
        UITabBarItem *accountItem = [[UITabBarItem alloc]init];
        UIImage *accountIcon = [UIImage imageNamed:@"nav_icon_03.png"];
        UIImage *accountIconOn = [UIImage imageNamed:@"nav_icon_03_on.png"];
        accountIcon = resizeImage(accountIcon);
        accountIconOn = resizeImage(accountIconOn);
        [accountItem setImage:accountIcon];
        [accountItem setTitle:@"Account"];
        [accountItem setSelectedImage:accountIconOn];
        
        UITabBarItem *jobItem = [[UITabBarItem alloc] init];
        UIImage *jobIcon = [UIImage imageNamed:@"nav_icon_04.png"];
        UIImage *jobIconOn = [UIImage imageNamed:@"nav_icon_04on.png"];
        jobIcon = resizeImage(jobIcon);
        jobIconOn = resizeImage(jobIconOn);
        [jobItem setImage:jobIcon];
        [jobItem setTitle:@"Jobs"];
        [jobItem setSelectedImage:jobIconOn];
        
        [navviewController1 setTabBarItem:accountItem];
        [navviewController2 setTabBarItem:mapItem];
        [navviewController3 setTabBarItem:jobItem];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

UIImage* resizeImage (UIImage *input) {
    UIImage *scaledImage = [UIImage imageWithCGImage:[input CGImage]
                        scale:(input.scale * 2.0)
                  orientation:(input.imageOrientation)];
    return scaledImage;
}

- (UIStatusBarStyle) preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
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
