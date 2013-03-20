//
//  NSArray+GBToolbox.m
//  GBToolbox
//
//  Created by Luka Mirosevic on 20/03/2013.
//  Copyright (c) 2013 Luka Mirosevic. All rights reserved.
//

#import "NSArray+GBToolbox.h"

@implementation NSArray (GBToolbox)

//returns a random object from the array
-(id)randomObject {
    NSUInteger count = self.count;
    
    if (count > 0) {
        return self[arc4random_uniform(count)];
    }
    else {
        return nil;
    }
}

@end
