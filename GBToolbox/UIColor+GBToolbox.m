//
//  UIColor+GBToolbox.m
//  GBToolbox
//
//  Created by Luka Mirosevic on 28/08/2013.
//  Copyright (c) 2013 Luka Mirosevic. All rights reserved.
//

#import "UIColor+GBToolbox.h"

#define ARC4RANDOM_MAX      0x100000000

@implementation UIColor (GBToolbox)

+(UIColor *)randomColor {
    CGFloat randomHue = ((double)arc4random() / ARC4RANDOM_MAX);
    return [UIColor colorWithHue:randomHue saturation:0.5 brightness:0.5 alpha:1];
}

@end
