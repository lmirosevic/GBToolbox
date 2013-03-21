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

//map function from functional programming
-(NSArray *)map:(id(^)(id object))function;

@end
