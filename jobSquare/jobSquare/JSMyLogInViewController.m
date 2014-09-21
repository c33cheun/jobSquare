//
//  JSMyLogInViewController.m
//  jobSquare
//
//  Created by iseki on 2014/09/20.
//  Copyright (c) 2014年 Givery. All rights reserved.
//

#import "JSMyLogInViewController.h"
#import "JSAssetsConstants.h"

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@interface JSMyLogInViewController ()
@property (nonatomic, strong) UIImageView *fieldsBackground;
@end

@implementation JSMyLogInViewController

@synthesize fieldsBackground;

- (void)viewDidLoad {
	[super viewDidLoad];
	
	[self.logInView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:kMainBackgroundImage]]];
	[self.logInView setLogo:[[UIImageView alloc] initWithImage:[UIImage imageNamed:kLogo]]];
	
	// Set buttons appearance
	[self.logInView.dismissButton setImage:[UIImage imageNamed:kExit] forState:UIControlStateNormal];
	[self.logInView.dismissButton setImage:[UIImage imageNamed:kExitDown] forState:UIControlStateHighlighted];
	
	[self.logInView.facebookButton setImage:nil forState:UIControlStateNormal];
	[self.logInView.facebookButton setImage:nil forState:UIControlStateHighlighted];
	[self.logInView.facebookButton setBackgroundImage:[UIImage imageNamed:kFacebookButtonDown] forState:UIControlStateHighlighted];
	[self.logInView.facebookButton setBackgroundImage:[UIImage imageNamed:kFacebookButton] forState:UIControlStateNormal];
	[self.logInView.facebookButton setTitle:@"" forState:UIControlStateNormal];
	[self.logInView.facebookButton setTitle:@"" forState:UIControlStateHighlighted];
	
	[self.logInView.twitterButton setImage:nil forState:UIControlStateNormal];
	[self.logInView.twitterButton setImage:nil forState:UIControlStateHighlighted];
	[self.logInView.twitterButton setBackgroundImage:[UIImage imageNamed:kTwitterButton] forState:UIControlStateNormal];
	[self.logInView.twitterButton setBackgroundImage:[UIImage imageNamed:kTwitterButtonDown] forState:UIControlStateHighlighted];
	[self.logInView.twitterButton setTitle:@"" forState:UIControlStateNormal];
	[self.logInView.twitterButton setTitle:@"" forState:UIControlStateHighlighted];
	
	[self.logInView.signUpButton setBackgroundImage:[UIImage imageNamed:kSignUpButton] forState:UIControlStateNormal];
	[self.logInView.signUpButton setBackgroundImage:[UIImage imageNamed:kSignUpButtonDown] forState:UIControlStateHighlighted];
	[self.logInView.signUpButton setTitle:@"" forState:UIControlStateNormal];
	[self.logInView.signUpButton setTitle:@"" forState:UIControlStateHighlighted];
	
	// Add login field background
	fieldsBackground = [[UIImageView alloc] initWithImage:[UIImage imageNamed:kLogInBackgroundImage]];
	[self.logInView addSubview:self.fieldsBackground];
	[self.logInView sendSubviewToBack:self.fieldsBackground];
	
	// Remove text shadow
	CALayer *layer = self.logInView.usernameField.layer;
	layer.shadowOpacity = 0.0f;
	layer = self.logInView.passwordField.layer;
	layer.shadowOpacity = 0.0f;
	
	// Set field text color
	[self.logInView.usernameField setTextColor:[UIColor colorWithRed:135.0f/255.0f green:118.0f/255.0f blue:92.0f/255.0f alpha:1.0]];
	[self.logInView.passwordField setTextColor:[UIColor colorWithRed:135.0f/255.0f green:118.0f/255.0f blue:92.0f/255.0f alpha:1.0]];
	
}

- (void)viewDidLayoutSubviews {
	[super viewDidLayoutSubviews];
	
	// Set frame for elements
	[self.logInView.dismissButton setFrame:CGRectMake(10.0f, 10.0f, 87.5f, 45.5f)];
	[self.logInView.logo setFrame:CGRectMake(66.5f, 70.0f, 187.0f, 58.5f)];
	[self.logInView.facebookButton setFrame:CGRectMake(35.0f, 287.0f, 120.0f, 40.0f)];
	[self.logInView.twitterButton setFrame:CGRectMake(35.0f+130.0f, 287.0f, 120.0f, 40.0f)];
	[self.logInView.signUpButton setFrame:CGRectMake(35.0f, 385.0f, 250.0f, 40.0f)];
	[self.logInView.usernameField setFrame:CGRectMake(35.0f, 145.0f, 250.0f, 50.0f)];
	[self.logInView.passwordField setFrame:CGRectMake(35.0f, 195.0f, 250.0f, 50.0f)];
	[self.fieldsBackground setFrame:CGRectMake(35.0f, 145.0f, 250.0f, 100.0f)];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end

