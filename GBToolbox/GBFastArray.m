//
//  GBFastArray.m
//  GBToolbox
//
//  Created by Luka Mirosevic on 01/05/2013.
//  Copyright (c) 2013 Luka Mirosevic. All rights reserved.
//

#import "GBFastArray.h"

static CGFloat const kDefaultResizingFactor = 1.5;
static CGFloat const kDefaultInitialCapacity = 100;

@implementation GBFastArray {
    NSUInteger  _allocationSize;
    NSUInteger  _lastElementIndex;
    NSUInteger  _typeSize;
    CGFloat     _resizingFactor;
    char        *_theArray;
}

#pragma mark - Public API: Init

- (instancetype)initWithTypeSize:(NSUInteger)typeSize {
    return [self initWithTypeSize:typeSize initialCapacity:kDefaultInitialCapacity resizingFactor:kDefaultResizingFactor];
}

- (instancetype)initWithTypeSize:(NSUInteger)typeSize initialCapacity:(NSUInteger)initialCapacity resizingFactor:(CGFloat)resizingFactor {
    if (self = [super init]) {
        //State
        _typeSize = typeSize;
        _allocationSize = initialCapacity;
        _lastElementIndex = NSUIntegerMax;
        [self setResizingFactor:resizingFactor];
        
        //Alloc array
        _theArray = malloc(_typeSize * _allocationSize);
    }
    
    return self;
}

- (void)dealloc {
    //clean up array
    free(_theArray);
}

#pragma mark - Public API: Properties

- (NSUInteger)count {
    if (_lastElementIndex == NSUIntegerMax) {
        return 0;
    }
    else {
        return _lastElementIndex + 1;
    }
}

- (BOOL)isEmpty {
    return (_lastElementIndex == NSUIntegerMax);
}

#pragma mark - Public API: Querying

- (void)insertItem:(void *)itemAddress atIndex:(NSUInteger)index {
    //if its too short, resize the array
    if (index >= _allocationSize) {
        [self reallocToSize:(_allocationSize * _resizingFactor)];
    }
    
    //if it stretches the lastElementIndex, set it
    if (index > _lastElementIndex || _lastElementIndex == NSUIntegerMax) {
        _lastElementIndex = index;
    }
    
    //put it in
    memcpy(_theArray + (index * _typeSize), itemAddress, _typeSize);
}

- (void)appendItem:(void *)itemAddress {
    [self insertItem:itemAddress atIndex:_lastElementIndex + 1];
}

- (void *)itemAtIndex:(NSUInteger)index {
    return _theArray + (index * _typeSize);
}

#pragma mark - Public API: Searching

- (NSUInteger)binarySearchForIndexWithSearchLambda:(SearchLambda)searchLambda {
    return [self binarySearchForIndexWithLow:0 high:_lastElementIndex searchLambda:searchLambda];
}

- (NSUInteger)binarySearchForIndexWithLow:(NSUInteger)lowIndex high:(NSUInteger)highIndex searchLambda:(SearchLambda)searchLambda {
    //make sure its well formed
    if (searchLambda && lowIndex <= highIndex) {
        //prepare
        NSUInteger midIndex;
        GBSearchResult searchResult;
        
        //search while the subarray has at least 1 item
        while (highIndex >= lowIndex) {
            //calculate midpoint (as simple downrounded average)
            midIndex = (highIndex+lowIndex)*0.5;
            
            //eval our search lambda
            searchResult = searchLambda([self itemAtIndex:midIndex]);
            
            switch (searchResult) {
                case GBSearchResultMatch: {
                    return midIndex;
                } break;
                    
                case GBSearchResultHigh: {
                    if (midIndex == 0) return kGBSearchResultNotFound;
                    
                    highIndex = midIndex - 1;
                } break;
                    
                case GBSearchResultLow: {
                    if (midIndex == _lastElementIndex) return kGBSearchResultNotFound;
                    
                    lowIndex = midIndex + 1;
                } break;
            }
        }
    }
    
    //if we got here it means we didnt find anything, or the params were bad
    return kGBSearchResultNotFound;
}

#pragma mark - Public API: Size management

- (NSUInteger)typeSize {
    return _typeSize;
}

-( NSUInteger)currentAllocationSize {
    return _allocationSize;
}

- (void)reallocToSize:(NSUInteger)newSize {
    _allocationSize = newSize;
    _theArray = realloc(_theArray, (newSize * _typeSize));
    
    if (newSize < self.count) {
        _lastElementIndex = newSize - 1;
    }
}

- (void)setResizingFactor:(CGFloat)resizingFactor {
    if (resizingFactor > 1.0) {
        _resizingFactor = resizingFactor;
    }
    else {
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"Resizing factor must be bigger than 1.0" userInfo:@{@"resizingFactor": @(resizingFactor)}];
    }
}

@end
