//
//  NSTimer+GBToolbox.h
//  GBToolbox
//
//  Created by Luka Mirosevic on 05/02/2013.
//  Copyright (c) 2013 Luka Mirosevic. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (GBToolbox)

//blocks
+(NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)interval repeats:(BOOL)repeats withBlock:(void(^)(void))block;
+(NSTimer *)timerWithTimeInterval:(NSTimeInterval)interval repeats:(BOOL)repeats withBlock:(void(^)(void))block;

@end