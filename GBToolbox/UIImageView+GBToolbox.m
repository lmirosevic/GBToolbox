//
//  UIImageView+GBToolbox.m
//  GBToolbox
//
//  Created by Luka Mirosevic on 28/06/2013.
//  Copyright (c) 2013 Luka Mirosevic. All rights reserved.
//

#import "UIImageView+GBToolbox.h"

@implementation UIImageView (GBToolbox)

+ (UIImageView *)imageViewWithImage:(UIImage *)image {
    UIImageView *imageView = [[UIImageView new] initWithImage:image];
    imageView.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    return imageView;
}

+ (UIImageView *)imageViewWithImageNamed:(NSString *)imageName {
    return [self imageViewWithImage:[UIImage imageNamed:imageName]];
}

// based on http://stackoverflow.com/a/15447942/399772
- (CGRect)displayedImageBounds {
    UIImage *image = [self image];
    if (self.contentMode != UIViewContentModeScaleAspectFit || !image) {
        return self.bounds;
    }
    
    CGFloat boundsWidth  = self.bounds.size.width,
    boundsHeight = self.bounds.size.height;
    
    CGSize  imageSize  = image.size;
    CGFloat imageRatio = imageSize.width / imageSize.height;
    CGFloat viewRatio  = boundsWidth / boundsHeight;
    
    if (imageRatio < viewRatio) {
        CGFloat scale = boundsHeight / imageSize.height;
        CGFloat width = scale * imageSize.width;
        CGFloat topLeftX = (boundsWidth - width) * 0.5;
        return CGRectMake(topLeftX, 0, width, boundsHeight);
    }
    
    CGFloat scale = boundsWidth / imageSize.width;
    CGFloat height = scale * imageSize.height;
    CGFloat topLeftY = (boundsHeight - height) * 0.5;
    
    return CGRectMake(0, topLeftY, boundsWidth, height);
}

@end
