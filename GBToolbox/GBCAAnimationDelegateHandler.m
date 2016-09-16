//
//  GBCAAnimationDelegateHandler.m
//  GBToolbox
//
//  Created by Luka Mirosevic on 16/09/2016.
//
//

#import "GBCAAnimationDelegateHandler.h"

#pragma mark - API

@implementation GBCAAnimationDelegateHandler

+ (nonnull instancetype)delegateWithDidStart:(nullable GBCAAnimationDidStartBlock)didStart didStop:(nullable GBCAAnimationDidStopBlock)didStop {
    GBCAAnimationDelegateHandler *delegate = [self.class new];
    delegate.didStart = didStart;
    delegate.didStop = didStop;
    
    return delegate;
}

#pragma mark - CAAnimationDelegate

- (void)animationDidStart:(CAAnimation *)animation {
    if (self.didStart) self.didStart(animation);
}

- (void)animationDidStop:(CAAnimation *)animation finished:(BOOL)flag {
    if (self.didStop) self.didStop(animation, flag);
}

@end

