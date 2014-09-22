//
//  UIImage+Utilities.m
//  jobSquare
//
//  Created by Geoffrey Heath on 2014-09-22.
//  Copyright (c) 2014 Givery. All rights reserved.
//

#import "UIImage+Utilities.h"

@implementation UIImage (Utilities)

-(UIImage*) drawText:(NSString*) text
              ofSize: (int) size
             inImage:(UIImage*)  image
             atPoint:(CGPoint)   point
{
    
    UIFont *font = [UIFont boldSystemFontOfSize:size];
    UIGraphicsBeginImageContext(image.size);
    [image drawInRect:CGRectMake(0,0,image.size.width,image.size.height)];
    CGRect rect = CGRectMake(point.x, point.y, image.size.width, image.size.height);
    [text drawInRect:CGRectIntegral(rect) withAttributes:[NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, [UIColor whiteColor], NSForegroundColorAttributeName, nil]];                                                        
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (UIImage*) resizeImage:(UIImage*) input withScale:(float)scale {
    UIImage *scaledImage = [UIImage imageWithCGImage:[input CGImage]
                                               scale:(input.scale * scale)
                                         orientation:(input.imageOrientation)];
    return scaledImage;
}


@end
