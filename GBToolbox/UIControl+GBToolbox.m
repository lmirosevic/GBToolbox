//
//  UIControl+GBToolbox.m
//  GBToolbox
//
//  Created by Luka Mirosevic on 20/02/2016.
//  Copyright © 2016 Luka Mirosevic. All rights reserved.
//

#import "UIControl+GBToolbox.h"

#import "GBMacros_Common.h"
#import <objc/runtime.h>

@interface GBControlTargetActionTarget : NSObject

@property (copy, nonatomic) GBActionBlock block;

@end

@implementation GBControlTargetActionTarget

#pragma mark - API

+ (instancetype)targetActionTargetWithBlock:(GBActionBlock)block {
    GBControlTargetActionTarget *targetActionTarget = [self new];
    targetActionTarget.block = block;
    
    return targetActionTarget;
}

- (void)fireForSender:(id)sender event:(UIEvent *)event {
    if (self.block) self.block(sender, event);
}

@end

@interface UIControl ()

@property (strong, nonatomic, readonly) NSHashTable *targetActionTargets;

@end

@implementation UIControl (GBToolbox)

#pragma mark - CA

static void *AssociatedTargetActionsKey = &AssociatedTargetActionsKey;

- (NSHashTable *)targetActionTargets {
    NSHashTable *targetActionTargets = objc_getAssociatedObject(self, &AssociatedTargetActionsKey);
    
    // lazily create out hashTable
    if (!targetActionTargets) {
        targetActionTargets = [NSHashTable hashTableWithOptions:NSPointerFunctionsStrongMemory | NSPointerFunctionsObjectPointerPersonality];
        objc_setAssociatedObject(self, &AssociatedTargetActionsKey, targetActionTargets, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    return targetActionTargets;
}

#pragma mark - API

- (void)addTargetActionForControlEvents:(UIControlEvents)controlEvents withBlock:(GBActionBlock)block {
    // Create the target that will store and trigger the block, exposed by a method that we can pass to the target/action mechanism
    GBControlTargetActionTarget *target = [GBControlTargetActionTarget targetActionTargetWithBlock:block];
    
    // Retain our target, so it lives for as long as this object lives
    [self.targetActionTargets addObject:target];
    
    // Add the target using normal target/action, setting the action to our fire trigger
    [self addTarget:target action:@selector(fireForSender:event:) forControlEvents:controlEvents];
}

@end
