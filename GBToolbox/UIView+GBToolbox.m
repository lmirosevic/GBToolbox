//
//  UIView+GBToolbox.m
//  GBToolbox
//
//  Created by Luka Mirosevic on 22/05/2013.
//  Copyright (c) 2013 Luka Mirosevic. All rights reserved.
//

#import "UIView+GBToolbox.h"

#import "GBUtility_Common.h"
#import <objc/runtime.h>

@implementation UIView (GBToolbox)

#pragma mark - CA

static char gbDesignTimeOnlyBackgroundColor;

- (void)setDesignTimeOnlyBackgroundColor:(BOOL)designTimeOnlyBackgroundColor {
    objc_setAssociatedObject(self, &gbDesignTimeOnlyBackgroundColor, @(designTimeOnlyBackgroundColor), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)designTimeOnlyBackgroundColor {
        return ((NSNumber *)objc_getAssociatedObject(self, &gbDesignTimeOnlyBackgroundColor)).boolValue;
}

#pragma mark - Overrides

+ (void)load {
    SwizzleInstanceMethodsInClass(self, @selector(awakeFromNib), @selector(_swizz_awakeFromNib));
}

- (void)_swizz_awakeFromNib {
    [self _swizz_awakeFromNib];
    
    if (self.designTimeOnlyBackgroundColor) {
        self.backgroundColor = [UIColor clearColor];
    }
}


#pragma mark - Extensions

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

- (UIView *)wrappingViewWithMargins:(UIEdgeInsets)margins {
    // Create a new view
    UIView *view = [UIView new];
    
    // Add self as a subview, configuring Autolayout
    [view addSubview:self];
    self.translatesAutoresizingMaskIntoConstraints = NO;
    [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(left)-[self]-(right)-|" options:0 metrics:@{@"left": @(margins.left), @"right": @(margins.right)} views:NSDictionaryOfVariableBindings(self)]];// full width
    [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(top)-[self]-(bottom)-|" options:0 metrics:@{@"top": @(margins.top), @"bottom": @(margins.bottom)} views:NSDictionaryOfVariableBindings(self)]];// full height
    
    // Return the view
    return view;
}

- (UIImage *)renderToImageForRect:(CGRect)rect legacy:(BOOL)legacy {
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextConcatCTM(context, CGAffineTransformMakeTranslation(-rect.origin.x, -rect.origin.y));
    if (legacy) {
        [self.layer renderInContext:context];
    } else {
        [self drawViewHierarchyInRect:rect afterScreenUpdates:YES];
    }
    UIImage *snapshotImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return snapshotImage;
}

- (void)addCrossFadeAnimationToLayerWithDuration:(NSTimeInterval)duration {
    CATransition *fadeAnimation = [CATransition animation];
    fadeAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    fadeAnimation.type = kCATransitionFade;
    fadeAnimation.duration = duration;
 
    [self.layer addAnimation:fadeAnimation forKey:@"kCATransitionFade"];
}

@end
