//
//  NSMapTable+GBToolbox.m
//  GBToolbox
//
//  Created by Luka Mirosevic on 01/06/2014.
//  Copyright (c) 2014 Luka Mirosevic. All rights reserved.
//

#import "NSMapTable+GBToolbox.h"

#import "NSArray+GBToolbox.h"

@implementation NSMapTable (GBToolbox)

-(id)objectForKeyedSubscript:(id)key {
    return [self objectForKey:key];
}

-(void)setObject:(id)object forKeyedSubscript:(id)key {
    [self setObject:object forKey:key];
}

-(NSArray *)allKeys {
    NSMutableArray *allKeys = [[NSMutableArray alloc] initWithCapacity:self.count];
    
    for (id key in self) {
        [allKeys addObject:key];
    }
    
    return allKeys;
}

-(NSArray *)allObjects {
    return [self.allKeys map:^id(id key) {
        return [self objectForKey:key];
    }];
}

@end
