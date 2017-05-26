//
//  UIView+GBToolbox.m
//  GBToolbox
//
//  Created by Luka Mirosevic on 22/05/2013.
//  Copyright (c) 2013 Luka Mirosevic. All rights reserved.
//

#import "UIView+GBToolbox.h"

#import "GBUtility_Common.h"
#import "GBMacros_Common.h"
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

static char gbShouldParticipateInUserInput;

- (void)setShouldParticipateInUserInput:(BOOL)shouldParticipateInUserInput {
    objc_setAssociatedObject(self, &gbShouldParticipateInUserInput, @(shouldParticipateInUserInput), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)shouldParticipateInUserInput {
    return ((NSNumber *)objc_getAssociatedObject(self, &gbShouldParticipateInUserInput) ?: @YES).boolValue;
}

static char gbViewRelatedChangesDelegate;

- (void)setViewRelatedChangesDelegate:(id<GBViewViewRelatedChangesDelegate>)viewRelatedChangesDelegate {
    // on first call, enable the hooks by swizzling the implentation
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SwizzleInstanceMethodsInClass(self.class, @selector(didAddSubview:), @selector(_swizz_didAddSubview:));
        SwizzleInstanceMethodsInClass(self.class, @selector(willRemoveSubview:), @selector(_swizz_willRemoveSubview:));
        SwizzleInstanceMethodsInClass(self.class, @selector(willMoveToSuperview:), @selector(_swizz_willMoveToSuperview:));
        SwizzleInstanceMethodsInClass(self.class, @selector(didMoveToSuperview), @selector(_swizz_didMoveToSuperview));
        SwizzleInstanceMethodsInClass(self.class, @selector(willMoveToWindow:), @selector(_swizz_willMoveToWindow:));
        SwizzleInstanceMethodsInClass(self.class, @selector(didMoveToWindow), @selector(_swizz_didMoveToWindow));
    });
    
    // make sure that it's nil first
    if (viewRelatedChangesDelegate && self.viewRelatedChangesDelegate) @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"The viewRelatedChangesDelegate has already been set. Overriding it might break other code that has previously set the delegate. If you're sure you want to replace this delegate, then set it to nil before setting the new value." userInfo:nil];
    
    objc_setAssociatedObject(self, &gbViewRelatedChangesDelegate, viewRelatedChangesDelegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id<GBViewViewRelatedChangesDelegate>)viewRelatedChangesDelegate {
    return (id<GBViewViewRelatedChangesDelegate>)objc_getAssociatedObject(self, &gbViewRelatedChangesDelegate);
}

#pragma mark - Overrides

+ (void)load {
    SwizzleInstanceMethodsInClass(self, @selector(awakeFromNib), @selector(_swizz_awakeFromNib));
    SwizzleInstanceMethodsInClass(self, @selector(hitTest:withEvent:), @selector(_swizz_hitTest:withEvent:));
}

- (void)_swizz_awakeFromNib {
    [self _swizz_awakeFromNib];
    
    if (self.designTimeOnlyBackgroundColor) {
        self.backgroundColor = [UIColor clearColor];
    }
}

- (UIView *)_swizz_hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    // determine what we normally would have hit tested
    UIView *hitView = [self _swizz_hitTest:point withEvent:event];
 
    // if we should participate in user input, then do what we normally do
    if (self.shouldParticipateInUserInput) {
        return hitView;
    }
    // otherwise do our magic
    else {
        if (hitView == self) {
            return nil;
        } else {
            return hitView;
        }
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

- (void)roundCorners:(UIRectCorner)corners withRadius:(CGFloat)cornerRadius {
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:CGSizeMake(cornerRadius, cornerRadius)].CGPath;
    self.layer.mask = maskLayer;
}

#pragma mark - View related changes


- (void)_swizz_didAddSubview:(UIView *)subview {
    [self _swizz_didAddSubview:subview];
    
    if ([self.viewRelatedChangesDelegate respondsToSelector:@selector(view:didAddSubview:)]) {
        [self.viewRelatedChangesDelegate view:self didAddSubview:subview];
    }
}

- (void)_swizz_willRemoveSubview:(UIView *)subview {
    [self _swizz_willRemoveSubview:subview];
    
    if ([self.viewRelatedChangesDelegate respondsToSelector:@selector(view:willRemoveSubview:)]) {
        [self.viewRelatedChangesDelegate view:self willRemoveSubview:subview];
    }
}

- (void)_swizz_willMoveToSuperview:(UIView *)newSuperview {
    [self _swizz_willMoveToSuperview:newSuperview];
    
    if ([self.viewRelatedChangesDelegate respondsToSelector:@selector(view:willMoveToSuperview:)]) {
        [self.viewRelatedChangesDelegate view:self willMoveToSuperview:newSuperview];
    }
}

- (void)_swizz_didMoveToSuperview {
    [self _swizz_didMoveToSuperview];
    
    if ([self.viewRelatedChangesDelegate respondsToSelector:@selector(view:didMoveToSuperview:)]) {
        [self.viewRelatedChangesDelegate view:self didMoveToSuperview:self.superview];
    }
}

- (void)_swizz_willMoveToWindow:(UIWindow *)newWindow {
    [self _swizz_willMoveToWindow:newWindow];
    
    if ([self.viewRelatedChangesDelegate respondsToSelector:@selector(view:willMoveToWindow:)]) {
        [self.viewRelatedChangesDelegate view:self willMoveToWindow:newWindow];
    }
}

- (void)_swizz_didMoveToWindow {
    [self _swizz_didMoveToWindow];
    
    if ([self.viewRelatedChangesDelegate respondsToSelector:@selector(view:didMoveToWindow:)]) {
        [self.viewRelatedChangesDelegate view:self didMoveToWindow:self.window];
    }
}

@end
