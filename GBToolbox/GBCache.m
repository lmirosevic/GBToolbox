//
//  GBCache.m
//  GBToolbox
//
//  Created by Luka Mirosevic on 10/04/2014.
//  Copyright (c) 2014 Luka Mirosevic. All rights reserved.
//

#import "GBCache.h"

#import <malloc/malloc.h>

NSUInteger const kGBCacheUnlimitedCacheSize = 0;

@implementation GBCache

#pragma mark - CA

-(void)setMaxCacheSize:(NSUInteger)maxCacheSize {
    self.totalCostLimit = maxCacheSize;
}

-(NSUInteger)maxCacheSize {
    return self.totalCostLimit;
}

#pragma mark - Life

-(id)init {
    if (self = [super init]) {
        self.maxCacheSize = kGBCacheUnlimitedCacheSize;
    }
    
    return self;
}

#pragma mark - API

-(id)objectForKeyedSubscript:(id)key {
    return [self objectForKey:key];
}

-(void)setObject:(id)obj forKeyedSubscript:(id)key {
    [self setObject:obj forKey:key];
}

@end
