//
//  UIView+GBToolbox.h
//  GBToolbox
//
//  Created by Luka Mirosevic on 22/05/2013.
//  Copyright (c) 2013 Luka Mirosevic. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (GBToolbox)

/**
 Set this to YES if the background color that you specifed in IB was for design time only and you would like the background to be clearColor when it is unarchived from the NIB. Useful if you want IB to show a different color at design time, such as a placeholder color, but you don't want this visible at runtime.
 */
@property (assign, nonatomic) IBInspectable BOOL designTimeOnlyBackgroundColor;

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

/**
 Adds a fade animation to receiver's layer. A useful case is for animating label content changes.
 */
- (void)addCrossFadeAnimationToLayerWithDuration:(NSTimeInterval)duration;

/**
 Setting this to YES disables user interactions on the the receiver, without disabling it for the child views.
 
 This is in contrast to simply setting userInteractionEnabled to NO, in which case the view will not receive touch input, will however also not forward it to it's children.
 
 Setting this to YES is useful in cases where one might want to add a container view that has some children, where the container view should not exist for purposes of handling touch input--it should neither receive touch input, not prevent its children from receiving it.
 
 Defaults to YES.
 */
@property (assign, nonatomic) BOOL shouldParticipateInUserInput;

/**
 Sets a mask to this view's layer that clips the corners by cornerRadius.
 
 You must call this again if your view resizes.
 */
- (void)roundCorners:(UIRectCorner)corners withRadius:(CGFloat)cornerRadius;

@end
