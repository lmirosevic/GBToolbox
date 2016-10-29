//
//  NSDictionary+GBToolbox.h
//  GBToolbox
//
//  Created by Luka Mirosevic on 06/06/2013.
//  Copyright (c) 2013 Luka Mirosevic. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary<__covariant KeyType, __covariant ObjectType> (GBToolbox)

#pragma mark - Funtional Programming

/**
 Classic functional filter.
 */
- (nonnull NSDictionary<KeyType, ObjectType> *)filter:(nonnull BOOL(^)(KeyType _Nonnull key, ObjectType _Nonnull object))function;

/**
 Returns a random key for which the function returns YES.
 */
- (nullable KeyType)aKey:(BOOL(^ _Nonnull)(KeyType _Nonnull key, ObjectType _Nonnull object))function;

/**
 Returns a random object for which the function return YES.
 */
- (nullable ObjectType)anObject:(BOOL(^ _Nonnull)(KeyType _Nonnull key, ObjectType _Nonnull object))function;

/**
 Returns a new dictionary with all key/value pairs from dictionary removed whose values was an instance of NSNull. Works recursively.
 */
+ (nonnull NSDictionary<KeyType, ObjectType> *)dictionaryByPruningNullsInDictionary:(nullable NSDictionary *)dictionary;

/**
 Returns a copy of the receiver with all key/value pairs removed whose values was an instance of NSNull. Works recursively.
 */
- (nonnull NSDictionary<KeyType, ObjectType> *)dictionaryByPruningNulls;

/**
 Returns a new dictionary (shallow copy) that contains both key/value pairs from the receiver and dictionary. In case of duplicate keys, dictionary's values will override those of the receiver.
 */
- (nonnull NSDictionary<KeyType, ObjectType> *)dictionaryByMergingWithDictionary:(nullable NSDictionary *)dictionary;

@end
