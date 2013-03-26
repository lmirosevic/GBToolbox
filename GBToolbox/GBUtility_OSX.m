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

#pragma mark - App Store redirect

void RedirectToAppStore(NSString *appID) {
    [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"macappstore://itunes.apple.com/app/id%@?mt=12", appID]]];
}


@end
