//
//  NSMutableDictionary+GBToolbox.m
//  GBToolbox
//
//  Created by Luka Mirosevic on 06/06/2013.
//  Copyright (c) 2013 Luka Mirosevic. All rights reserved.
//

#import "NSMutableDictionary+GBToolbox.h"

#import "NSDictionary+GBToolbox.h"

@implementation NSMutableDictionary (GBToolbox)

#pragma mark - pruning

-(void)pruneNulls {
    //create a pruned copy
    NSDictionary *prunedVersion = [NSDictionary dictionaryByPruningNullsInDictionary:self];
    
    //now reassing everything in so that this object retains it's identity
    [self removeAllObjects];
    for (id key in prunedVersion) {
        [self setObject:[prunedVersion objectForKey:key] forKey:key];
    }
}

@end
