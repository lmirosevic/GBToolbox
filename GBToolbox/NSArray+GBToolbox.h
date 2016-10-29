//
//  NSArray+GBToolbox.h
//  GBToolbox
//
//  Created by Luka Mirosevic on 20/03/2013.
//  Copyright (c) 2013 Luka Mirosevic. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray<__covariant ObjectType> (GBToolbox)

#pragma mark - Helper methods

//returns a random object from the array
@property (strong, nonatomic, readonly) id randomObject;

#pragma mark - Functional Programming

/**
 Returns a new array with the elements from the receiver transformed by function.
 */
- (NSArray *)map:(id(^)(ObjectType object))function;

/**
 Returns a new array with the elements from the receiver transformed by function.
 */
- (NSArray *)mapWithIndex:(id(^)(ObjectType object, NSUInteger index))function;

/**
 Fold Left
 */
- (ObjectType)foldLeft:(ObjectType(^)(ObjectType objectA, ObjectType objectB))function lastObject:(ObjectType)lastObject;

/**
 Fold Right.
 */
- (ObjectType)foldRight:(ObjectType(^)(ObjectType objectA, ObjectType objectB))function initialObject:(ObjectType)initialObject;

/**
 Synonym for foldLeft
 */
- (ObjectType)reduce:(ObjectType(^)(ObjectType objectA, ObjectType objectB))function lastObject:(ObjectType)lastObject;

/**
 Returns a copy of the array containing only the objects for which function returns YES.
 */
- (NSArray<ObjectType> *)filter:(BOOL(^)(ObjectType object))function;

/**
 Returns YES if all of the elements in the receiver return true for the function.
 
 Returns NO for an empty array.
 */
- (BOOL)all:(BOOL(^)(ObjectType object))function;

/**
 Returns YES if at least one of the elements in the receiver return true for the function.
 
 Returns NO for an empty array.
 */
- (BOOL)any:(BOOL(^)(ObjectType object))function;

/**
 Returns the first object for which the function returns YES, nil otherwise.
 */
- (ObjectType)first:(BOOL(^)(ObjectType object))function;

/**
 Returns the count of objects for which function returns YES.
 */
- (NSUInteger)count:(BOOL(^)(ObjectType object))function;

/**
 Returns the index of the first object that returns YES for the block. If no object returns YES, returns NSNotFound
 */
- (NSUInteger)indexOfFirst:(BOOL(^)(ObjectType object))function;

#pragma mark - Conveniences

/**
 Returns the first object inside the receiver which is equal to the object (compared using isEqual:). Returns nil if no object is equal.
 */
-(ObjectType)firstObjectEqualToObject:(id)object;

/**
 Returns YES if the received contains the specific passed in object instance.
 */
- (BOOL)containsObjectIdenticalTo:(id)anObject;

#pragma mark - Set like operations

/**
 Returns a new array which is a copy of the receiver with all objects removed that are inside `array`
 */
- (NSArray<ObjectType> *)arrayBySubtractingArray:(NSArray *)array;

#pragma mark - Description

/**
 Returns the array concatenated by ", "
 */
@property (copy, nonatomic, readonly) NSString *shortStringRepresentation;
- (NSString *)shortStringRepresentation;

#pragma mark - Sorting

/**
 Returns an array sorted by the properties in the objects.
 */
- (NSArray<ObjectType> *)sortedArrayByPropertiesOfObjects:(NSArray<NSString *> *)properties ascending:(BOOL)ascending;

/**
 Returns an array sorted by the properties in the objects in ascending order.
 */
- (NSArray<ObjectType> *)sortedArrayByPropertiesOfObjects:(NSArray<NSString *> *)properties;

#pragma mark - Unique

/**
 Returns a copy of the receiver with all duplicates removed.
 */
- (NSArray<ObjectType> *)uniquedArray;

#pragma mark - Convenience

/**
 Returns a set initialized with the contents of the receiver.
 */
- (NSSet<ObjectType> *)set;

/**
 Returns an ordered set initialized with the contents of the receiver.
 */
- (NSOrderedSet<ObjectType> *)orderedSet;

#pragma mark - NSAttributedString

/**
 Returns a new NSAttributedString by concatenating all the NSAttributedString's in the receiver.
 */
- (NSAttributedString *)concatenatedArrayOfAttributedStrings;

@end
