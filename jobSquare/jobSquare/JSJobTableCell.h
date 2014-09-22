//
//  JSJobTableViewCell.h
//  jobSquare
//
//  Created by Geoffrey Heath on 2014-09-22.
//  Copyright (c) 2014 Givery. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSJobPosting.h"
#import "UIImage+Utilities.h"

@interface JSJobTableCell : UITableViewCell

@property (strong,nonatomic) UILabel *company;

- (id)initWithData:(JSJobPosting*)job Style:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end
