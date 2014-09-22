//
//  JSProfileViewController.m
//  jobSquare
//
//  Created by Christopher Cheung on 2014-09-20.
//  Copyright (c) 2014 Givery. All rights reserved.
//

#import "JSProfileViewController.h"
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


@interface JSProfileViewController ()

@property (nonatomic, strong) NSDictionary *data;
@property (nonatomic, strong) NSArray *sectionList;
@property (nonatomic, strong) IBOutlet UIButton *photoButton;
@property (nonatomic, strong) IBOutlet UITextField *nameTextField;

@end

@implementation JSProfileViewController

static NSString *cellIdentifier;

- (void)viewDidLoad {
	
	[super viewDidLoad];
    
    [self setNeedsStatusBarAppearanceUpdate];
	
    //set style and colours
    self.view.backgroundColor = UIColorFromRGB(0x2f3c44);
    
	UIImage *portfolio = [UIImage imageNamed:@"Logo.png"];
	[self.photoButton setImage:portfolio forState:UIControlStateNormal];
//	self.photoButton.highlighted = true;
	self.nameTextField.text = @"Your name";
	self.nameTextField.enabled = false;
	//default descriptions:
	
	self.sectionList = [NSArray arrayWithObjects:@"Skill", @"Work Experience", nil];
	NSArray *skills = [NSArray arrayWithObjects:@"Programming", @"Economics", nil];
	NSArray *workExperience = [NSArray arrayWithObjects:@"Immagle", @"Givery", nil];
	NSArray *datas = [NSArray arrayWithObjects:skills, workExperience, nil];
	self.data = [NSDictionary dictionaryWithObjects:datas forKeys:self.sectionList];
	
//	PFQuery *query = [PFQuery queryWithClassName:@"User"];
//	self.userId = @"Gd6vAyBelj";
//	[query whereKey:@"objectId" equalTo: self.userId];
//	
//	[[IMAsync findObjectsAsync:query] continueWithSuccessBlock:^id(BFTask *results) {
//		
//		for(PFObject *result in results.result){
//			//[jobLocations addObject:result];
//			JSJobPosting *pass = [[JSJobPosting alloc]initWithParseObject:result];
//			self.data[0] = [NSString stringWithFormat:@"%@ : %@", self.data[0], pass.title];
//			self.data[1] = [NSString stringWithFormat:@"%@ : %@", self.data[1], pass.employer];
//			self.data[2] = [NSString stringWithFormat:@"%@ : %@", self.data[2], pass.address];
//			self.data[3] = [NSString stringWithFormat:@"%@ : %lu", self.data[3], (unsigned long)pass.wage];
//			self.data[4] = [NSString stringWithFormat:@"%@ : %lu", self.data[4], (unsigned long)pass.hours];
//			self.data[5] = [NSString stringWithFormat:@"%@ : %@", self.data[5], pass.jobDetail];
//			
//			[self.details reloadData];
//		}
//		
//		return nil;
//	}];
	
	// Do any additional setup after loading the view from its nib.
	cellIdentifier = @"rowCell";
	[self.details registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdentifier];
//	self.details.userInteractionEnabled = NO;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return [self.sectionList count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	return [self.sectionList objectAtIndex:section];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	NSString *sectionName = [self.sectionList objectAtIndex:section];
	return [[self.data objectForKey:sectionName] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
	if (!cell) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
	}
	NSString *sectionName = [self.sectionList objectAtIndex:indexPath.section];
	NSArray *items = [self.data objectForKey:sectionName];
	
	cell.textLabel.text = [items objectAtIndex:indexPath.row];

	return cell;
}

- (UIStatusBarStyle) preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillDisappear:animated];
}

@end
