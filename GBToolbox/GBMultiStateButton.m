//
//  GBMultiStateButton.m
//  GBToolbox
//
//  Created by Luka Mirosevic on 24/02/16.
//  Copyright © 2016 Luka Mirosevic. All rights reserved.
//

#import "GBMultiStateButton.h"

#import "GBMacros_Common.h"
#import "GBMacros_iOS.h"
#import "NSArray+GBToolbox.h"

@interface GBMultiStateButton ()

@property (strong, nonatomic, readwrite) NSArray <GBMultiStateButtonState *>    *states;
@property (strong, nonatomic) UIButton                                          *button;

@end

@implementation GBMultiStateButton

#pragma mark - CA

- (void)setAdjustsImageWhenHighlighted:(BOOL)adjustsImageWhenHighlighted {
    self.button.adjustsImageWhenHighlighted = adjustsImageWhenHighlighted;
}

- (BOOL)adjustsImageWhenHighlighted {
    return self.button.adjustsImageWhenHighlighted;
}

- (void)setStates:(NSArray<GBMultiStateButtonState *> *)states {
    AssertParameterNotNil(states);
    
    // Make sure that the state identifiers are all unique, by adding them to a set and making sure it's the same length
    NSUInteger uniqueCount = [NSSet setWithArray:[states map:^id(id object) {
        return ((GBMultiStateButtonState *)object).stateIdentifier;
    }]].count;
    if (uniqueCount != states.count) @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"Passed in an array of states where some of the states have duplicate stateIdentifiers. These must be unique, and are compared with isEqual:" userInfo:nil];
    
    // Store the states
    _states = states;
    
    // Commit the active state as the first object
    self.activeState = states.firstObject;
}

- (void)setActiveState:(GBMultiStateButtonState *)activeState {
    AssertParameterNotNil(activeState);
    
    // Make sure this state exists
    if (![self.states containsObject:activeState]) @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"Trying to set a state as active which does not exist." userInfo:nil];
    
    // Store the ivar
    _activeState = activeState;
    
    // Visually activate the state
    [self.button setImage:activeState.image forState:UIControlStateNormal];
    [self.button setBackgroundImage:activeState.backgroundImage forState:UIControlStateNormal];
    [self.button setImage:activeState.imageWhenHighlighted forState:UIControlStateHighlighted];
    [self.button setBackgroundImage:activeState.backgroundImageWhenHighlighted forState:UIControlStateHighlighted];
}

- (id)activeStateIdentifier {
    return self.activeState.stateIdentifier;
}

- (void)setActiveStateIdentifier:(id)activeStateIdentifier {
    AssertParameterNotNil(activeStateIdentifier);
    
    self.activeState = [self.states first:^BOOL(id object) {
        return [((GBMultiStateButtonState *)object).stateIdentifier isEqual:activeStateIdentifier];
    }];
}

#pragma mark - Life

- (instancetype)initWithStates:(NSArray<GBMultiStateButtonState *> *)states {
    AssertParameterNotNil(states);
    
    // make sure that at least one of the states is user selectable
    if (![states any:^BOOL(id object) {
        return ((GBMultiStateButtonState *)object).isUserSelectable;
    }]) {
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"Must pass at least one user selectable state!" userInfo:nil];
    }
    
    if (self = [super init]) {
        // create the button first
        self.button = AutoLayout([UIButton buttonWithType:UIButtonTypeCustom]);
        [self.button addTarget:self action:@selector(_changeState) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.button];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[button]|" options:0 metrics:nil views:@{@"button": self.button}]];// full width
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[button]|" options:0 metrics:nil views:@{@"button": self.button}]];// full height
        
        // the commit the states
        self.states = states;
    }
    
    return self;
}

#pragma mark - Overrides

- (CGSize)intrinsicContentSize {
    return self.button.intrinsicContentSize;
}

#pragma mark - Private

- (void)_changeState {
    // Get the next state index
    NSUInteger currentStateIndex = [self.states indexOfObject:self.activeState];
    if (currentStateIndex == NSNotFound) @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:@"Cannot be possible that self.activeState isn't in self.states." userInfo:nil];
    
    // Increment the state
    NSUInteger nextStateIndex = currentStateIndex;
    while (YES) {
        // get the next candidate
        nextStateIndex = (nextStateIndex + 1) % self.states.count;
        
        // make sure it's user selectable
        if (self.states[nextStateIndex].isUserSelectable) {
            self.activeState = self.states[nextStateIndex];
            break;
        }
    }
    
    // Notify via target/action
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

@end

@implementation GBMultiStateButtonState

+ (instancetype)stateWithIdentifier:(id)identifier image:(UIImage *)image {
    return [self stateWithIdentifier:identifier image:image backgroundImage:nil];
}

+ (instancetype)stateWithIdentifier:(id)identifier image:(UIImage *)image backgroundImage:(UIImage *)backgroundImage {
    return [self stateWithIdentifier:identifier image:image backgroundImage:backgroundImage imageWhenHighlighted:nil backgroundImageWhenHighlighted:nil];
}

+ (instancetype)stateWithIdentifier:(id)identifier image:(UIImage *)image backgroundImage:(UIImage *)backgroundImage imageWhenHighlighted:(UIImage *)imageWhenHighlighted backgroundImageWhenHighlighted:(UIImage *)backgroundImageWhenHighlighted {
    return [self stateWithIdentifier:identifier image:image backgroundImage:backgroundImage imageWhenHighlighted:imageWhenHighlighted backgroundImageWhenHighlighted:backgroundImageWhenHighlighted userSelectable:YES];
}

+ (instancetype)stateWithIdentifier:(id)identifier image:(UIImage *)image backgroundImage:(UIImage *)backgroundImage imageWhenHighlighted:(UIImage *)imageWhenHighlighted backgroundImageWhenHighlighted:(UIImage *)backgroundImageWhenHighlighted userSelectable:(BOOL)userSelectable {
    GBMultiStateButtonState *state = [self.class new];
    state.stateIdentifier = identifier;
    state.image = image;
    state.backgroundImage = backgroundImage;
    state.imageWhenHighlighted = imageWhenHighlighted;
    state.backgroundImageWhenHighlighted = backgroundImageWhenHighlighted;
    state.userSelectable = userSelectable;
    
    return state;
}

@end
