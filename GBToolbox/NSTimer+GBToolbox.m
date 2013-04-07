//
//  NSTimer+GBToolbox.m
//  GBToolbox
//
//  Created by Luka Mirosevic on 05/02/2013.
//  Copyright (c) 2013 Luka Mirosevic. All rights reserved.
//

#import "NSTimer+GBToolbox.h"

@implementation NSTimer (GBToolbox)

//blocks
+(NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)interval repeats:(BOOL)repeats withBlock:(void(^)(void))block {
    return [self _timerFactory:interval repeats:repeats withBlock:block shouldSchedule:YES];
}

+(NSTimer *)timerWithTimeInterval:(NSTimeInterval)interval repeats:(BOOL)repeats withBlock:(void(^)(void))block {
    return [self _timerFactory:interval repeats:repeats withBlock:block shouldSchedule:NO];
}

+(NSTimer *)_timerFactory:(NSTimeInterval)interval repeats:(BOOL)repeats withBlock:(void(^)(void))block shouldSchedule:(BOOL)shouldSchedule {
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[self instanceMethodSignatureForSelector:@selector(callBlock:)]];
    NSTimer *timer = shouldSchedule ?
    [NSTimer scheduledTimerWithTimeInterval:interval invocation:invocation repeats:repeats] :
    [NSTimer timerWithTimeInterval:interval invocation:invocation repeats:repeats];
    
    [invocation setTarget:timer];
    [invocation setSelector:@selector(callBlock:)];
    
    void(^copy)(void) = [block copy];
    [invocation setArgument:&copy atIndex:2];
    
    return timer;
}

-(void)callBlock:(void(^)(void))block {
    block();
}

@end
