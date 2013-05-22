//
//  UIView+GBToolbox.m
//  GBToolbox
//
//  Created by Luka Mirosevic on 22/05/2013.
//  Copyright (c) 2013 Luka Mirosevic. All rights reserved.
//

#import "UIView+GBToolbox.h"

@implementation UIView (GBToolbox)

-(void)removeAllSubviews {
    NSArray *subviews = [self.subviews copy];
    [subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
}

@end
