//
//  JobDetailViewController.h
//  jobSquare
//
//  Created by Christopher Cheung on 2014-09-20.
//  Copyright (c) 2014 Givery. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JobDetailTableView.h"
#import <Parse/Parse.h>
#import "IMAsync.h"
#import "JSJobPosting.h"

@interface JobDetailViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *details;

@property (weak, nonatomic) NSString* jobId;

@end
