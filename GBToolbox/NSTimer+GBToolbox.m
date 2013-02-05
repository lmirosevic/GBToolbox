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
+(NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)interval repeats:(BOOL)repeats withBlock:(HandlerBlock)handler {
    //    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[self instanceMethodSignatureForSelector:@selector(callBlock:)]];
    //    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:interval invocation:invocation repeats:repeats];
    //    [invocation setTarget:timer];
    //    [invocation setSelector:@selector(callBlock:)];
    //
    //    HandlerBlock copy = [handler copy];
    //    //    Block_copy(handler);//foo make sure i'm not leaking blocks here, or causing a crash by not copying it
    //    [invocation setArgument:&copy atIndex:2];
    //    //    Block_release(handler);
    //
    //    return timer;
    
    return [self _timerFactory:interval repeats:repeats withBlock:handler shouldSchedule:YES];
}

+(NSTimer *)timerWithTimeInterval:(NSTimeInterval)interval repeats:(BOOL)repeats withBlock:(HandlerBlock)handler {
    return [self _timerFactory:interval repeats:repeats withBlock:handler shouldSchedule:NO];
}

+(NSTimer *)_timerFactory:(NSTimeInterval)interval repeats:(BOOL)repeats withBlock:(HandlerBlock)handler shouldSchedule:(BOOL)shouldSchedule {
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[self instanceMethodSignatureForSelector:@selector(callBlock:)]];
    NSTimer *timer = shouldSchedule ?
    [NSTimer scheduledTimerWithTimeInterval:interval invocation:invocation repeats:repeats] :
    [NSTimer timerWithTimeInterval:interval invocation:invocation repeats:repeats];
    
    [invocation setTarget:timer];
    [invocation setSelector:@selector(callBlock:)];
    
    HandlerBlock copy = [handler copy];
    //    Block_copy(handler);//foo make sure i'm not leaking blocks here, or causing a crash by not copying it
    [invocation setArgument:&copy atIndex:2];
    //    Block_release(handler);
    
    return timer;
}

-(void)callBlock:(HandlerBlock)block {
    block();
}

@end
