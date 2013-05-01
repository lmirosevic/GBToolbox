//
//  GBFastArray.h
//  GBToolbox
//
//  Created by Luka Mirosevic on 01/05/2013.
//  Copyright (c) 2013 Luka Mirosevic. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const GBBadParameterException;

@interface GBFastArray : NSObject

//Init
-(id)initWithTypeSize:(NSUInteger)typeSize;
-(id)initWithTypeSize:(NSUInteger)typeSize initialCapacity:(NSUInteger)initialCapacity resizingFactor:(CGFloat)resizingFactor;

//Querying
-(void)insertItem:(void *)itemAddress atIndex:(NSUInteger)index;
-(void *)itemAtIndex:(NSUInteger)index;

//Size management
-(NSUInteger)typeSize;
-(NSUInteger)currentArraySize;
-(void)reallocToSize:(NSUInteger)newSize;
-(void)setResizingFactor:(CGFloat)resizingFactor;

@end
