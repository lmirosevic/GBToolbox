//
//  GBFastArray.h
//  GBToolbox
//
//  Created by Luka Mirosevic on 01/05/2013.
//  Copyright (c) 2013 Luka Mirosevic. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GBConstants_Common.h"

typedef enum {
    GBSearchResultMatch,
    GBSearchResultLow,
    GBSearchResultHigh,
} GBSearchResult;

//lambda for guiding binary search algo. there's no param for target item, but no need cuz it will get closed over from your calling context
typedef GBSearchResult(^SearchLambda)(void *candidateItem);

@interface GBFastArray : NSObject

@property (assign, nonatomic, readonly) NSUInteger      count;
@property (assign, nonatomic, readonly) BOOL            isEmpty;

/**
 Initializes the array with for a specific typesize.
 
 Example: [[GBFastArray alloc] initWithTypeSize:sizeof(MyStruct)];
 */
- (instancetype)initWithTypeSize:(NSUInteger)typeSize;

/**
 Initializes the array with for a specific typesize. 
 
 Initial capacity is the amount of contiguous memory allocated for the array, and the resizingFactor is the factor used for resizing the array, the new capacity will be oldCapacity * resizingFactor. Tune these values to find the right balance between minimizing the count of resizing operations (which are slow), whilst not overallocating memory (which is wasteful).
 
 Example: [[GBFastArray alloc] initWithTypeSize:sizeof(MyStruct)];
 */
- (instancetype)initWithTypeSize:(NSUInteger)typeSize initialCapacity:(NSUInteger)initialCapacity resizingFactor:(CGFloat)resizingFactor;

/**
 Inserts an item into the array. 
 
 The item is dereferenced and copied using memcpy.
 The array will resize itself in order to accomodate the new index. If you choose a large index, beware that memory will be allocated for all the intermediary items, that is GBFastArray is not a sparse array.
 
 Example: [myFastArray insertItem:&myItem atIndex:10];
 */
- (void)insertItem:(void *)itemAddress atIndex:(NSUInteger)index;

/**
 Appends an item to the end of the array, increasing the length of the array by 1. 
 
 The item is dereferenced and copied using memcpy. 
 This method does not reallocate memory for the array unless it has to.
 */
- (void)appendItem:(void *)itemAddress;

/**
 Returns a pointer to the item at the specific index. This is the actual item stored, and is not a copy, so beware that when dereferencing and changing, that these changes will persist.
 
 Example: MyStruct myItem = *(MyStruct *)[myFastArray itemAtIndex:10];
 */
- (void *)itemAtIndex:(NSUInteger)index;

/**
 Do a binary search through the array using the searchLambda predicate block
 */
- (NSUInteger)binarySearchForIndexWithSearchLambda:(SearchLambda)searchLambda;

/**
 Do a binary search through the array using the searchLambda predicate block. You can specify subarray in which to search using the lowIndex and highIndex.
 */
- (NSUInteger)binarySearchForIndexWithLow:(NSUInteger)lowIndex high:(NSUInteger)highIndex searchLambda:(SearchLambda)searchLambda;

/**
 Return the size in bytes of the type that is being stored in the array.
 */
- (NSUInteger)typeSize;

/**
 Return the length of the array.
 */
- (NSUInteger)currentAllocationSize;

/**
 Reallocate the array to a specific size. You don't need to call this methid as the array will resize itself, however if you know ahead of time that the array will have to resize itself multiple times in order to fulfill some set of operations, you can optimize this down to a single resizing by preemtively calling this method before you start your set of operations which will insert items into the array.
 */
- (void)reallocToSize:(NSUInteger)newSize;

/**
 You can adjust the resizingFactor here at any time.
 */
- (void)setResizingFactor:(CGFloat)resizingFactor;

@end
