//
//  NSDictionary+GBToolbox.m
//  GBToolbox
//
//  Created by Luka Mirosevic on 06/06/2013.
//  Copyright (c) 2013 Luka Mirosevic. All rights reserved.
//

#import "NSDictionary+GBToolbox.h"

@implementation NSDictionary (GBToolbox)

#pragma mark - Funtional Programming

//filter
-(NSDictionary *)filter:(BOOL(^)(id key, id object))function {
    // creates a results array in which to store results, sets the capacity for faster writes
    NSUInteger count = self.count;
    NSMutableDictionary *resultsDictionary = [[NSMutableDictionary alloc] initWithCapacity:count];
    
    // applies the function to each item and stores the result in the new dictionary
    for (id key in self) {
        if (function(key, self[key])) {
            resultsDictionary[key] = self[key];
        }
    }
    
    // returns an immutable copy
    return [resultsDictionary copy];
}

//aKey
-(id)aKey:(BOOL(^)(id key, id object))function {
    for (id key in self) {
        if (function(key, self[key])) {
            return key;
        }
    }
    
    return nil;
}

//anObject
-(id)anObject:(BOOL(^)(id key, id object))function {
    id key = [self aKey:function];
    if (key) {
        return self[key];
    }
    else {
        return nil;
    }
}

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