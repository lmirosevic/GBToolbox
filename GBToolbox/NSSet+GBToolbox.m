//
//  NSSet+GBToolbox.m
//  GBToolbox
//
//  Created by Luka Mirosevic on 28/03/16.
//  Copyright © 2016 Luka Mirosevic. All rights reserved.
//

#import "NSSet+GBToolbox.h"

@implementation NSSet (GBToolbox)

- (BOOL)contains:(BOOL(^)(id object))function {
    for (id object in self) {
        if (function(object)) {
            return YES;
        }
    }
    
    return NO;
}

- (NSSet *)filter:(BOOL(^)(id object))function {
    // creates a results set in which to store results, sets the capacity for faster writes
    NSMutableSet *resultsSet = [[NSMutableSet alloc] initWithCapacity:self.count];
    
    // apply the function to each object in self and store the results in the new set
    for (id object in self) {
        if (function(object)) {
            [resultsSet addObject:object];
        }
    }
    
    // return an immutable copy
    return [resultsSet copy];
}

- (id)first:(BOOL(^)(id object))function {
    for (id object in self) {
        if (function(object)) {
            return object;
        }
    }
    
    return nil;
}

@end
