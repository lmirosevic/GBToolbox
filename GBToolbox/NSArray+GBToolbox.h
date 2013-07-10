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
-(id)randomObject;

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

#pragma mark - Description

//returns the array concatenated by ", "
@property (copy, nonatomic, readonly) NSString *shortStringRepresentation;
-(NSString *)shortStringRepresentation;

@end
