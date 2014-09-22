//
//  JSJobTableViewCell.m
//  jobSquare
//
//  Created by Geoffrey Heath on 2014-09-22.
//  Copyright (c) 2014 Givery. All rights reserved.
//

#import "JSJobTableCell.h"

@implementation JSJobTableCell

//@synthesize descriptionLabel = _descriptionLabel;

- (id)initWithData:(JSJobPosting*)job Style:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        // configure control
        UILabel *descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 8, 300, 30)];
        descriptionLabel.textColor = [UIColor whiteColor];
        descriptionLabel.font = [UIFont fontWithName:@"Lato-Regular" size:17.0f];
        descriptionLabel.text = job.title;
        
        self.company= [[UILabel alloc]initWithFrame:CGRectMake(80, 30, 300, 30)];
        self.company.textColor = [UIColor whiteColor];
        self.company.alpha = 0.4;
        self.company.font = [UIFont fontWithName:@"Lato-Light" size:13.0f];
        self.company.text = job.employer;
        
        UIImageView *logoView = [[UIImageView alloc]initWithFrame:CGRectMake(17, 9, self.frame.size.height + 6, self.frame.size.height + 6)];
        
        UIImage *logo = [UIImage imageNamed:[job.image stringByAppendingString:@".png"]];
        [logoView setImage:logo];
        
        [self addSubview:descriptionLabel];
        [self addSubview:_company];
        [self addSubview:logoView];
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
