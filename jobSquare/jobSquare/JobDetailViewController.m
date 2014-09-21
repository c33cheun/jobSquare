//
//  JobDetailViewController.m
//  jobSquare
//
//  Created by Christopher Cheung on 2014-09-20.
//  Copyright (c) 2014 Givery. All rights reserved.
//

#import "JobDetailViewController.h"
#import "JobDetailTableView.h"
#import <Parse/Parse.h>

@interface JobDetailViewController ()

@property (nonatomic, strong) NSMutableArray *data;

@end

@implementation JobDetailViewController

static NSString *cellIdentifier;


- (void)viewDidLoad {
    
     [super viewDidLoad];
    //default descriptions:
    self.data = [NSMutableArray arrayWithObjects: @"Title",@"Employer",@"Address",@"Salary",@"Hours", @"Description", nil];
    
    PFQuery *dataQuery = [PFQuery queryWithClassName:@"Job"];
    [dataQuery getObjectInBackgroundWithId: @"ExhFAklqBl" block:^(PFObject *job, NSError *error) {
            // Do something with the returned PFObject in the gameScore variable.
        
        if (!error) {
        self.data[0] = [NSString stringWithFormat:@"%@ : %@", self.data[0], [[job objectForKey:@"title"] stringValue]];
        self.data[1] = [NSString stringWithFormat:@"%@ : %@", self.data[1], job[@"employer"]];
        self.data[2] = [NSString stringWithFormat:@"%@ : %@", self.data[2], job[@"address"]];
        self.data[3] = [NSString stringWithFormat:@"%@ : %@", self.data[3], job[@"salary"]];
        self.data[4] = [NSString stringWithFormat:@"%@ : %@", self.data[4], job[@"hours"]];
        self.data[5] = [NSString stringWithFormat:@"%@ : %@", self.data[5], job[@"descript"]];
            
        [self.details reloadSections:[NSIndexSet indexSetWithIndexesInRange: NSRangeFromString(@"0-5")] withRowAnimation:UITableViewRowAnimationAutomatic];
        } else {
            NSLog(@"fail query");
        }
    }];
    
   
    // Do any additional setup after loading the view from its nib.

    cellIdentifier = @"rowCell";
    [self.details registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdentifier];
    self.details.userInteractionEnabled = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(JobDetailTableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.data count];

}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(JobDetailTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell.textLabel.text = [self.data objectAtIndex:indexPath.row];
    return cell;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
