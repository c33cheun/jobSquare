//
//  ViewController.m
//  jobSquare
//
//  Created by Geoffrey Heath on 2014-09-20.
//  Copyright (c) 2014 Givery. All rights reserved.
//

#import "JSLoginViewController.h"

@interface JSLoginViewController ()

@end

@implementation JSLoginViewController

- (void)loadView{
    [super loadView];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    UIView *firstView = [[UIView alloc]initWithFrame:CGRectMake(50, 50, self.view.frame.size.width, self.view.frame.size.height)];
    UIButton *login = [[UIButton alloc]initWithFrame:CGRectMake(100, 500, 100, 50)];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [login setBackgroundColor:[UIColor blueColor]];
    [login addTarget:self action:@selector(loginUserClick) forControlEvents:UIControlEventAllTouchEvents];
    //[self.view addSubview:firstView];
    [self.view addSubview:login];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginUserClick {
    JSMapViewController *map;
    UIViewController *viewController1;
    UINavigationController *navviewController1 , *navviewController2;
    
    viewController1 = [[UIViewController alloc] init];
    [viewController1 setTitle:@"This is the second view controller"];
    navviewController1=[[UINavigationController alloc]initWithRootViewController:viewController1];
    
    map = [[JSMapViewController alloc] init];
    navviewController2=[[UINavigationController alloc]initWithRootViewController:map];
    
    
    UITabBarController *tab = [[UITabBarController alloc]init];
    tab.viewControllers = [NSArray arrayWithObjects: navviewController2, navviewController1, nil];
    
    UITabBarItem *mapItem = [[UITabBarItem alloc]init];
    [mapItem setTitle:@"Map"];
    //[mapItem setImage:@""];

    UITabBarItem *accountItem = [[UITabBarItem alloc]init];
    //[accountItem setImage:@""];
    [accountItem setTitle:@"Account"];
    
    [navviewController2 setTabBarItem:mapItem];
    [navviewController1 setTabBarItem:accountItem];
    
    //[self.navigationController pushViewController:tab animated:nil];
    [self presentViewController:tab animated:YES completion:nil];
    
}

@end
