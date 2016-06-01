//
//  NSObject+GBToolbox.m
//  GBToolbox
//
//  Created by Luka Mirosevic on 05/02/2013.
//  Copyright (c) 2013 Luka Mirosevic. All rights reserved.
//

#import "NSObject+GBToolbox.h"

#import "GBMacros_Common.h"

@implementation NSObject (GBToolbox)

_associatedObject(strong, nonatomic, id, GBPayload, setGBPayload)

- (nonnull NSString *)pointerAddress {
    return [NSString stringWithFormat:@"%p", self];
}

- (nonnull instancetype)tap:(void (^ _Nonnull)(id _Nonnull object))block {
    if (block) block(self);
    
    return self;
}

@end
