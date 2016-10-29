//
//  NSSet+GBToolbox.h
//  GBToolbox
//
//  Created by Luka Mirosevic on 28/03/16.
//  Copyright © 2016 Luka Mirosevic. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSSet<__covariant ObjectType> (GBToolbox)

/**
 Returns YES if any the function returns YES for at least one object in the set.
 */
- (BOOL)contains:(BOOL(^ _Nonnull)(ObjectType _Nonnull object))function;

/**
 Returns a copy of the array containing only the objects for which function returns YES.
 */
- (nonnull NSSet<ObjectType> *)filter:(BOOL(^ _Nonnull)(ObjectType _Nonnull object))function;

/**
 Returns the first object for which the function returns YES, nil otherwise.
 
 First might be undeterministic for an NSSet, so this is really only useful for when you know that only 1 object in the set will return YES for the function.
 */
- (nullable ObjectType)first:(BOOL(^ _Nonnull)(ObjectType _Nonnull object))function;

@end
