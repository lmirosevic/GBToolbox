//
//  GBHighPrecisionTimer.h
//  GBToolbox
//
//  Created by Luka Mirosevic on 13/12/2016.
//  Copyright © 2016 Goonbee e.U.. All rights reserved.
//

@import Foundation;

@interface GBHighPrecisionTimer : NSObject

/**
 Initialises a new timer, that will call `block` every `period`.
 
 Warning: The object will retain itself for as long as the timer doesn't get stopped. The object will store a copy of the block and release it when the timer is stopped. `block` will be called on a background thread.
 */
- (nonnull instancetype)initWithPeriod:(NSTimeInterval)period repeats:(BOOL)repeats block:(void(^ _Nonnull)(void))block NS_DESIGNATED_INITIALIZER;

/**
 Initialises a new timer, that will call the `selector` on `target` every `period`.
 
 Warning: The object will retain itself for as long as the timer doesn't get stopped. `selector` will be called from a background thread.
 */
- (nonnull instancetype)initWithPeriod:(NSTimeInterval)period repeats:(BOOL)repeats taget:(nonnull id)target selector:(nonnull SEL)selector;

- (nonnull instancetype)init NS_UNAVAILABLE;

/**
 Fires the timer immediately. Will be called on a background thread.
 */
- (void)fire;

/**
 Stops the timer from firing again.
 */
- (void)stop;

@end
