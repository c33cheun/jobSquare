//
//  JSJobTableViewController.h
//  jobSquare
//
//  Created by Geoffrey Heath on 2014-09-22.
//  Copyright (c) 2014 Givery. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSJobPosting.h"
#import "JSJobTableCell.h"

@interface JSJobTableViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong,nonatomic)NSMutableArray *data;

- (id) initWithData: (NSMutableArray*)data;

- (void) resetData: (NSMutableArray*)jobs;

@end
