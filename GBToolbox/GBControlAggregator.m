//
//  GBControlAggregator.m
//  GBToolbox
//
//  Created by Luka Mirosevic on 20/02/2016.
//  Copyright © 2016 Goonbee e.U. All rights reserved.
//

#import "GBControlAggregator.h"

#import "GBMacros_Common.h"
#import "GBMacros_iOS.h"

@interface GBControlAggregator ()

@property (strong, nonatomic, readwrite) NSArray<__kindof UIControl *>      *controls;
@property (strong, nonatomic) UIStackView                                   *stackView;

@end

@implementation GBControlAggregator

#pragma mark - CA

- (void)setControls:(NSArray<__kindof UIControl *> *)controls {
    // remove the old controls
    NSArray *oldControls = self.stackView.arrangedSubviews;
    for (UIControl *oldControl in oldControls) {
        [self.stackView removeArrangedSubview:oldControl];
    }
    
    // add the new controls
    for (UIControl *newControl in controls) {
        [self.stackView addArrangedSubview:newControl];
    }
}

- (NSArray<UIControl *> *)controls {
    return self.stackView.arrangedSubviews;
}

#pragma mark - Life

- (instancetype)initWithControls:(NSArray<UIControl *> *)controls axis:(UILayoutConstraintAxis)axis {
    if (self = [super initWithFrame:CGRectZero]) {
        self.stackView = AutoLayout([[UIStackView alloc] initWithArrangedSubviews:controls]);
        self.stackView.axis = axis;
        self.stackView.alignment = UIStackViewAlignmentCenter;
        self.stackView.distribution = UIStackViewDistributionEqualCentering;
        [self addSubview:self.stackView];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[stackView]|" options:0 metrics:nil views:@{@"stackView": self.stackView}]];// full width
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[stackView]|" options:0 metrics:nil views:@{@"stackView": self.stackView}]];// full height
    }
    
    return self;
}

#pragma mark - Override

- (void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents {
    [super addTarget:target action:action forControlEvents:controlEvents];
    
    // we just modified our target/actions, so we need to propagate these to our controls
    for (UIControl *control in self.stackView.arrangedSubviews) {
        [self _configureControlToForwardEvents:control];
    }
}

#pragma mark - Private

- (void)_configureControlToForwardEvents:(UIControl *)control {
    // clean up all of control's previous target/actions
    [control removeTarget:nil action:NULL forControlEvents:UIControlEventAllEvents];
    
    // get all my target/actions
    for (id target in self.allTargets) {
        // ... set these on the new control, so that the new control will
        
        // UIControlEventTouchDown
        for (NSString *action in [self actionsForTarget:target forControlEvent:UIControlEventTouchDown]) {
            [control addTarget:target action:NSSelectorFromString(action) forControlEvents:UIControlEventTouchDown];
        }
        
        // UIControlEventTouchDownRepeat
        for (NSString *action in [self actionsForTarget:target forControlEvent:UIControlEventTouchDownRepeat]) {
            [control addTarget:target action:NSSelectorFromString(action) forControlEvents:UIControlEventTouchDownRepeat];
        }
        
        // UIControlEventTouchDragInside
        for (NSString *action in [self actionsForTarget:target forControlEvent:UIControlEventTouchDragInside]) {
            [control addTarget:target action:NSSelectorFromString(action) forControlEvents:UIControlEventTouchDragInside];
        }
        
        // UIControlEventTouchDragOutside
        for (NSString *action in [self actionsForTarget:target forControlEvent:UIControlEventTouchDragOutside]) {
            [control addTarget:target action:NSSelectorFromString(action) forControlEvents:UIControlEventTouchDragOutside];
        }
        
        // UIControlEventTouchDragEnter
        for (NSString *action in [self actionsForTarget:target forControlEvent:UIControlEventTouchDragEnter]) {
            [control addTarget:target action:NSSelectorFromString(action) forControlEvents:UIControlEventTouchDragEnter];
        }
        
        // UIControlEventTouchDragExit
        for (NSString *action in [self actionsForTarget:target forControlEvent:UIControlEventTouchDragExit]) {
            [control addTarget:target action:NSSelectorFromString(action) forControlEvents:UIControlEventTouchDragExit];
        }
        
        // UIControlEventTouchUpInside
        for (NSString *action in [self actionsForTarget:target forControlEvent:UIControlEventTouchUpInside]) {
            [control addTarget:target action:NSSelectorFromString(action) forControlEvents:UIControlEventTouchUpInside];
        }
        
        // UIControlEventTouchUpOutside
        for (NSString *action in [self actionsForTarget:target forControlEvent:UIControlEventTouchUpOutside]) {
            [control addTarget:target action:NSSelectorFromString(action) forControlEvents:UIControlEventTouchUpOutside];
        }
        
        // UIControlEventTouchCancel
        for (NSString *action in [self actionsForTarget:target forControlEvent:UIControlEventTouchCancel]) {
            [control addTarget:target action:NSSelectorFromString(action) forControlEvents:UIControlEventTouchCancel];
        }
        
        // UIControlEventValueChanged
        for (NSString *action in [self actionsForTarget:target forControlEvent:UIControlEventValueChanged]) {
            [control addTarget:target action:NSSelectorFromString(action) forControlEvents:UIControlEventValueChanged];
        }
        
        // UIControlEventPrimaryActionTriggered
        for (NSString *action in [self actionsForTarget:target forControlEvent:UIControlEventPrimaryActionTriggered]) {
            [control addTarget:target action:NSSelectorFromString(action) forControlEvents:UIControlEventPrimaryActionTriggered];
        }
        
        // UIControlEventEditingDidBegin
        for (NSString *action in [self actionsForTarget:target forControlEvent:UIControlEventEditingDidBegin]) {
            [control addTarget:target action:NSSelectorFromString(action) forControlEvents:UIControlEventEditingDidBegin];
        }
        
        // UIControlEventEditingChanged
        for (NSString *action in [self actionsForTarget:target forControlEvent:UIControlEventEditingChanged]) {
            [control addTarget:target action:NSSelectorFromString(action) forControlEvents:UIControlEventEditingChanged];
        }
        
        // UIControlEventEditingDidEnd
        for (NSString *action in [self actionsForTarget:target forControlEvent:UIControlEventEditingDidEnd]) {
            [control addTarget:target action:NSSelectorFromString(action) forControlEvents:UIControlEventEditingDidEnd];
        }
        
        // UIControlEventEditingDidEndOnExit
        for (NSString *action in [self actionsForTarget:target forControlEvent:UIControlEventEditingDidEndOnExit]) {
            [control addTarget:target action:NSSelectorFromString(action) forControlEvents:UIControlEventEditingDidEndOnExit];
        }
    }
}

@end
