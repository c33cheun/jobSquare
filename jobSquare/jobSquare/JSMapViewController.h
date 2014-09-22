//
//  JSMapViewController.h
//  jobSquare
//
//  Created by Geoffrey Heath on 2014-09-20.
//  Copyright (c) 2014 Givery. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>
#import <CoreLocation/CoreLocation.h>//
#import "BFTask.h"
#import "IMAsync.h"
#import "UIImage+Utilities.h"
#import "JSJobPosting.h"
#import "MCPanelViewController.h"
#import "JSJobTableViewController.h"

@interface JSMapViewController : UIViewController <GMSMapViewDelegate, CLLocationManagerDelegate> {
}

@property (strong, nonatomic) CLLocationManager* locationManager;
@property (strong, nonatomic) CLLocation* location;
@property (strong,nonatomic) MCPanelViewController* panelController;
@property (strong,nonatomic) NSMutableArray *data;
@property (strong,nonatomic) JSJobTableViewController* jobs;
@property (strong, nonatomic) UIButton* menu;

@end
