//
//  UIImage+GBToolbox.m
//  GBToolbox
//
//  Created by Luka Mirosevic on 05/02/2013.
//  Copyright (c) 2013 Luka Mirosevic. All rights reserved.
//

#import "UIImage+GBToolbox.h"

@implementation UIImage (GBToolbox)

//crop to rect
-(UIImage *)cropToRect:(CGRect)rect {
    CGImageRef imageRef = CGImageCreateWithImageInRect([self CGImage], rect);
    
    UIImage *croppedImage = [[UIImage alloc] initWithCGImage:imageRef scale:1.0 orientation:self.imageOrientation];
    
    CGImageRelease(imageRef);
    
    return croppedImage;
}

@end