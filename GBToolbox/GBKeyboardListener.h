//
//  GBKeyboardListener.h
//  GBToolbox
//
//  Created by Luka Mirosevic on 22/05/2017.
//  Copyright © 2017 Goonbee e.U. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 The block that is called when the keyboard moves.
 */
typedef void(^GBKeyboardWillMoveBlock)(BOOL willShow, CGRect beginFrame, CGRect endFrame, NSTimeInterval animationDuration, UIViewAnimationOptions animationCurve);

/**
 A class for listening on changes to the keyboard.
 */
@interface GBKeyboardListener : NSObject

+ (nonnull GBKeyboardListener *)sharedListener;

/**
 Whether or not the keyboard is currently visible.
 */
@property (assign, nonatomic, readonly, getter=isVisible) BOOL visible;

/**
 The frame of the keyboard, in screen coordinates.
 */
@property (assign, nonatomic, readonly) CGRect keyboardFrame;

/**
 Returns the rect of the keyboard, translated to view's coordinates.
 */
- (CGRect)frameInCoordinatesOfView:(nonnull UIView *)view;

/**
 Adds a block in a context.
 */
- (void)addListenerForContext:(nonnull id)context block:(nonnull GBKeyboardWillMoveBlock)block;

/**
 Removes all notification blocks in a certain context.
 */
- (void)removeListenersForContext:(nonnull id)context;

@end
