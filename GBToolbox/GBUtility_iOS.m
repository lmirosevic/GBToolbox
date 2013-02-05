//
//  GBUtility_iOS.m
//  GBToolbox
//
//  Created by Luka Mirosevic on 05/02/2013.
//  Copyright (c) 2013 Luka Mirosevic. All rights reserved.
//

#import "GBUtility_iOS.h"

@implementation GBToolbox (iOS)

#pragma mark - UIView

NSUInteger tagFromUIViewSubclass(id sender) {
    if ([sender isKindOfClass:[UIView class]]) {
        return ((UIView *)sender).tag;
    }
    else return 0;
}

#pragma mark - Screen Locking

+(BOOL)isAutoScreenLockingEnabled {
	UIApplication *me = [UIApplication sharedApplication];
	return me.idleTimerDisabled;
}

+(void)enableAutoScreenLocking:(BOOL)enable {
	UIApplication *me = [UIApplication sharedApplication];
	me.idleTimerDisabled = !enable;
}

@end