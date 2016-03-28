//
//  NSOrderedSet+GBToolbox.m
//  GBToolbox
//
//  Created by Luka Mirosevic on 28/03/16.
//  Copyright © 2016 Luka Mirosevic. All rights reserved.
//

#import "NSOrderedSet+GBToolbox.h"

@implementation NSOrderedSet (GBToolbox)

- (NSUInteger)indexOfObjectIdenticalTo:(id)anObject {
    for (NSUInteger i=0; i<self.count; i++) {
        if (self[i] == anObject) {
            return i;
        }
    }
    
    return NSNotFound;
}

@end
