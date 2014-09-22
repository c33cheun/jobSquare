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
    
    self.menu = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width * 0.34, self.view.frame.size.height * 0.83, self.view.frame.size.width * 0.3, self.view.frame.size.height * 0.06)];
    [self.menu setBackgroundColor:[UIColor colorWithRed: 0 green: 0 blue: 0 alpha:0.7]];
    [self.menu addTarget:self action:@selector(openList) forControlEvents:UIControlEventTouchUpInside];
    [self.menu setTitle:@"# jobs found" forState:UIControlStateNormal];
    [self.menu setFont:[UIFont fontWithName:@"Lato" size:12.0]];
    [self.menu setTitleEdgeInsets:UIEdgeInsetsMake(3, 0, 3, 16)];
    [self.menu.layer setBorderWidth: 2.5];
    [self.menu.layer setBorderColor:[[UIColor whiteColor] CGColor]];
    [self.menu.layer setCornerRadius: 5.0];
    UIImageView *searchImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_all_jobs.png"]];
    searchImg.frame = CGRectMake(77, 9, 13, 13);
    [self.menu addSubview:searchImg];
    
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithTarget:_locationManager.location.coordinate zoom:10];
    
    mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView.myLocationEnabled = YES;
    mapView.delegate = self;
    [mapView setMinZoom:13.9 maxZoom:kGMSMaxZoomLevel];
    
    PFGeoPoint *myLocation = [PFGeoPoint geoPointWithLocation:_locationManager.location];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:UIColorFromRGB(0xd4e05d), NSForegroundColorAttributeName, [UIFont fontWithName:@"Lato" size:17.0], NSFontAttributeName, nil]];
    
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
    
    //reverse geocode not working
    [geocoder reverseGeocodeLocation: resultLocation completionHandler:
     ^(NSArray *placemarks, NSError *error) {
         //Get nearby address
         CLPlacemark *localPlacemark = [placemarks objectAtIndex:0];
         
         NSString *addressName = [[localPlacemark.addressDictionary valueForKey:@"FormattedAddressLines"] componentsJoinedByString:@", "];
         
         self.navigationController.navigationBar.topItem.title = addressName;
         [self.view setNeedsDisplay];
     }];
    
    PFGeoPoint *myNewLocation = [PFGeoPoint geoPointWithLocation:resultLocation];
    [_data removeAllObjects];
    
    PFQuery *query = [PFQuery queryWithClassName:@"Job"];
    [query setLimit:10];
    [query whereKey:@"location" nearGeoPoint:myNewLocation withinKilometers:2.0];
    
    [[IMAsync findObjectsAsync:query] continueWithSuccessBlock:^id(BFTask *results) {
        
        NSUInteger counter = 0;
        [respMapView clear];
        [_data removeAllObjects];
        
        //draw new marker in the middle of map
        GMSMarker *marker = [[GMSMarker alloc] init];
        marker.position = resultLocation.coordinate;
        marker.map = mapView;
        
        for(PFObject *result in results.result){
            
            counter++;
            JSJobPosting *pass = [[JSJobPosting alloc]initWithParseObject:result];
            [_data addObject:pass];

            [self setMapMarkersWithJob:pass andNumber:counter];
        }
        [self.view addSubview:_menu];
            
        [self.menu setTitle:[NSString stringWithFormat:@"%lu jobs found", (unsigned long)counter] forState:UIControlStateNormal];
        
        //placeholder text
        self.navigationController.navigationBar.topItem.title = @"Searching for Jobs";
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
