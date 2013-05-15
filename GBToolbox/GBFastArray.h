//
//  GBFastArray.h
//  GBToolbox
//
//  Created by Luka Mirosevic on 01/05/2013.
//  Copyright (c) 2013 Luka Mirosevic. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const GBBadParameterException;

extern NSUInteger const kGBSearchResultNotFound;

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

//Init
-(id)initWithTypeSize:(NSUInteger)typeSize;
-(id)initWithTypeSize:(NSUInteger)typeSize initialCapacity:(NSUInteger)initialCapacity resizingFactor:(CGFloat)resizingFactor;

//Querying
-(void)insertItem:(void *)itemAddress atIndex:(NSUInteger)index;
-(void *)itemAtIndex:(NSUInteger)index;

//Searching
-(NSUInteger)binarySearchForIndexWithSearchLambda:(SearchLambda)searchLambda;
-(NSUInteger)binarySearchForIndexWithLow:(NSUInteger)lowIndex high:(NSUInteger)highIndex searchLambda:(SearchLambda)searchLambda;

//Size management
-(NSUInteger)typeSize;
-(NSUInteger)currentAllocationSize;
-(void)reallocToSize:(NSUInteger)newSize;
-(void)setResizingFactor:(CGFloat)resizingFactor;

@end
