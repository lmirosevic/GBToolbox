//
//  UIImageView+GBToolbox.h
//  GBToolbox
//
//  Created by Luka Mirosevic on 28/06/2013.
//  Copyright (c) 2013 Luka Mirosevic. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (GBToolbox)

//returns a imageview with it's image set, and its frame size set to the image size
+(UIImageView *)imageViewWithImage:(UIImage *)image;

//returns a imageview with it's image set to the image with name imageName, and its frame size set to the image size
+(UIImageView *)imageViewWithImageNamed:(NSString *)imageName;

@end
