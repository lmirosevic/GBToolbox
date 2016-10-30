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

/**
 Returns a random object from the array, or nil if the array is empty.
 */
@property (strong, nonatomic, readonly, nullable) ObjectType randomObject;

#pragma mark - Functional Programming

/**
 Returns a new array with the elements from the receiver transformed by function.
 */
- (nonnull NSArray *)map:(id _Nonnull(^ _Nonnull)(ObjectType _Nonnull object))function;

/**
 Returns a new array with the elements from the receiver transformed by function.
 */
- (nonnull NSArray *)mapWithIndex:(id _Nonnull(^ _Nonnull)(ObjectType _Nonnull object, NSUInteger index))function;

/**
 Fold Left.
 */
- (nonnull ObjectType)foldLeft:(ObjectType _Nonnull(^ _Nonnull)(ObjectType _Nonnull objectA, ObjectType _Nonnull objectB))function lastObject:(nonnull ObjectType)lastObject;

/**
 Fold Right.
 */
- (nonnull ObjectType)foldRight:(ObjectType _Nonnull(^ _Nonnull)(ObjectType _Nonnull objectA, ObjectType _Nonnull objectB))function initialObject:(nonnull ObjectType)initialObject;

/**
 Synonym for foldLeft
 */
- (nonnull ObjectType)reduce:(ObjectType _Nonnull(^ _Nonnull)(ObjectType _Nonnull objectA, ObjectType _Nonnull objectB))function lastObject:(nonnull ObjectType)lastObject;

/**
 Returns a copy of the array containing only the objects for which function returns YES.
 */
- (nonnull NSArray<ObjectType> *)filter:(BOOL(^ _Nonnull)(ObjectType _Nonnull object))function;

/**
 Returns YES if all of the elements in the receiver return true for the function.
 
 Returns NO for an empty array.
 */
- (BOOL)all:(BOOL(^ _Nonnull)(ObjectType _Nonnull object))function;

/**
 Returns YES if at least one of the elements in the receiver return true for the function.
 
 Returns NO for an empty array.
 */
- (BOOL)any:(BOOL(^ _Nonnull)(ObjectType _Nonnull object))function;

/**
 Returns the first object for which the function returns YES, nil otherwise.
 */
- (nullable ObjectType)first:(BOOL(^ _Nonnull)(ObjectType _Nonnull object))function;

/**
 Returns the count of objects for which function returns YES.
 */
- (NSUInteger)count:(BOOL(^ _Nonnull)(ObjectType _Nonnull object))function;

/**
 Returns the index of the first object that returns YES for the block. If no object returns YES, returns NSNotFound
 */
- (NSUInteger)indexOfFirst:(BOOL(^ _Nonnull)(ObjectType _Nonnull object))function;

#pragma mark - Conveniences

/**
 Returns the first object inside the receiver which is equal to the object (compared using isEqual:). Returns nil if no object is equal.
 */
- (nullable ObjectType)firstObjectEqualToObject:(id _Nonnull)object;

/**
 Returns YES if the received contains the specific passed in object instance.
 */
- (BOOL)containsObjectIdenticalTo:(nonnull id)anObject;

#pragma mark - Set like operations

/**
 Returns a new array which is a copy of the receiver with all objects removed that are inside `array`
 */
- (nonnull NSArray<ObjectType> *)arrayBySubtractingArray:(nonnull NSArray *)array;

#pragma mark - Description

/**
 Returns the array concatenated by ", "
 */
@property (copy, nonatomic, nonnull, readonly) NSString *shortStringRepresentation;

#pragma mark - Sorting

/**
 Returns an array sorted by the properties in the objects.
 */
- (nonnull NSArray<ObjectType> *)sortedArrayByPropertiesOfObjects:(nonnull NSArray<NSString *> *)properties ascending:(BOOL)ascending;

/**
 Returns an array sorted by the properties in the objects in ascending order.
 */
- (nonnull NSArray<ObjectType> *)sortedArrayByPropertiesOfObjects:(nonnull NSArray<NSString *> *)properties;

#pragma mark - Unique

/**
 Returns a copy of the receiver with all duplicates removed.
 */
- (nonnull NSArray<ObjectType> *)uniquedArray;

#pragma mark - Convenience

/**
 Returns a set initialized with the contents of the receiver.
 */
- (nonnull NSSet<ObjectType> *)set;

/**
 Returns an ordered set initialized with the contents of the receiver.
 */
- (nonnull NSOrderedSet<ObjectType> *)orderedSet;

#pragma mark - NSAttributedString

/**
 Returns a new NSAttributedString by concatenating all the NSAttributedString's in the receiver.
 */
- (nonnull NSAttributedString *)concatenatedArrayOfAttributedStrings;

@end
