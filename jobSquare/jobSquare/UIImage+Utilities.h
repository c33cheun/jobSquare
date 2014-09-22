//
//  UIImage+Utilities.h
//  jobSquare
//
//  Created by Geoffrey Heath on 2014-09-22.
//  Copyright (c) 2014 Givery. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Utilities)

-(UIImage*) drawText:(NSString*)text ofSize:(int)size inImage:(UIImage*)image atPoint:(CGPoint)point;

-(UIImage*) resizeImage:(UIImage*) input withScale:(float)scale;

@end
