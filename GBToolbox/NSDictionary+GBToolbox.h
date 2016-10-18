//
//  NSDictionary+GBToolbox.h
//  GBToolbox
//
//  Created by Luka Mirosevic on 06/06/2013.
//  Copyright (c) 2013 Luka Mirosevic. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (GBToolbox)

#pragma mark - Funtional Programming

/**
 Classic functional filter.
 */
- (nonnull NSDictionary *)filter:(nonnull BOOL(^)(id _Nonnull key, id _Nonnull object))function;

/**
 Returns a random key for which the function returns YES.
 */
- (nullable id)aKey:(nonnull BOOL(^)(id _Nonnull key, id _Nonnull object))function;

/**
 Returns a random object for which the function return YES.
 */
- (nullable id)anObject:(nonnull BOOL(^)(id _Nonnull key, id _Nonnull object))function;

/**
 Returns a new dictionary with all key/value pairs from dictionary removed whose values was an instance of NSNull. Works recursively.
 */
+ (nonnull NSDictionary *)dictionaryByPruningNullsInDictionary:(nullable NSDictionary *)dictionary;

/**
 Returns a copy of the receiver with all key/value pairs removed whose values was an instance of NSNull. Works recursively.
 */
- (nonnull NSDictionary *)dictionaryByPruningNulls;

@end
