//
//  JSJobTableViewController.m
//  jobSquare
//
//  Created by Geoffrey Heath on 2014-09-22.
//  Copyright (c) 2014 Givery. All rights reserved.
//

#import "JSJobTableViewController.h"

@interface JSJobTableViewController ()

@end

@implementation JSJobTableViewController {
    UITableView *tableView;
    NSInteger rowCount;
}

- (id) initWithData: (NSMutableArray*)data {
    self = [super init];
    if (self){
        self.data = data;
        rowCount = [self.data count];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    
    // must set delegate & dataSource, otherwise the the table will be empty and not responsive
    tableView.delegate = self;
    tableView.dataSource = self;
    
    tableView.backgroundColor = [tableView.backgroundColor colorFromHexString:kBackgroundColor];
    
    // add to canvas
    [self.view addSubview:tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return rowCount + 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.item == 0){
        return 60.0f;
    }
    else {
        return 70.0f;
    }

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // Configure the cell...
    
    if (indexPath.row == 0){
        UITableViewCell *cell = [[UITableViewCell alloc]init];
        
        UILabel *number = [[UILabel alloc]initWithFrame:CGRectMake(25, 10, 60, 60)];
        number.text = [NSString stringWithFormat:@"%d",[_data count]];
        number.textColor =[UIColor whiteColor];
        number.font = [UIFont fontWithName:@"Lato-Bold" size:32.0f];
        
        UILabel *words = [[UILabel alloc]initWithFrame:CGRectMake(50, 31, 300, 30)];
        words.text = @"Jobs found near you";
        words.textColor = [UIColor whiteColor];
        words.font = [UIFont fontWithName:@"Lato-Regular" size:14.0f];
        
        cell.backgroundColor = [cell.backgroundColor colorFromHexString:kBackgroundColor];
        [cell addSubview:words];
        [cell addSubview:number];
        return cell;
    }
    else {
        static NSString *cellIdentifier = @"HistoryCell";
    
        // Similar to UITableViewCell, but
        JSJobTableCell *cell = (JSJobTableCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
        JSJobPosting *job = [_data objectAtIndex:indexPath.row - 1];
    
        if (cell == nil) {
            cell = [[JSJobTableCell alloc] initWithData:job Style:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        cell.backgroundColor = [cell.backgroundColor colorFromHexString:kBackgroundColor];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    JobDetailViewController *selectedJob = [[JobDetailViewController alloc]initWithData:[_data objectAtIndex:indexPath.row - 1]];
    
    _panelController = [[MCPanelViewController alloc]initWithRootViewController:selectedJob];
    selectedJob.preferredContentSize = CGSizeMake(self.view.frame.size.width * 0.9, 0);
    [self.navigationController presentPanelViewController:_panelController withDirection:MCPanelAnimationDirectionRight];
    
    //[self presentViewController:selectedJob animated:YES completion:nil];
    
}

- (void) resetData: (NSMutableArray*)jobs {
    [_data removeAllObjects];
    [_data addObjectsFromArray:jobs];
    [self reloadInputViews];
    //[self.view setNeedsDisplay];
}




@end
