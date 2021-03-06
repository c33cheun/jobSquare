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
#import "UIColor+Utilities.h"
#import "JSAssetsConstants.h"
#import "JobDetailViewController.h"
#import "MCPanelViewController.h"

@interface JSJobTableViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong,nonatomic)NSMutableArray *data;
@property (strong,nonatomic)MCPanelViewController *panelController;

- (id) initWithData: (NSMutableArray*)data;

- (void) resetData: (NSMutableArray*)jobs;

@end
