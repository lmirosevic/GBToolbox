//
//  UIView+GBToolbox.m
//  GBToolbox
//
//  Created by Luka Mirosevic on 22/05/2013.
//  Copyright (c) 2013 Luka Mirosevic. All rights reserved.
//

#import "UIView+GBToolbox.h"

@implementation UIView (GBToolbox)

#pragma mark - Conveniences

- (void)removeAllSubviews {
    NSArray *subviews = [self.subviews copy];
    [subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
}

- (void)embedView:(UIView *)view {
    view.frame = self.bounds;
    [self addSubview:view];
}

- (BOOL)findAndResignFirstResponder {
    if (self.isFirstResponder) {
        [self resignFirstResponder];
        return YES;
    }
    for (UIView *subView in self.subviews) {
        if ([subView findAndResignFirstResponder]) {
            return YES;
        }
    }
    return NO;
}

- (UIViewController *)wrappingViewController {
    return [self wrappingViewControllerWithMargins:UIEdgeInsetsZero];
}

- (UIViewController *)wrappingViewControllerWithMargins:(UIEdgeInsets)margins {
    // Create a new View Controller
    UIViewController *viewController = [UIViewController new];
    
    // Add self as a subview, configuring Autolayout
    [viewController.view addSubview:self];
    self.translatesAutoresizingMaskIntoConstraints = NO;
    [viewController.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(left)-[self]-(right)-|" options:0 metrics:@{@"left": @(margins.left), @"right": @(margins.right)} views:NSDictionaryOfVariableBindings(self)]];// full width
    [viewController.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(top)-[self]-(bottom)-|" options:0 metrics:@{@"top": @(margins.top), @"bottom": @(margins.bottom)} views:NSDictionaryOfVariableBindings(self)]];// full height
    
    // Return the View Controller
    return viewController;
}

@end
