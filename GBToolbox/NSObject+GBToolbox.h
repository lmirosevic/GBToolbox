//
//  NSObject+GBToolbox.h
//  GBToolbox
//
//  Created by Luka Mirosevic on 05/02/2013.
//  Copyright (c) 2013 Luka Mirosevic. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (GBToolbox)

/**
 An easy way to associate an arbitrary payload with an object. e.g. when you create a button which pertains to changing some model, you can attach the model to the button and then get to it in the button action method.
 */
@property (strong, nonatomic, nullable) id              GBPayload;

/**
 Returns the pointer address of an object as a string.
 */
@property (copy, nonatomic, readonly, nonnull) NSString *pointerAddress;

/**
 Yields self to the block, and then returns self. The primary purpose of this method is to “tap into” a method chain, in order to perform operations on intermediate results within the chain.
 */
- (nonnull instancetype)tap:(void (^ _Nonnull)(id _Nonnull object))block;

/**
 Returns the getter selector for a property with a name.
 */
+ (nullable SEL)getterForPropertyWithName:(nonnull NSString *)name;

/**
 Returns the setter selector for a property with a name.
 */
+ (nullable SEL)setterForPropertyWithName:(nonnull NSString *)name;

@end
