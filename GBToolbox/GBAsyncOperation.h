//
//  GBAsyncOperation.h
//  GBToolbox
//
//  Created by Luka Mirosevic on 22/11/16.
//  Copyright © 2016 Goonbee e.U.. All rights reserved.
//

@import Foundation;

@interface GBAsyncOperation : NSOperation

/**
 Init.
 */
- (nonnull instancetype)init NS_DESIGNATED_INITIALIZER;

/**
 The method that is called for subclasses to do their work. You must override this method WITHOUT calling super. When your work is completed, you must call `completeAsyncOperation`. This method is called on the same thread as start was called for the operation.
 */
- (void)main;

/**
 You must also override cancel, and call `completeAsyncOperation` somewhere in your implementation. You SHOULD call super first.
 */
- (void)cancel;

/**
 Marks this operation as completed and sends all the right KVO notifications as per the NSOperation subsclassing contract.
 */
- (void)completeAsyncOperation;

@end
