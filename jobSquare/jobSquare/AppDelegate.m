//
//  AppDelegate.m
//  jobSquare
//
//  Created by Geoffrey Heath on 2014-09-20.
//  Copyright (c) 2014 Givery. All rights reserved.
//

#import "AppDelegate.h"
#import <Parse/Parse.h>
#import <ParseFacebookUtils/PFFacebookUtils.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	// Override point for customization after application launch.

	[Parse setApplicationId:@"jHjzkupQVXyNitOUWRRgXmzmmEjZYmrShGgsAvJe"
								clientKey:@"71pEQr6snuieQxrMjzsxnPZIHmeVVDjtrlUxQVoR"];
	// ****************************************************************************
	// Your Facebook application id is configured in Info.plist.
	// ****************************************************************************
	[PFFacebookUtils initializeFacebook];
	[PFTwitterUtils initializeWithConsumerKey:@"gksD1aP7gbyvdL6u6jmu8xAvq" consumerSecret:@"EOyTD80rFuGKDA7xC3IxwXXs9pwn5Pp0VjgTQ3zgtU28obq8hT"];

	[PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];

	self.window = [[UIWindow alloc]initWithFrame:UIScreen.mainScreen.bounds];

	JSLoginViewController *first = [[JSLoginViewController alloc]init];
	self.window.rootViewController = first;
	[self.window makeKeyAndVisible];
	[GMSServices provideAPIKey:@"AIzaSyDvyRzWBy8trwLIuIWc3OI5fwIfJNI-UP8"];
	return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
	// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
	// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
	// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
	// Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

// ****************************************************************************
// App switching methods to support Facebook Single Sign-On.
// ****************************************************************************
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
	return [FBAppCall handleOpenURL:url
								sourceApplication:sourceApplication
											withSession:[PFFacebookUtils session]];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
	/*
	 Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
	 */
	[FBAppCall handleDidBecomeActiveWithSession:[PFFacebookUtils session]];
}

- (void)applicationWillTerminate:(UIApplication *)application {
	/*
	 Called when the application is about to terminate.
	 Save data if appropriate.
	 See also applicationDidEnterBackground:.
	 */
	[[PFFacebookUtils session] close];
}

@end
