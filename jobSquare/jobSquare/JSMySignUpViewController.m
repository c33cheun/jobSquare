//
//  JSMySignUpViewController.m
//  jobSquare
//
//  Created by iseki on 2014/09/21.
//  Copyright (c) 2014年 Givery. All rights reserved.
//

#import "JSMySignUpViewController.h"
#import "JSAssetsConstants.h"
#import <QuartzCore/QuartzCore.h>

@interface JSMySignUpViewController ()
@property (nonatomic, strong) UIImageView *fieldsBackground;
@end

@implementation JSMySignUpViewController

@synthesize fieldsBackground;

- (void)viewDidLoad {
	[super viewDidLoad];
	
	[self.signUpView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:kMainBackgroundImage]]];
	[self.signUpView setLogo:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo_01.png"]]];
	
	// Change button apperance
	[self.signUpView.signUpButton setTitle:@"Sign Up" forState:UIControlStateNormal];
	
	// Add background for fields
	[self setFieldsBackground:[[UIImageView alloc] initWithImage:[UIImage imageNamed:kSignUpBackgroundImage]]];
	[self.signUpView insertSubview:fieldsBackground atIndex:1];
	
	// Remove text shadow
	CALayer *layer = self.signUpView.usernameField.layer;
	layer.shadowOpacity = 0.0f;
	layer = self.signUpView.passwordField.layer;
	layer.shadowOpacity = 0.0f;
	layer = self.signUpView.emailField.layer;
	layer.shadowOpacity = 0.0f;
	layer = self.signUpView.additionalField.layer;
	layer.shadowOpacity = 0.0f;
	
	// Set text color
	[self.signUpView.usernameField setTextColor:[UIColor colorWithRed:135.0f/255.0f green:118.0f/255.0f blue:92.0f/255.0f alpha:1.0]];
	[self.signUpView.passwordField setTextColor:[UIColor colorWithRed:135.0f/255.0f green:118.0f/255.0f blue:92.0f/255.0f alpha:1.0]];
	[self.signUpView.emailField setTextColor:[UIColor colorWithRed:135.0f/255.0f green:118.0f/255.0f blue:92.0f/255.0f alpha:1.0]];
	[self.signUpView.additionalField setTextColor:[UIColor colorWithRed:135.0f/255.0f green:118.0f/255.0f blue:92.0f/255.0f alpha:1.0]];
	
	// Change "Additional" to match our use
	[self.signUpView.additionalField setPlaceholder:@"Phone number"];
	
}

- (void)viewDidLayoutSubviews {
	[super viewDidLayoutSubviews];
	
	// Move all fields down on smaller screen sizes
	float yOffset = [UIScreen mainScreen].bounds.size.height <= 480.0f ? 30.0f : 0.0f;
	
	CGRect fieldFrame = self.signUpView.usernameField.frame;
	
	[self.signUpView.dismissButton setFrame:CGRectMake(10.0f, 10.0f, 87.5f, 45.5f)];
	[self.signUpView.logo setFrame:CGRectMake(66.5f, 40.0f, 187.0f, 187.0f)];
	[self.signUpView.signUpButton setFrame:CGRectMake(35.0f, 435.0f, 250.0f, 40.0f)];
	[self.fieldsBackground setFrame:CGRectMake(35.0f, fieldFrame.origin.y + yOffset + 50, 250.0f, 174.0f)];
	
	[self.signUpView.usernameField setFrame:CGRectMake(fieldFrame.origin.x + 5.0f,
																										 fieldFrame.origin.y + yOffset + 50,
																										 fieldFrame.size.width - 10.0f,
																										 fieldFrame.size.height)];
	yOffset += fieldFrame.size.height;
	
	[self.signUpView.passwordField setFrame:CGRectMake(fieldFrame.origin.x + 5.0f,
																										 fieldFrame.origin.y + yOffset + 50,
																										 fieldFrame.size.width - 10.0f,
																										 fieldFrame.size.height)];
	yOffset += fieldFrame.size.height;
	
	[self.signUpView.emailField setFrame:CGRectMake(fieldFrame.origin.x + 5.0f,
																									fieldFrame.origin.y + yOffset + 50,
																									fieldFrame.size.width - 10.0f,
																									fieldFrame.size.height)];
	yOffset += fieldFrame.size.height;
	
	[self.signUpView.additionalField setFrame:CGRectMake(fieldFrame.origin.x + 5.0f,
																											 fieldFrame.origin.y + yOffset + 50,
																											 fieldFrame.size.width - 10.0f,
																											 fieldFrame.size.height)];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
