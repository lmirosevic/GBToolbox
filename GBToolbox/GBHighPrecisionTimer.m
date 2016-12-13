//
//  GBHighPrecisionTimer.m
//  GBToolbox
//
//  Created by Luka Mirosevic on 13/12/2016.
//  Copyright © 2016 Goonbee e.U.. All rights reserved.
//

#import "GBHighPrecisionTimer.h"

@interface GBHighPrecisionTimer ()

@property (copy, nonatomic)                         void(^block)();
@property (assign, nonatomic) NSTimeInterval        period;
@property (assign, nonatomic) BOOL                  repeats;
@property (strong, nonatomic) id                    selfRetainer;

@property (strong, nonatomic) dispatch_queue_t      queue;
@property (strong, nonatomic) dispatch_source_t     timer;

@end

@implementation GBHighPrecisionTimer

#pragma mark - CA

- (void)setBlock:(void (^)())block {
    // wrap the block so that we periodically check the repeats stuff, and if needed cancel ourselves
    __weak typeof(self) weakSelf = self;
    _block = [^{
        // call the actual block
        block();
        
        // if not repeating, then we stop ourselves now
        if (!weakSelf.repeats) {
            [weakSelf stop];
        }
    } copy];
}

#pragma mark - API

- (nonnull instancetype)initWithPeriod:(NSTimeInterval)period repeats:(BOOL)repeats block:(void(^ _Nonnull)(void))block {
    if (!block) @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"block must not be nil" userInfo:nil];
    
    if (self = [super init]) {
        self.block = block;
        self.period = period;
        self.repeats = repeats;
        self.selfRetainer = self;// creates the retain cycle
        
        // kick it off
        [self _schedule];
    }
    
    return self;
}

- (instancetype)initWithPeriod:(NSTimeInterval)period repeats:(BOOL)repeats taget:(id)target selector:(SEL)selector {
    if (!target) @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"target must not be nil" userInfo:nil];
    
    return [self initWithPeriod:period repeats:repeats block:^{
        ((void (*)(id, SEL))[target methodForSelector:selector])(target, selector);
    }];
}

- (void)fire {
    dispatch_async(self.queue, self.block);
}

- (void)stop {
    [self _unschedule];
    self.block = nil;// releases our block copy
    self.selfRetainer = nil;// breaks the retain cycle
}

#pragma mark - Private

- (void)_schedule {
    // Define a queue
    dispatch_queue_attr_t qosAttribute = dispatch_queue_attr_make_with_qos_class(DISPATCH_QUEUE_SERIAL, QOS_CLASS_USER_INITIATED, 0);
    self.queue = dispatch_queue_create("at.nineyards.OSNetworkTesting.OSNTHighPrecisionTimer.timerQueue", qosAttribute);
    self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, self.queue);
    dispatch_source_set_timer(self.timer, dispatch_walltime(NULL, 0), self.period * NSEC_PER_SEC, 0);
    
    // Callback when timer is fired
    dispatch_source_set_event_handler(self.timer, self.block);
    dispatch_resume(self.timer);
}

- (void)_unschedule {
    dispatch_source_cancel(self.timer);
    self.queue = nil;
    self.timer = nil;
}

@end
