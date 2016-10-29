//
//  NSMapTable+GBToolbox.h
//  GBToolbox
//
//  Created by Luka Mirosevic on 01/06/2014.
//  Copyright (c) 2014 Luka Mirosevic. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMapTable<KeyType, ObjectType> (GBToolbox)

/**
 Returns the object for a key, assuming both object and key are objects.
 */
- (nullable ObjectType)objectForKeyedSubscript:(nullable KeyType)key;

/**
 Stores an object into the map table for the given key. Assumes both object and key are objects.
 */
- (void)setObject:(nullable ObjectType)object forKeyedSubscript:(nullable KeyType)key;

/**
 Returns an array holding all the keys.
 */
@property (strong, nonatomic, nonnull, readonly) NSArray<KeyType> *allKeys;

/**
 Returns an array holding all the objects.
 */
@property (strong, nonatomic, nonnull, readonly) NSArray<ObjectType> *allObjects;

/**
 Checks whether the map table contains the object.
 */
- (BOOL)containsObject:(nullable ObjectType)object;

/**
 Returns the first matching key for the object.
 */
- (nullable KeyType)keyForObject:(nullable ObjectType)object;

@end
