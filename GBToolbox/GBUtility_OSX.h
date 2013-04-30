//
//  GBUtility_OSX.h
//  GBToolbox
//
//  Created by Luka Mirosevic on 05/02/2013.
//  Copyright (c) 2013 Luka Mirosevic. All rights reserved.
//

#import "GBTypes_Common.h"
#import "GBTypes_OSX.h"

#import "GBUtility_Common.h"

@interface GBToolbox (OSX)

#pragma mark - App Store redirect

void RedirectToAppStore(NSString *appID);

@end
