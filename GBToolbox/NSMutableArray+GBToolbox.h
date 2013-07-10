//
//  NSMutableArray+GBToolbox.h
//  GBToolbox
//
//  Created by Luka Mirosevic on 17/05/2013.
//  Copyright (c) 2013 Luka Mirosevic. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (GBToolbox)

#pragma mark - Array padding
//These are all non-destructive and leave existing elements in, only when extendin the array do we actually pad it

//Pads the array out so the last index is the one that's passed in, with [NSNull null]
-(void)padToIndex:(NSUInteger)index;

//Pads the array out so the last index is the one that's passed in, with any non nil object
-(void)padToIndex:(NSUInteger)index withObject:(id)object;

//Pads the array out to the desired size with [NSNull null] objects
-(void)padToSize:(NSUInteger)count;

//Pads the array out to the desired size with any object you supply
-(void)padToSize:(NSUInteger)count withObject:(id)object;

#pragma mark - Deleting

//Removes an object from the array by searching using pointer equality, rather than sending the isEqual: message
-(void)removeObjectByIdentity:(id)object;

@end
