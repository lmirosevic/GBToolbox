//
//  NSInvocation+GBToolbox.h
//  GBToolbox
//
//  Created by Luka Mirosevic on 30/04/2014.
//  Copyright (c) 2014 Luka Mirosevic. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSInvocation (GBToolbox)

+(NSInvocation *)invocationWithTarget:(id)target selector:(SEL)selector arguments:(void *)argument, ... NS_REQUIRES_NIL_TERMINATION;
+(NSInvocation *)invocationWithTarget:(id)target selector:(SEL)selector argument:(void *)argument argumentList:(va_list)argumentList;

@end
