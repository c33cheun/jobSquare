//
//  ViewController.m
//  jobSquare
//
//  Created by Geoffrey Heath on 2014-09-20.
//  Copyright (c) 2014 Givery. All rights reserved.
//

#import "JSLoginViewController.h"
#import "JSMyLogInViewController.h"
#import "JSMySignUpViewController.h"
#import "JSProfileViewController.h"
#import <Parse/PFUser.h>

@interface JSLoginViewController ()

@end

@implementation JSLoginViewController

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

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	
	// Check if user is logged in

	if (![PFUser currentUser]) {
		// Customize the Log In View Controller
		JSMyLogInViewController *logInViewController = [[JSMyLogInViewController alloc] init];
		logInViewController.delegate = self;
		logInViewController.facebookPermissions = @[@"friends_about_me"];
		
		logInViewController.fields = PFLogInFieldsUsernameAndPassword | PFLogInFieldsTwitter | PFLogInFieldsFacebook | PFLogInFieldsSignUpButton | PFLogInFieldsDismissButton;
		
		// Customize the Sign Up View Controller
		JSMySignUpViewController *signUpViewController = [[JSMySignUpViewController alloc] init];
		signUpViewController.delegate = self;
		signUpViewController.fields = PFSignUpFieldsDefault | PFSignUpFieldsAdditional;
		logInViewController.signUpController = signUpViewController;
		
		// Present Log In View Controller
		[self presentViewController:logInViewController animated:YES completion:NULL];
	}
}

// Sent to the delegate when a PFUser is signed up.
- (void)signUpViewController:(PFSignUpViewController *)signUpController didSignUpUser:(PFUser *)user {
	[self dismissViewControllerAnimated:YES completion:NULL];
}

// Sent to the delegate when a PFUser is logged in.
- (void)logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user {
	[self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

- (IBAction)logoutUserClick {
	[PFUser logOut];
	[self viewDidAppear:true];
}

- (IBAction)loginUserClick {
	JSMapViewController *map;
	JSProfileViewController *profile;
	UINavigationController *navviewController1 , *navviewController2;
	
	profile = [[JSProfileViewController alloc] init];
	[profile setTitle:@"This is the second view controller"];
	navviewController1=[[UINavigationController alloc]initWithRootViewController:profile];
	
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
