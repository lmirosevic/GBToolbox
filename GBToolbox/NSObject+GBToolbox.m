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

_associatedObject(copy, nonatomic, NSString *, GBDescription, setGBDescription)
_associatedObject(copy, nonatomic, NSString *, GBIdentifier, setGBIdentifier)

-(NSString *)pointerAddress {
    return [NSString stringWithFormat:@"%p", self];
}

@end
