//
//  UIView+GBToolbox.h
//  GBToolbox
//
//  Created by Luka Mirosevic on 22/05/2013.
//  Copyright (c) 2013 Luka Mirosevic. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (GBToolbox)

#pragma mark - Conveniences

/**
 Removes all subviews.
 */
- (void)removeAllSubviews;

/**
 Sets the view's frame to the receiver's bounds and adds it as a subview.
 */
- (void)embedView:(UIView *)view;

/**
 Resigns the first responder for any subview of the receiver. Some code from SO: http://stackoverflow.com/a/1823360/399772
 */
- (BOOL)findAndResignFirstResponder;

/**
 Returns a view controller whose view has the receiver added as a subview, laid out in Autolayout to have it's view the same size as the receiver (edges are pinned).
 
 Warning: Always creates a new instance, every time it is called.
 */
- (UIViewController *)wrappingViewController;

/**
 Returns a view controller whose view has the receiver added as a subview, laid out in Autolayout to have it's view the same size as the receiver (edges are pinned) taking into account the edge margins.
 
 Warning: Always creates a new instance, every time it is called.
 */
- (UIViewController *)wrappingViewControllerWithMargins:(UIEdgeInsets)margins;

/**
 Returns a view with the receiver added as a subview, laid out in Autolayout to have it's view the same size as the receiver (edges are pinned) taking into account the edge margins.
 
 Warning: Always creates a new instance, every time it is called.
 */
- (UIView *)wrappingViewWithMargins:(UIEdgeInsets)margins;

/**
 Returns the part of the view rendered into an image inside the rect. 
 
 Setting legacy to YES will use the older (more reliable) method of rendering. Always try with legacy:NO first as it is more efficient in iOS7+. If it doesn't work fallback to legacy:YES.
 */
- (UIImage *)renderToImageForRect:(CGRect)rect legacy:(BOOL)legacy;

@end
