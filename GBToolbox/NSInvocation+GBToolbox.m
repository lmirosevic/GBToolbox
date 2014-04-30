//
//  NSInvocation+GBToolbox.m
//  GBToolbox
//
//  Created by Luka Mirosevic on 30/04/2014.
//  Copyright (c) 2014 Luka Mirosevic. All rights reserved.
//

#import "NSInvocation+GBToolbox.h"

@implementation NSInvocation (GBToolbox)

+(NSInvocation *)invocationWithTarget:(id)target selector:(SEL)selector arguments:(void *)argument, ... NS_REQUIRES_NIL_TERMINATION {
    va_list argumentList;
    va_start(argumentList, argument);
    NSInvocation *invocation = [self invocationWithTarget:target selector:selector argument:argument argumentList:argumentList];
    va_end(argumentList);
    
    return invocation;
}

+(NSInvocation *)invocationWithTarget:(id)target selector:(SEL)selector argument:(void *)argument argumentList:(va_list)argumentList {
    // prepare the invocation
    NSMethodSignature *methodSignature = [[target class] instanceMethodSignatureForSelector:selector];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSignature];
    [invocation setTarget:target];
    [invocation setSelector:selector];
    void *anArgumentPointer;
    
    if (argument) {
        [invocation setArgument:argument atIndex:2];
        NSUInteger counter = 3;
        while ((anArgumentPointer = va_arg(argumentList, void *))) {
            [invocation setArgument:anArgumentPointer atIndex:counter];
            counter += 1;
        }
    }
    [invocation retainArguments];
    
    return invocation;
}

@end
