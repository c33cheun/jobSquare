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
	[self.logInView setLogo:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo_01.png"]]];
    
    [self.logInView.signUpButton setTitle:@"Sign Up" forState:UIControlStateNormal];
    UIColor *background;
    [self.logInView.signUpButton setBackgroundColor:[background colorFromHexString:kBackgroundColor]];
	
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
	[self.logInView.logo setFrame:CGRectMake(66.5f, 40.0f, 187.0f, 187.0f)];
	[self.logInView.facebookButton setFrame:CGRectMake(35.0f, 400.0f, 120.0f, 40.0f)];
	[self.logInView.twitterButton setFrame:CGRectMake(35.0f+130.0f, 400.0f, 120.0f, 40.0f)];
	[self.logInView.signUpButton setFrame:CGRectMake(35.0f, 500.0f, 250.0f, 40.0f)];
	[self.logInView.usernameField setFrame:CGRectMake(35.0f, 245.0f, 250.0f, 50.0f)];
	[self.logInView.passwordField setFrame:CGRectMake(35.0f, 295.0f, 250.0f, 50.0f)];
	[self.fieldsBackground setFrame:CGRectMake(35.0f, 245.0f, 250.0f, 100.0f)];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end

