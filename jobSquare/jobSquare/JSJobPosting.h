//
//  JobPosting.h
//  jobSquare
//
//  Created by Geoffrey Heath on 2014-09-21.
//  Copyright (c) 2014 Givery. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface JSJobPosting : NSObject

@property (strong,nonatomic) NSString *title;
@property (strong,nonatomic) NSString *employer;
@property (strong,nonatomic) NSString *address;
@property NSUInteger wage;
@property NSUInteger hours;
@property (strong,nonatomic) NSString *jobDetail;
@property (strong,nonatomic) CLLocation *location;
@property (strong,nonatomic) NSString *image;

- (id) initWithParseObject:(PFObject*)jobPosting;

@end
