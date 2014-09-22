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
@property (nonatomic, strong) IBOutlet UITextField *nameTextField;

@end

@implementation JSProfileViewController

static NSString *cellIdentifier;

- (void)viewDidLoad {
	
	[super viewDidLoad];
    
    [self setNeedsStatusBarAppearanceUpdate];
	
    //set style and colours
    self.view.backgroundColor = UIColorFromRGB(0x2f3c44);
    self.details.backgroundColor = UIColorFromRGB(0x2f3c44);
    
    [self.pictureFrame setImage:[UIImage imageNamed:@"shenIcon.png"]];
    // Get the Layer of any view
    CALayer * l = [self.pictureFrame layer];
    [l setMasksToBounds:YES];
    [l setCornerRadius: 35.0];
    self.pictureFrame.clipsToBounds = YES;
    
	self.nameTextField.text = @"Shen Lee";
	self.nameTextField.enabled = false;
    
    self.ageLabel.text = @"30";
    self.details.separatorStyle = UITableViewCellSeparatorStyleNone;
    
	//default descriptions:
	
	self.sectionList = [NSArray arrayWithObjects:@"Skills", @"Work Experience", @"Profile", nil];
	NSArray *skills = [NSArray arrayWithObjects:@"Programming", @"Graphic Design", nil];
	NSArray *workExperience = [NSArray arrayWithObjects:@"GameHouse", @"Givery", nil];
    NSArray *profile = [NSArray arrayWithObjects:@"This is my profile, I am awesome, number one team leader. I make cool UI experiences and buy lots of snacks. Hire me please. The lysine contingency - it's intended to prevent the spread of the animals is case they ever got off the island. Dr. Wu inserted a gene that makes a single faulty enzyme in protein metabolism. The animals can't manufacture the amino acid lysine. Unless they're continually supplied with lysine by us, they'll slip into a coma and die.", nil];
	NSArray *datas = [NSArray arrayWithObjects:skills, workExperience, profile, nil];
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
    cell.textLabel.font = [UIFont fontWithName:@"Lato" size:15.0];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    cell.backgroundColor = UIColorFromRGB(0x2f3c44);

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
