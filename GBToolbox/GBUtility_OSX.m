//
//  GBUtility_OSX.m
//  GBToolbox
//
//  Created by Luka Mirosevic on 05/02/2013.
//  Copyright (c) 2013 Luka Mirosevic. All rights reserved.
//

#import "GBUtility_OSX.h"

@implementation GBToolbox (OSX)

GBEdgeInsets GBEdgeInsetsMake(CGFloat top, CGFloat left, CGFloat bottom, CGFloat right) {
    GBEdgeInsets edgeInsets;
    
    edgeInsets.top = top;
    edgeInsets.left = left;
    edgeInsets.bottom = bottom;
    edgeInsets.right = right;
    
    return edgeInsets;
}

@end
