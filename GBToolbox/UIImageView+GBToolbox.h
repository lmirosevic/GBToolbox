//
//  UIImageView+GBToolbox.h
//  GBToolbox
//
//  Created by Luka Mirosevic on 28/06/2013.
//  Copyright (c) 2013 Luka Mirosevic. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (GBToolbox)

/**
 Returns a UIImageView with its image set to image, and its frame size set to the image size
 */
+ (UIImageView *)imageViewWithImage:(UIImage *)image;

/**
 Returns a UIImageView with its image set to the image with name imageName, and its frame size set to the image size.
 */
+ (UIImageView *)imageViewWithImageNamed:(NSString *)imageName;

@end
