//
//  NSObject+GBToolbox.h
//  GBToolbox
//
//  Created by Luka Mirosevic on 05/02/2013.
//  Copyright (c) 2013 Luka Mirosevic. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (GBToolbox)

//user identifier for annotating objects
@property (copy, nonatomic) NSString                *GBDescription;

//user identifier for tracking objects
@property (copy, nonatomic) NSString                *GBIdentifier;

//an easy way to associate some payload with an object. e.g. when you create a button which pertains to changing some model, you can attach the model to the button and then get to it in the button action method
@property (strong, nonatomic) id                    GBPayload;

//pointer address
@property (copy, nonatomic, readonly) NSString      *pointerAddress;

/**
 Yields self to the block, and then returns self. The primary purpose of this method is to “tap into” a method chain, in order to perform operations on intermediate results within the chain.
 */
- (instancetype)tap:(void (^)(id object))block;

@end
