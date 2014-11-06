//
//  NSMapTable+GBToolbox.h
//  GBToolbox
//
//  Created by Luka Mirosevic on 01/06/2014.
//  Copyright (c) 2014 Luka Mirosevic. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMapTable (GBToolbox)

/**
 Returns the object for a key, assuming both object and key are objects.
 */
-(id)objectForKeyedSubscript:(id)key;

/**
 Stores an object into the map table for the given key. Assumes both object and key are objects.
 */
-(void)setObject:(id)object forKeyedSubscript:(id)key;

/**
 Returns an array holding all the keys.
 */
@property (strong, nonatomic, readonly) NSArray *allKeys;

/**
 Returns an array holding all the objects.
 */
@property (strong, nonatomic, readonly) NSArray *allObjects;

/**
 Checks whether the map table contains the object.
 */
-(BOOL)containsObject:(id)object;

/**
 Returns the firs matching key for the object.
 */
-(id)keyForObject:(id)object;

@end
