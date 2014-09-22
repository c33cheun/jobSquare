//
//  JobPosting.m
//  jobSquare
//
//  Created by Geoffrey Heath on 2014-09-21.
//  Copyright (c) 2014 Givery. All rights reserved.
//

#import "JSJobPosting.h"

@implementation JSJobPosting

- (id) initWithParseObject:(PFObject*)jobPosting {
    self = [super init];
    if (self){
        self.title = [jobPosting objectForKey:@"title"];
        self.address = [jobPosting objectForKey:@"address"];
        self.employer = [jobPosting objectForKey:@"employer"];
        self.jobDetail = [jobPosting objectForKey:@"descript"];
        self.wage = [[jobPosting objectForKey:@"salary"] intValue];
        self.hours = [[jobPosting objectForKey:@"hours"] intValue];
        self.image = [jobPosting objectForKey:@"logo"];
        
        PFGeoPoint *temp = [jobPosting objectForKey:@"location"];
        self.location = [[CLLocation alloc]initWithLatitude:[temp latitude] longitude:[temp longitude]];
    }
    return self;
}



@end
