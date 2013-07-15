//
//  GBCompletable.m
//  GBToolbox
//
//  Created by Luka Mirosevic on 15/07/2013.
//  Copyright (c) 2013 Luka Mirosevic. All rights reserved.
//

#import "GBCompletable.h"

@interface GBCompletable ()

@property (copy, nonatomic) VoidBlock                           successCallback;
@property (copy, nonatomic) VoidBlock                           failCallback;
@property (copy, nonatomic) VoidBlock                           resolveCallback;

@property (assign, nonatomic, readwrite) GBCompletableState      state;

@end

@implementation GBCompletable

#pragma mark - life

+(GBCompletable *)completableWithSuccess:(VoidBlock)success fail:(VoidBlock)fail resolve:(VoidBlock)resolve {
    return [[self alloc] initWithSuccess:success fail:fail resolve:resolve];
}
            
-(id)initWithSuccess:(VoidBlock)success fail:(VoidBlock)fail resolve:(VoidBlock)resolve {
    if (self = [super init]) {
        self.successCallback = success;
        self.failCallback = fail;
        self.resolveCallback = resolve;
        
        self.state = GBCompletableStateUnresolved;
    }
    
    return self;
}

#pragma mark - CA

-(void)setState:(GBCompletableState)state {
    _state = state;
    
    switch (state) {
        case GBCompletableStateUnresolved: {
            _isResolved = NO;
            _isCompleted = NO;
            _isFailed = NO;
        } break;
            
        case GBCompletableStateSuccess: {
            _isResolved = YES;
            _isCompleted = YES;
            _isFailed = NO;
        } break;
            
        case GBCompletableStateFailed: {
            _isResolved = YES;
            _isCompleted = NO;
            _isFailed = YES;
        } break;
    }
}

-(void)setCompletedCallback:(VoidBlock)successCallback {
    _successCallback = [successCallback copy];
    [self _success];
}

-(void)setFailCallback:(VoidBlock)failCallback {
    _failCallback = [failCallback copy];
    [self _fail];
}

-(void)success {
    [self _success];
}

-(void)fail {
    [self _fail];
}

#pragma mark - util
        
-(void)_success {
    if (_isResolved == NO) {
        self.state = GBCompletableStateSuccess;
        [self _processSuccessCallback];
        [self _processResolveCallback];
    }
}

-(void)_fail {
    if (_isResolved == NO) {
        self.state = GBCompletableStateFailed;
        [self _processFailCallback];
        [self _processResolveCallback];
    }
}

-(void)_processSuccessCallback {
    if (self.successCallback) self.successCallback();
    self.successCallback = nil;
}

-(void)_processFailCallback {
    if (self.failCallback) self.failCallback();
    self.failCallback = nil;
}

-(void)_processResolveCallback {
    if (self.resolveCallback) self.resolveCallback();
    self.resolveCallback = nil;
}
        
@end
