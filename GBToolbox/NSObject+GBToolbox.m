//
//  NSObject+GBToolbox.m
//  GBToolbox
//
//  Created by Luka Mirosevic on 05/02/2013.
//  Copyright (c) 2013 Luka Mirosevic. All rights reserved.
//

#import "NSObject+GBToolbox.h"

#import <objc/runtime.h>

@implementation NSObject (GBToolbox)

//user identifier for tracking objects
static char gbDescriptionKey;

-(void)setGbDescription:(NSString *)gbDescription {
    objc_setAssociatedObject(self, &gbDescriptionKey, gbDescription, OBJC_ASSOCIATION_COPY);
}

-(NSString *)gbDescription {
    return objc_getAssociatedObject(self, &gbDescriptionKey);
}

//pointer address
-(NSString *)pointerAddress {
    return [NSString stringWithFormat:@"%p", self];
}

@end
