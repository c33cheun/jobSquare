//
//  JobDetailViewController.h
//  jobSquare
//
//  Created by Christopher Cheung on 2014-09-20.
//  Copyright (c) 2014 Givery. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "IMAsync.h"
#import "JSJobPosting.h"

@interface JobDetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *details;

@property (weak, nonatomic) NSString* jobId;

//UI ELEMENTS
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *employerLabel;

@property (weak, nonatomic) IBOutlet UILabel *hoursLabel;
@property (weak, nonatomic) IBOutlet UILabel *hoursLabel2;
@property (weak, nonatomic) IBOutlet UILabel *wageLabel;
@property (weak, nonatomic) IBOutlet UILabel *wageLabel2;
@property (weak, nonatomic) IBOutlet UIButton *applyButton;
@property (weak, nonatomic) IBOutlet UITextView *descriptText;

@property (weak, nonatomic) IBOutlet UIImageView *logo;

- (id) initWithData: (JSJobPosting*)job;

@end
