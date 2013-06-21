//
//  GBMessageInterceptor.m
//  GBToolbox
//
//  Created by Luka Mirosevic on 21/06/2013.
//  Copyright (c) 2013 Luka Mirosevic. All rights reserved.
//
//  Originally from this SO answer: http://stackoverflow.com/a/3862591/399772


#import "GBMessageInterceptor.h"

@implementation GBMessageInterceptor

- (id)forwardingTargetForSelector:(SEL)aSelector {
    if ([_middleMan respondsToSelector:aSelector]) { return _middleMan; }
    if ([_receiver respondsToSelector:aSelector]) { return _receiver; }
    return [super forwardingTargetForSelector:aSelector];
}

- (BOOL)respondsToSelector:(SEL)aSelector {
    if ([[_middleMan superclass] instancesRespondToSelector:aSelector]) return NO;
    if ([_middleMan respondsToSelector:aSelector]) return YES;
    if ([_receiver respondsToSelector:aSelector]) return YES;
    return [super respondsToSelector:aSelector];
}

@end