//
//  NSArray+GBToolbox.h
//  GBToolbox
//
//  Created by Luka Mirosevic on 20/03/2013.
//  Copyright (c) 2013 Luka Mirosevic. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (GBToolbox)

#pragma mark - Helper methods

//returns a random object from the array
@property (strong, nonatomic, readonly) id randomObject;

#pragma mark - Functional Programming

//map
-(NSArray *)map:(id(^)(id object))function;

//fold left
-(id)foldLeft:(id(^)(id objectA, id objectB))function lastObject:(id)lastObject;

//fold right
-(id)foldRight:(id(^)(id objectA, id objectB))function initialObject:(id)initialObject;

//synonym for foldLeft
-(id)reduce:(id(^)(id objectA, id objectB))function lastObject:(id)lastObject;

//filter
-(NSArray *)filter:(BOOL(^)(id object))function;

//all
-(BOOL)all:(BOOL(^)(id object))function;

//any
-(BOOL)any:(BOOL(^)(id object))function;

//first
-(id)first:(BOOL(^)(id object))function;

//count
-(NSUInteger)count:(BOOL(^)(id object))function;

/**
 Returns the index of the first object that returns YES for the block. If no object returns YES, returns NSNotFound
 */
- (NSUInteger)indexOfFirst:(BOOL(^)(id object))function;

#pragma mark - Conveniences

/**
 Returns the first object inside the receiver which is equal to the object (compared using isEqual:). Returns nil if no object is equal.
 */
-(id)firstObjectEqualToObject:(id)object;

/**
 Returns YES if the received contains the specific passed in object instance.
 */
- (BOOL)containsObjectIdenticalTo:(id)anObject;

#pragma mark - Set like operations

/**
 Returns a new array which is a copy of the receiver with all objects removed that are inside `array`
 */
-(NSArray *)arrayBySubtractingArray:(NSArray *)array;

#pragma mark - Description

//returns the array concatenated by ", "
@property (copy, nonatomic, readonly) NSString *shortStringRepresentation;
-(NSString *)shortStringRepresentation;

#pragma mark - Sorting

/**
 Returns an array sorted by the properties in the objects.
 */
- (NSArray *)sortedArrayByPropertiesOfObjects:(NSArray<NSString *> *)properties ascending:(BOOL)ascending;

/**
 Returns an array sorted by the properties in the objects in ascending order.
 */
- (NSArray *)sortedArrayByPropertiesOfObjects:(NSArray<NSString *> *)properties;

#pragma mark - Unique

- (NSArray *)uniquedArray;

@end
