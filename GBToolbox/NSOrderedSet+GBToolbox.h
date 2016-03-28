//
//  NSOrderedSet+GBToolbox.h
//  GBToolbox
//
//  Created by Luka Mirosevic on 28/03/16.
//  Copyright © 2016 Luka Mirosevic. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSOrderedSet (GBToolbox)

/**
 Returns the index of the object that is identical to anObject, or NSNotFound if the set doesn't contain it.
 */
- (NSUInteger)indexOfObjectIdenticalTo:(id)anObject;

@end
