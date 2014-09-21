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
#import "JSJobPosting.h"

@interface JSMapViewController : UIViewController <GMSMapViewDelegate, CLLocationManagerDelegate> {
}

@property (strong, nonatomic) CLLocationManager* locationManager;
@property (strong, nonatomic) CLLocation* location;

@end
