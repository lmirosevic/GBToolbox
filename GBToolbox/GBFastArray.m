//
//  GBFastArray.m
//  GBToolbox
//
//  Created by Luka Mirosevic on 01/05/2013.
//  Copyright (c) 2013 Luka Mirosevic. All rights reserved.
//

#import "GBFastArray.h"

NSString * const GBBadParameterException = @"GBBadParameterException";

static CGFloat const kDefaultResizingFactor = 1.5;
static CGFloat const kDefaultInitialCapacity = 100;

@implementation GBFastArray {
    NSUInteger  _arraySize;
    NSUInteger  _typeSize;
    CGFloat     _resizingFactor;
    char        *_theArray;
}

#pragma mark - Memory

-(id)initWithTypeSize:(NSUInteger)typeSize {
    return [self initWithTypeSize:typeSize initialCapacity:kDefaultInitialCapacity resizingFactor:kDefaultResizingFactor];
}

-(id)initWithTypeSize:(NSUInteger)typeSize initialCapacity:(NSUInteger)initialCapacity resizingFactor:(CGFloat)resizingFactor {
    if (self = [super init]) {
        //State
        _typeSize = typeSize;
        _arraySize = initialCapacity;
        [self setResizingFactor:resizingFactor];
        
        //Alloc array
        _theArray = malloc(_typeSize * _arraySize);
    }
    
    return self;
}

-(void)dealloc {
    //clean up array
    free(_theArray);
}

#pragma mark - Querying

-(void)insertItem:(void *)itemAddress atIndex:(NSUInteger)index {
    //if its too short, resize the array
    if (index >= _arraySize) {
        [self reallocToSize:(_arraySize * _resizingFactor)];
    }
    
    //put it in
    memcpy(_theArray + (index * _typeSize), itemAddress, _typeSize);
}

-(void *)itemAtIndex:(NSUInteger)index {
    return _theArray + (index * _typeSize);
}

#pragma mark - Size management

-(NSUInteger)typeSize {
    return _typeSize;
}

-(NSUInteger)currentArraySize {
    return _arraySize;
}

-(void)reallocToSize:(NSUInteger)newSize {
    _arraySize = newSize;
    _theArray = realloc(_theArray, (newSize * _typeSize));
}

-(void)setResizingFactor:(CGFloat)resizingFactor {
    if (resizingFactor > 1.0) {
        _resizingFactor = resizingFactor;
    }
    else {
        @throw [NSException exceptionWithName:GBBadParameterException reason:@"Resizing factor must be bigger than 1.0" userInfo:@{@"resizingFactor": @(resizingFactor)}];
    }
}

@end
