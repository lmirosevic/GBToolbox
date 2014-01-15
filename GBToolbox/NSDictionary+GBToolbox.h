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

//filter
-(NSDictionary *)filter:(BOOL(^)(id key, id object))function;

//aKey: returns a key which the function return YES
-(id)aKey:(BOOL(^)(id key, id object))function;

//anObject: returns an object for which the function return YES
-(id)anObject:(BOOL(^)(id key, id object))function;

#pragma mark - pruning

+(NSDictionary *)dictionaryByPruningNullsInDictionary:(NSDictionary *)dictionary;

@end
