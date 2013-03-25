//
//  NSArray+GBToolbox.h
//  GBToolbox
//
//  Created by Luka Mirosevic on 20/03/2013.
//  Copyright (c) 2013 Luka Mirosevic. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (GBToolbox)

//returns a random object from the array
-(id)randomObject;

//functional map
-(NSArray *)map:(id(^)(id object))function;

//functional fold left
-(id)foldLeft:(id(^)(id objectA, id objectB))function lastObject:(id)lastObject;

//functional fold right
-(id)foldRight:(id(^)(id objectA, id objectB))function initialObject:(id)initialObject;

//synonym for foldLeft
-(id)reduce:(id(^)(id objectA, id objectB))function lastObject:(id)lastObject;

@end
