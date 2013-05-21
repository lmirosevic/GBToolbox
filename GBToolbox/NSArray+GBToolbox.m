//
//  NSArray+GBToolbox.m
//  GBToolbox
//
//  Created by Luka Mirosevic on 20/03/2013.
//  Copyright (c) 2013 Luka Mirosevic. All rights reserved.
//

#import "NSArray+GBToolbox.h"

@implementation NSArray (GBToolbox)

#pragma mark - helper methods

//returns a random object from the array
-(id)randomObject {
    NSUInteger count = self.count;
    
    if (count > 0) {
        return self[arc4random() % count];
    }
    else {
        return nil;
    }
}

#pragma mark - functional programming

//map
-(NSArray *)map:(id(^)(id object))function {
    // creates a results array in which to store results, sets the capacity for faster writes
    NSUInteger count = self.count;
    NSMutableArray *resultsArray = [[NSMutableArray alloc] initWithCapacity:count];
    
    // applies the function to each item and stores the result in the new array
    for (NSUInteger i=0; i<count; i++) {
        resultsArray[i] = function(self[i]);
    }
    
    // returns an immutable copy
    return [resultsArray copy];
}

//fold left
-(id)foldLeft:(id(^)(id objectA, id objectB))function lastObject:(id)accumulator {
    for (id object in self) {
        accumulator = function(accumulator, object);
    }
    
    return accumulator;
}

//fold right
-(id)foldRight:(id(^)(id objectA, id objectB))function initialObject:(id)accumulator {
    for (id object in [self reverseObjectEnumerator]) {
        accumulator = function(accumulator, object);
    }
    
    return accumulator;
}

//synonym for foldLeft
-(id)reduce:(id(^)(id objectA, id objectB))function lastObject:(id)lastObject {
    return [self foldLeft:function lastObject:lastObject];
}

//filter
-(NSArray *)filter:(BOOL(^)(id object))function {
    // creates a results array in which to store results, sets the capacity for faster writes
    NSUInteger count = self.count;
    NSMutableArray *resultsArray = [[NSMutableArray alloc] initWithCapacity:count];
    
    // applies the function to each item and stores the result in the new array
    for (NSUInteger i=0; i<count; i++) {
        if (function(self[i])) {
            [resultsArray addObject:self[i]];
        }
    }
    
    // returns an immutable copy
    return [resultsArray copy];
}

#pragma mark - Description

//returns the array concatenated by ", "
-(NSString *)shortStringRepresentation {
    return [self componentsJoinedByString:@", "];
}

@end
