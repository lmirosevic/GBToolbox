//
//  NSMutableArray+GBToolbox.m
//  GBToolbox
//
//  Created by Luka Mirosevic on 17/05/2013.
//  Copyright (c) 2013 Luka Mirosevic. All rights reserved.
//

#import "NSMutableArray+GBToolbox.h"

#import "GBConstants_Common.h"

@implementation NSMutableArray (GBToolbox)

#pragma mark - Array padding
//These are all non-destructive and leave existing elements in, only when extendin the array do we actually pad it

//Pads the array out so the last index is the one that's passed in, with [NSNull null]
-(void)padToIndex:(NSUInteger)index {
    [self padToIndex:index withObject:[NSNull null]];
}

//Pads the array out so the last index is the one that's passed in, with any non nil object
-(void)padToIndex:(NSUInteger)index withObject:(id)object {
    [self padToSize:index+1 withObject:object];
}

//Pads the array out to the desired size with [NSNull null] objects
-(void)padToSize:(NSUInteger)count {
    [self padToSize:count withObject:[NSNull null]];
}

//Pads the array out to the desired size with any object you supply
-(void)padToSize:(NSUInteger)count withObject:(id)object {
    //make sure it's not nil
    if (object) {
        //if the size is already bigger or equal then we're done
        if (self.count >= count) {
            //noop
        }
        else {
            //enumerate from the last element+1 and assign until we are at the desired length
            for (NSUInteger i=self.count; i<count; i++) {
                self[i] = object;
            }
        }
    }
    //it is nil
    else {
        //...well that's no good
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"GBToolbox: tried to pad an array with nil, and arrays can't take nil" userInfo:nil];
    }
}

#pragma mark - Deleting

//Removes an object from the array by searching using pointer equality, rather than sending the isEqual: message
-(void)removeObjectByIdentity:(id)object {
    NSUInteger count = self.count;
    NSUInteger index = NSNotFound;
    id existingObject;
    for (NSUInteger i=0; i<count; i++) {
        existingObject = [self objectAtIndex:i];
        if (existingObject == object) {
            index = i;
            break;
        }
    }
    
    if (index != NSNotFound) {
        [self removeObjectAtIndex:index];
    }
}

@end
