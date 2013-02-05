//
//  NSTimer+GBToolbox.h
//  GBToolbox
//
//  Created by Luka Mirosevic on 05/02/2013.
//  Copyright (c) 2013 Luka Mirosevic. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (GBToolbox)

//blocks //foo make sure the blocks that are passed in get released properly, and that they release the pointers they themselves are closing over
typedef void(^HandlerBlock)(void);
+(NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)interval repeats:(BOOL)repeats withBlock:(HandlerBlock)handler;
+(NSTimer *)timerWithTimeInterval:(NSTimeInterval)interval repeats:(BOOL)repeats withBlock:(HandlerBlock)handler;

@end