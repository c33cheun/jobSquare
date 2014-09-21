//
//  JSMapViewController.m
//  jobSquare
//
//  Created by Geoffrey Heath on 2014-09-20.
//  Copyright (c) 2014 Givery. All rights reserved.
//

#import "JSMapViewController.h"

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
    
    [self.navigationController.navigationBar setTintColor: [UIColor blackColor]];
    [self.navigationController.navigationBar setBarTintColor: [UIColor blackColor]];
    [self startStandardUpdates];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithTarget:_locationManager.location.coordinate zoom:10];
    
    mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView.myLocationEnabled = YES;
    mapView.delegate = self;
    
    
    PFGeoPoint *myLocation = [PFGeoPoint geoPointWithLocation:_locationManager.location];
    
    PFQuery *query = [PFQuery queryWithClassName:@"Job"];
    [query setLimit:10];
    [query whereKey:@"location" nearGeoPoint:myLocation withinKilometers:2.0];

    [[IMAsync findObjectsAsync:query] continueWithSuccessBlock:^id(BFTask *results) {
        
        NSMutableArray *jobs = [NSMutableArray array];
        
        NSUInteger counter = 0;
        
        for(PFObject *result in results.result){
            //[jobLocations addObject:result];
            
            counter++;
            JSJobPosting *pass = [[JSJobPosting alloc]initWithParseObject:result];
            [jobs addObject:pass];
            GMSMarker *point = [GMSMarker markerWithPosition:pass.location.coordinate];
            point.map = mapView;
            point.title = [NSString stringWithFormat:@"%lu", (unsigned long)counter];
        }
        
        return nil;
    }];
    // Creates a marker in the center of the map.
    //GMSMarker *marker = [[GMSMarker alloc] init];
    //marker.position = _locationManager.location.coordinate;
    //marker.map = mapView;
    
    self.view = mapView;
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

-(void)mapView:(GMSMapView *)respMapView willMove:(BOOL)gesture {
    [respMapView clear];
}

- (void)mapView:(GMSMapView *)respMapView
idleAtCameraPosition:(GMSCameraPosition *)cameraPosition {
    
    CLLocation *resultLocation = [[CLLocation alloc] initWithLatitude:cameraPosition.target.latitude longitude: cameraPosition.target.longitude];
    
    PFGeoPoint *myNewLocation = [PFGeoPoint geoPointWithLocation:resultLocation];
    
    PFQuery *query = [PFQuery queryWithClassName:@"Job"];
    [query setLimit:10];
    [query whereKey:@"location" nearGeoPoint:myNewLocation withinKilometers:2.0];
    
    [[IMAsync findObjectsAsync:query] continueWithSuccessBlock:^id(BFTask *results) {
        
        NSMutableArray *jobs = [NSMutableArray array];
        
        NSUInteger counter = 0;
        
        for(PFObject *result in results.result){
            //[jobLocations addObject:result];
            
            counter++;
            JSJobPosting *pass = [[JSJobPosting alloc]initWithParseObject:result];
            [jobs addObject:pass];
            GMSMarker *point = [GMSMarker markerWithPosition:pass.location.coordinate];
            point.map = mapView;
            point.title = [NSString stringWithFormat:@"%lu", (unsigned long)counter];
        }
        
        return nil;
    }];

}
@end
