//
//  NSOrderedSet+GBToolbox.m
//  GBToolbox
//
//  Created by Luka Mirosevic on 28/03/16.
//  Copyright © 2016 Luka Mirosevic. All rights reserved.
//

#import "NSOrderedSet+GBToolbox.h"

@implementation NSOrderedSet (GBToolbox)

- (NSUInteger)indexOfObjectIdenticalTo:(id)anObject {
    for (NSUInteger i=0; i<self.count; i++) {
        if (self[i] == anObject) {
            return i;
        }
    }
    
    return NSNotFound;
}

- (NSOrderedSet *)map:(id(^)(id object))function {
    NSMutableOrderedSet *results = [[NSMutableOrderedSet alloc] initWithCapacity:self.count];
    
    for (id object in self) {
        id transformed = function(object);
        if (transformed) {
            [results addObject:transformed];
        } else {
            @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"Mapping function must return a non-nil object" userInfo:nil];
        }
    }
    
    return [results copy];
}

- (id)foldLeft:(id(^)(id objectA, id objectB))function lastObject:(id)accumulator {
    for (id object in self) {
        accumulator = function(accumulator, object);
    }
    
    return accumulator;
}

- (id)foldRight:(id(^)(id objectA, id objectB))function initialObject:(id)accumulator {
    for (id object in [self reverseObjectEnumerator]) {
        accumulator = function(accumulator, object);
    }
    
    return accumulator;
}

- (id)reduce:(id(^)(id objectA, id objectB))function lastObject:(id)lastObject {
    return [self foldLeft:function lastObject:lastObject];
}

@end
