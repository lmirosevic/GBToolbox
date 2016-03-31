//
//  NSArray+GBToolbox.m
//  GBToolbox
//
//  Created by Luka Mirosevic on 20/03/2013.
//  Copyright (c) 2013 Luka Mirosevic. All rights reserved.
//

#import "NSArray+GBToolbox.h"

@implementation NSArray (GBToolbox)

#pragma mark - Helper methods

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

#pragma mark - Functional Programming

- (NSArray *)map:(id(^)(id object))function {
    //creates a results array in which to store results, presets the capacity for faster writes
    NSUInteger count = self.count;
    NSMutableArray *resultsArray = [[NSMutableArray alloc] initWithCapacity:count];
    
    //applies the function to each item and stores the result in the new array, except if it's nil
    for (NSUInteger i=0; i<count; i++) {
        id mappedObject = function(self[i]);
        if (mappedObject) {
            resultsArray[i] = mappedObject;
        }
        else {
            @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"Mapping function must return a non-nil object" userInfo:nil];
        }
    }
    
    //returns an immutable copy
    return [resultsArray copy];
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

- (NSArray *)filter:(BOOL(^)(id object))function {
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

- (BOOL)all:(BOOL(^)(id object))function {
    if (self.count > 0) {
        return [[[self map:^id(id object) {
            return @(function(object));
        }] reduce:^id(id objectA, id objectB) {
            return @([objectA boolValue] && [objectB boolValue]);
        } lastObject:@(YES)] boolValue];
    } else {
        return NO;
    }
}

- (BOOL)any:(BOOL(^)(id object))function {
    if (self.count > 0) {
        return [[[self map:^id(id object) {
            return @(function(object));
        }] reduce:^id(id objectA, id objectB) {
            return @([objectA boolValue] || [objectB boolValue]);
        } lastObject:@(NO)] boolValue];
    } else {
        return NO;
    }
}

- (id)first:(BOOL(^)(id object))function {
    NSInteger index = [self indexOfFirst:function];
    
    if (index != NSNotFound) {
        return [self objectAtIndex:index];
    }
    else {
        return nil;
    }
}

//count
-(NSUInteger)count:(BOOL(^)(id object))function {
    return [[self filter:function] count];
}

- (NSUInteger)indexOfFirst:(BOOL(^)(id object))function {
    NSUInteger count = self.count;
    for (NSUInteger i=0; i<count; i++) {
        id myObject = [self objectAtIndex:i];
        if (function(myObject)) return i;
    }
    
    //if we got here it means we didn't find any
    return NSNotFound;
}

#pragma mark - Conveniences

-(id)firstObjectEqualToObject:(id)object {
    NSUInteger index = [self indexOfObject:object];
    
    if (index == NSNotFound) {
        return nil;
    }
    else {
        return [self objectAtIndex:index];
    }
}

- (BOOL)containsObjectIdenticalTo:(id)anObject {
    return ([self indexOfObjectIdenticalTo:anObject] != NSNotFound);
}

#pragma mark - Set like operations

-(NSArray *)arrayBySubtractingArray:(NSArray *)array {
    NSPredicate *relativeComplementPredicate = [NSPredicate predicateWithFormat:@"NOT SELF IN %@", array];
    return [self filteredArrayUsingPredicate:relativeComplementPredicate];
}

#pragma mark - Description

//returns the array concatenated by ", "
-(NSString *)shortStringRepresentation {
    return [self componentsJoinedByString:@", "];
}

#pragma mark - Sorting

- (NSArray *)sortedArrayByPropertiesOfObjects:(NSArray<NSString *> *)properties ascending:(BOOL)ascending {
    return [self sortedArrayUsingDescriptors:[properties map:^id(id object) {
        return [NSSortDescriptor sortDescriptorWithKey:(NSString *)object ascending:ascending];
    }]];
}

- (NSArray *)sortedArrayByPropertiesOfObjects:(NSArray<NSString *> *)properties {
    return [self sortedArrayByPropertiesOfObjects:properties ascending:YES];
}

#pragma mark - Unique

- (NSArray *)uniquedArray {
    return [[NSOrderedSet orderedSetWithArray:self] array];
}

#pragma mark - Convenience

- (NSSet *)set {
    return [NSSet setWithArray:self];
}

- (NSOrderedSet *)orderedSet {
    return [NSOrderedSet orderedSetWithArray:self];
}

@end
