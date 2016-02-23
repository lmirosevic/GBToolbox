//
//  UIScreen+GBToolbox.m
//  GBToolbox
//
//  Created by Luka Mirosevic on 23/02/16.
//  Copyright © 2016 Luka Mirosevic. All rights reserved.
//

#import "UIScreen+GBToolbox.h"

@implementation UIScreen (GBToolbox)

- (CGRect)fixedBounds {
    // iOS 8+
    if ([[UIScreen mainScreen] respondsToSelector:@selector(fixedCoordinateSpace)]) {
        return [[UIScreen mainScreen].coordinateSpace convertRect:[UIScreen mainScreen].bounds toCoordinateSpace:[UIScreen mainScreen].fixedCoordinateSpace];
    }
    // iOS 7 and prior
    else {
        return [UIScreen mainScreen].bounds;
    }
}

@end
