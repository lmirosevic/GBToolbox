//
//  GBKeyboardListener.m
//  GBToolbox
//
//  Created by Luka Mirosevic on 22/05/2017.
//  Copyright © 2017 Goonbee e.U. All rights reserved.
//

#import "GBKeyboardListener.h"

#import "NSMapTable+GBToolbox.h"

@interface GBKeyboardListener ()

@property (assign, nonatomic, readwrite, getter=isVisible) BOOL                             visible;
@property (assign, nonatomic, readwrite) CGRect                                             keyboardFrame;

@property (strong, nonatomic) NSMapTable<id, NSMutableArray<GBKeyboardWillMoveBlock> *>     *contexts;

@end

@implementation GBKeyboardListener

#pragma mark - Life and Setup

+ (void)load {
    @autoreleasepool {
        [self sharedListener];
    }
}

- (id)init {
    if (self = [super init]) {
        _contexts = [NSMapTable weakToStrongObjectsMapTable];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_willShowNotification:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_willHideNotification:) name:UIKeyboardWillHideNotification object:nil];
    }
    
    return self;
}

+ (GBKeyboardListener *)sharedListener {
    static GBKeyboardListener *_sharedListener;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedListener = [[GBKeyboardListener alloc] init];
    });
    
    return _sharedListener;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Notifications

- (void)_willShowNotification:(NSNotification *)notification {
    NSTimeInterval duration = ((NSNumber *)notification.userInfo[UIKeyboardAnimationDurationUserInfoKey]).doubleValue;
    UIViewAnimationOptions curve = ((NSNumber *)notification.userInfo[UIKeyboardAnimationCurveUserInfoKey]).integerValue;
    CGRect endFrame = ((NSValue *)notification.userInfo[UIKeyboardFrameEndUserInfoKey]).CGRectValue;
    CGRect beginFrame = ((NSValue *)notification.userInfo[UIKeyboardFrameBeginUserInfoKey]).CGRectValue;
    
    self.visible = YES;
    self.keyboardFrame = endFrame;
    
    [self _fireListenersWithShown:YES beginFrame:beginFrame endFrame:endFrame animationDuration:duration animationCurve:curve];
}

- (void)_willHideNotification:(NSNotification *)notification {
    NSTimeInterval duration = ((NSNumber *)notification.userInfo[UIKeyboardAnimationDurationUserInfoKey]).doubleValue;
    UIViewAnimationOptions curve = ((NSNumber *)notification.userInfo[UIKeyboardAnimationCurveUserInfoKey]).integerValue;
    CGRect endFrame = ((NSValue *)notification.userInfo[UIKeyboardFrameEndUserInfoKey]).CGRectValue;
    CGRect beginFrame = ((NSValue *)notification.userInfo[UIKeyboardFrameBeginUserInfoKey]).CGRectValue;
    
    self.visible = NO;
    self.keyboardFrame = endFrame;
    
    [self _fireListenersWithShown:NO beginFrame:beginFrame endFrame:endFrame animationDuration:duration animationCurve:curve];
}


#pragma mark - Private

- (void)_fireListenersWithShown:(BOOL)shown beginFrame:(CGRect)beginFrame endFrame:(CGRect)endFrame animationDuration:(NSTimeInterval)animationDuration animationCurve:(UIViewAnimationOptions)animationCurve {
    for (id context in self.contexts) {
        for (GBKeyboardWillMoveBlock listener in self.contexts[context]) {
            listener(shown, beginFrame, endFrame, animationDuration, animationCurve);
        }
    }
}

#pragma mark - API

- (CGRect)frameInCoordinatesOfView:(UIView *)view {
    return [[UIApplication sharedApplication].windows.firstObject convertRect:self.keyboardFrame toView:view];
}

- (void)addListenerForContext:(id)context block:(GBKeyboardWillMoveBlock)block {
    if (!self.contexts[context]) {
        self.contexts[context] = [NSMutableArray new];
    }
    
    [self.contexts[context] addObject:block];
}

- (void)removeListenersForContext:(id)context {
    [self.contexts removeObjectForKey:context];
}

@end
