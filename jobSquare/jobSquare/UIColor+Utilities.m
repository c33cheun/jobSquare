//
//  UIColor+Utilities.m
//  jobSquare
//
//  Created by Geoffrey Heath on 2014-09-22.
//  Copyright (c) 2014 Givery. All rights reserved.
//

#import "UIColor+Utilities.h"

@implementation UIColor (Utilities)

- (UIColor *)colorFromHexString:(NSString *)hexString {
    unsigned int rgbValue;
    if([hexString characterAtIndex:0] == '#'){
        [[NSScanner scannerWithString:[hexString substringFromIndex:1]] scanHexInt:&rgbValue];
    }
    else {
        [[NSScanner scannerWithString:hexString] scanHexInt:&rgbValue];
    }
    return [UIColor colorWithRed:((rgbValue & 0xff0000) >> 16)/255.0 green:((rgbValue & 0xff00) >> 8)/255.0 blue:(rgbValue & 0xff)/255.0 alpha:1.0];
}

@end
