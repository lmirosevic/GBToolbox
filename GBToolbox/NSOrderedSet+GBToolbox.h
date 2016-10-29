//
//  NSOrderedSet+GBToolbox.h
//  GBToolbox
//
//  Created by Luka Mirosevic on 28/03/16.
//  Copyright © 2016 Luka Mirosevic. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSOrderedSet<__covariant ObjectType> (GBToolbox)

/**
 Returns the index of the object that is identical to anObject, or NSNotFound if the set doesn't contain it.
 */
- (NSUInteger)indexOfObjectIdenticalTo:(nonnull id)anObject;

/**
 Returns a new set with the elements from the receiver transformed by function.
 */
- (nonnull NSOrderedSet<ObjectType> *)map:(id _Nonnull(^ _Nonnull)(ObjectType _Nonnull object))function;

/**
 Fold Left
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

@end
