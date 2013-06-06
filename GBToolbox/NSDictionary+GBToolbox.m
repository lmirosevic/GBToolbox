//
//  NSDictionary+GBToolbox.m
//  GBToolbox
//
//  Created by Luka Mirosevic on 06/06/2013.
//  Copyright (c) 2013 Luka Mirosevic. All rights reserved.
//

#import "NSDictionary+GBToolbox.h"

@implementation NSDictionary (GBToolbox)

#pragma mark - pruning

+(NSDictionary *)dictionaryByPruningNullsInDictionary:(NSDictionary *)dictionary {
    NSMutableDictionary *temp = [[NSMutableDictionary alloc] initWithCapacity:dictionary.count];
    
    for (id key in dictionary) {
        id value = [dictionary objectForKey:key];
        
        if ([value isKindOfClass:[NSDictionary class]]) {
            [temp setObject:[NSDictionary dictionaryByPruningNullsInDictionary:value] forKey:key];
        }
        else if ([value isKindOfClass:[NSNull class]]) {
            continue;
        }
        else {
            [temp setObject:value forKey:key];
        }
    }
    
    return temp;//always returns a mutable one, but it shudn't be a prob
}

@end