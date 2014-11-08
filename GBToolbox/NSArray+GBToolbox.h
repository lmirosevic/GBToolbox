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

//indexOfFirst
-(NSUInteger)indexOfFirst:(BOOL(^)(id object))function;

#pragma mark - Conveniences

/**
 Returns the first object inside the receiver which is equal to the object. Returns nil if no object is equal.
 */
-(id)firstObjectEqualToObject:(id)object;

#pragma mark - Set like operations

/**
 Returns a new array which is a copy of the receiver with all objects removed that are inside `array`
 */
-(NSArray *)arrayBySubtractingArray:(NSArray *)array;

#pragma mark - Description

//returns the array concatenated by ", "
@property (copy, nonatomic, readonly) NSString *shortStringRepresentation;
-(NSString *)shortStringRepresentation;

@end
