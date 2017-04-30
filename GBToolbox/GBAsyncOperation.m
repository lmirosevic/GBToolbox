//
//  GBAsyncOperation.m
//  GBToolbox
//
//  Created by Luka Mirosevic on 22/11/16.
//  Copyright © 2016 Goonbee e.U.. All rights reserved.
//

#import "GBAsyncOperation.h"

@implementation GBAsyncOperation {
    BOOL    _executing;
    BOOL    _finished;
}

#pragma mark - API

- (instancetype)init {
    if (self = [super init]) {
        _executing = NO;
        _finished = NO;
    }
    
    return self;
}

- (void)completeAsyncOperation {
    [self willChangeValueForKey:@"isFinished"];
    [self willChangeValueForKey:@"isExecuting"];
    
    _executing = NO;
    _finished = YES;
    
    [self didChangeValueForKey:@"isExecuting"];
    [self didChangeValueForKey:@"isFinished"];
}

#pragma mark - Overrides

- (void)main {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:@"You must override main in your NSOperation subclass." userInfo:nil];
}

- (void)start {
    // Always check for cancellation before launching the task.
    if (self.isCancelled) {
        // Must move the operation to the finished state if it is canceled.
        [self willChangeValueForKey:@"isFinished"];
        _finished = YES;
        [self didChangeValueForKey:@"isFinished"];
        
        return;
    }
    
    // If the operation is not canceled, begin executing the task.
    [self willChangeValueForKey:@"isExecuting"];
    [self performSelector:@selector(main)];// using performSelector to avoid NS_UNAVAILABLE compiler warning
    _executing = YES;
    [self didChangeValueForKey:@"isExecuting"];
}

- (void)cancel {
    // we implement this only so that we can highlight it in the interface, and to keep the compiler happy
    [super cancel];
}

- (BOOL)isConcurrent {
    return YES;
}

- (BOOL)isExecuting {
    return _executing;
}

- (BOOL)isFinished {
    return _finished;
}

@end
