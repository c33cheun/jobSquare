//
//  JobDetailViewController.m
//  jobSquare
//
//  Created by Christopher Cheung on 2014-09-20.
//  Copyright (c) 2014 Givery. All rights reserved.
//

#import "JobDetailViewController.h"
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


@interface JobDetailViewController ()

@property (nonatomic, strong) NSMutableArray *data;

@end

@implementation JobDetailViewController

static NSString *cellIdentifier;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setNeedsStatusBarAppearanceUpdate];
    
    //default descriptions:
    self.data = [NSMutableArray arrayWithObjects: @"Title",@"Employer",@"Address",@"Salary",@"Hours", @"Description", nil];
    
    PFQuery *query = [PFQuery queryWithClassName:@"Job"];
    [query whereKey:@"objectId" equalTo: self.jobId];
    
    [[IMAsync findObjectsAsync:query] continueWithSuccessBlock:^id(BFTask *results) {
        
        for(PFObject *result in results.result){
            //[jobLocations addObject:result];
            JSJobPosting *pass = [[JSJobPosting alloc]initWithParseObject:result];
            self.data[0] = [NSString stringWithFormat:@"%@", pass.title];
            self.data[1] = [NSString stringWithFormat:@"%@",  pass.employer];
            self.data[2] = [NSString stringWithFormat:@"%@", pass.address];
            self.data[3] = [NSString stringWithFormat:@"%@%lu", @"¥", (unsigned long)pass.wage];
            self.data[4] = [NSString stringWithFormat:@"%lu", (unsigned long)pass.hours];
            self.data[5] = [NSString stringWithFormat:@"%@", pass.jobDetail];
            
            [self.details reloadData];
            
            self.titleLabel.text = self.data[0];
            self.employerLabel.text = self.data[1];
            self.wageLabel.text = self.data[3];
            self.hoursLabel.text = self.data[4];
            self.descriptText.text = self.data[5];
            
            [self.view setNeedsDisplay];
        }
        
        return nil;
    }];
   
    self.titleLabel.text = self.data[0];
    self.employerLabel.text = self.data[1];
    self.wageLabel.text = self.data[3];
    self.hoursLabel.text = self.data[4];
    self.descriptText.text = self.data[5];
    
    //color text and background
    self.view.backgroundColor = UIColorFromRGB(0x2f3c44);
    self.wageLabel.textColor = UIColorFromRGB(0xd4e05d);
    self.wageLabel2.textColor = UIColorFromRGB(0xd4e05d);
    self.hoursLabel.textColor = UIColorFromRGB(0xd4e05d);
    self.hoursLabel2.textColor = UIColorFromRGB(0xd4e05d);
    self.applyButton.backgroundColor = UIColorFromRGB(0xd4e05d);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillDisappear:animated];
}

- (UIStatusBarStyle) preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
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
