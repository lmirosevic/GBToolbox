//
//  GBUtility_iOS.h
//  GBToolbox
//
//  Created by Luka Mirosevic on 05/02/2013.
//  Copyright (c) 2013 Luka Mirosevic. All rights reserved.
//

#import "GBTypes_Common.h"
#import "GBTypes_iOS.h"

#import "GBUtility_Common.h"

@interface GBToolbox (iOS)

#pragma mark - UIView

NSUInteger tagFromUIViewSubclass(id sender);

#pragma mark - Screen Locking

+(BOOL)isAutoScreenLockingEnabled;
+(void)enableAutoScreenLocking:(BOOL)enable;

#pragma mark - App Store redirect

void RedirectToAppStore(NSString *appID);

@end
