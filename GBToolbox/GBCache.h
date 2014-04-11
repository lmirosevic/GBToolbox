//
//  GBCache.h
//  GBToolbox
//
//  Created by Luka Mirosevic on 10/04/2014.
//  Copyright (c) 2014 Luka Mirosevic. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSUInteger const kGBCacheUnlimitedCacheSize;

@interface GBCache : NSCache

@property (assign, nonatomic) NSUInteger        maxCacheSize;//default: kGBCacheUnlimitedCacheSize

-(id)objectForKeyedSubscript:(id)key;
-(void)setObject:(id)obj forKeyedSubscript:(id)key;

@end
