//
//  UIImageView+GBToolbox.m
//  GBToolbox
//
//  Created by Luka Mirosevic on 28/06/2013.
//  Copyright (c) 2013 Luka Mirosevic. All rights reserved.
//

#import "UIImageView+GBToolbox.h"

@implementation UIImageView (GBToolbox)

+(UIImageView *)imageViewWithImage:(UIImage *)image {
    UIImageView *imageView = [[UIImageView new] initWithImage:image];
    imageView.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    return imageView;
}

+(UIImageView *)imageViewWithImageNamed:(NSString *)imageName {
    return [self imageViewWithImage:[UIImage imageNamed:imageName]];
}

@end
