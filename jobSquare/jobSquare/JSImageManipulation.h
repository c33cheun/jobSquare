//
//  JSImageManipulation.h
//  jobSquare
//
//  Created by Geoffrey Heath on 2014-09-21.
//  Copyright (c) 2014 Givery. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol JSImageManipulation <NSObject>

- (UIImage*) drawText:(NSString*) text inImage:(UIImage*)  image atPoint:(CGPoint)   point

- (UIImage *)resizeImage:(UIImage*)image newSize:(CGSize)newSize

@end
