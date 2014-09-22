//
//  JSMapViewController.m
//  jobSquare
//
//  Created by Geoffrey Heath on 2014-09-20.
//  Copyright (c) 2014 Givery. All rights reserved.
//

#import "JSMapViewController.h"
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface JSMapViewController () {
}

@end

@implementation JSMapViewController {
    GMSMapView *mapView;
    CLGeocoder *geocoder;
    CLPlacemark *placemark;
    GMSGeocoder *gGeocoder;
}

- (void) loadView {
    [super loadView];
    
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    
    [self startStandardUpdates];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _menu = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width * 0.3, self.view.frame.size.height * 0.8, self.view.frame.size.width * 0.3, self.view.frame.size.height * 0.1)];
    [_menu setBackgroundColor:[UIColor blackColor]];
    [_menu addTarget:self action:@selector(openList) forControlEvents:UIControlEventTouchUpInside];
    
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithTarget:_locationManager.location.coordinate zoom:10];
    
    mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView.myLocationEnabled = YES;
    mapView.delegate = self;
    [mapView setMinZoom:14 maxZoom:kGMSMaxZoomLevel];
    
    PFGeoPoint *myLocation = [PFGeoPoint geoPointWithLocation:_locationManager.location];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:UIColorFromRGB(0xd4e05d), NSForegroundColorAttributeName, [UIFont fontWithName:@"Kato" size:17.0], NSFontAttributeName, nil]];
    
    self.navigationController.navigationBar.topItem.title = @"Current Location";
    
    _data = [NSMutableArray array];
        
    self.view = mapView;
}

- (IBAction)openList {
    _jobs = [[JSJobTableViewController alloc]initWithData:_data];
    _panelController = [[MCPanelViewController alloc] initWithRootViewController:_jobs];
    _jobs.preferredContentSize = CGSizeMake(self.view.frame.size.width * 0.9, 0);
    [self.navigationController presentPanelViewController:_panelController withDirection:MCPanelAnimationDirectionRight];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];    
}

- (void)startStandardUpdates
{
    // Create the location manager if this object does not
    // already have one.
    if (nil == _locationManager)
        self.locationManager = [[CLLocationManager alloc] init];
    
    //_locationManager.delegate = self;
    [_locationManager setDelegate:self];
    
    // Check for iOS 8. Without this guard the code will crash with "unknown selector" on iOS 7.
    if ([_locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [_locationManager requestWhenInUseAuthorization];
    }
    _locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
    
    // Set a movement threshold for new events.
    _locationManager.distanceFilter = 500; // meters
    
    [_locationManager startUpdatingLocation];
}


- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    _location = [[CLLocation alloc]init];
    _location = locations.lastObject;
    [_locationManager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"didUpdateToLocation: %@", newLocation);
    CLLocation *currentLocation = newLocation;
    
    [_locationManager stopUpdatingLocation];
    
    // Reverse Geocoding
    NSLog(@"Resolving the Address");
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        NSLog(@"Found placemarks: %@, error: %@", placemarks, error);
        if (error == nil && [placemarks count] > 0) {
            placemark = [placemarks lastObject];
//            addressLabel.text = [NSString stringWithFormat:@"%@ %@\n%@ %@\n%@\n%@",
//                                 placemark.subThoroughfare, placemark.thoroughfare,
//                                 placemark.postalCode, placemark.locality,
//                                 placemark.administrativeArea,
//                                 placemark.country];
        } else {
            NSLog(@"%@", error.debugDescription);
        }
    } ];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}

#pragma mark - GMSMapViewDelegate

- (void)mapView:(GMSMapView *)respMapView
idleAtCameraPosition:(GMSCameraPosition *)cameraPosition {
    
    CLLocation *resultLocation = [[CLLocation alloc] initWithLatitude:cameraPosition.target.latitude longitude: cameraPosition.target.longitude];
    
    PFGeoPoint *myNewLocation = [PFGeoPoint geoPointWithLocation:resultLocation];    
    
    PFQuery *query = [PFQuery queryWithClassName:@"Job"];
    [query setLimit:10];
    [query whereKey:@"location" nearGeoPoint:myNewLocation withinKilometers:2.0];
    
    [[IMAsync findObjectsAsync:query] continueWithSuccessBlock:^id(BFTask *results) {
        
        NSUInteger counter = 0;
        [respMapView clear];
        [_data removeAllObjects];
        
        for(PFObject *result in results.result){
            
            counter++;
            JSJobPosting *pass = [[JSJobPosting alloc]initWithParseObject:result];
            [_data addObject:pass];
            [self setMapMarkersWithJob:pass andNumber:counter];
        }
        [self.view addSubview:_menu];
        return nil;
    }];

}

-(void) setMapMarkersWithJob:(JSJobPosting*)job andNumber: (int)counter  {
    UIImage *markerIcon = [UIImage imageNamed:@"marker_small_01.png"];
    markerIcon = [markerIcon drawText:[NSString stringWithFormat:@"%i",counter] ofSize: 24 inImage:markerIcon atPoint:CGPointMake(14, 8)];
    
    GMSMarker *point = [GMSMarker markerWithPosition:job.location.coordinate];
    point.map = mapView;
    point.icon = markerIcon;
    point.title = [NSString stringWithFormat:@"%lu", (unsigned long)counter];
}

@end
