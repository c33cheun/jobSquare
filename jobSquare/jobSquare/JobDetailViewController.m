//
//  JobDetailViewController.m
//  jobSquare
//
//  Created by Christopher Cheung on 2014-09-20.
//  Copyright (c) 2014 Givery. All rights reserved.
//

#import "JobDetailViewController.h"


@interface JobDetailViewController ()

@property (nonatomic, strong) NSMutableArray *data;

@end

@implementation JobDetailViewController

static NSString *cellIdentifier;


- (void)viewDidLoad {
    
     [super viewDidLoad];
    //default descriptions:
    self.data = [NSMutableArray arrayWithObjects: @"Title",@"Employer",@"Address",@"Salary",@"Hours", @"Description", nil];
    
    PFQuery *query = [PFQuery queryWithClassName:@"Job"];
    [query whereKey:@"objectId" equalTo: self.jobId];
    
    [[IMAsync findObjectsAsync:query] continueWithSuccessBlock:^id(BFTask *results) {
        
        for(PFObject *result in results.result){
            //[jobLocations addObject:result];
            JSJobPosting *pass = [[JSJobPosting alloc]initWithParseObject:result];
            self.data[0] = [NSString stringWithFormat:@"%@ : %@", self.data[0], pass.title];
            self.data[1] = [NSString stringWithFormat:@"%@ : %@", self.data[1], pass.employer];
            self.data[2] = [NSString stringWithFormat:@"%@ : %@", self.data[2], pass.address];
            self.data[3] = [NSString stringWithFormat:@"%@ : %lu", self.data[3], (unsigned long)pass.wage];
            self.data[4] = [NSString stringWithFormat:@"%@ : %lu", self.data[4], (unsigned long)pass.hours];
            self.data[5] = [NSString stringWithFormat:@"%@ : %@", self.data[5], pass.jobDetail];
            
            [self.details reloadData];
        }
        
        return nil;
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
