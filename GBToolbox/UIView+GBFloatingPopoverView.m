//
//  UIView+GBFloatingPopoverView.m
//  GBToolbox
//
//  Created by Luka Mirosevic on 16/09/16.
//  Copyright © 2016 Goonbee e.U. All rights reserved.
//

#import "UIView+GBFloatingPopoverView.h"

#import "GBCAAnimationDelegateHandler.h"

NSTimeInterval const kGBFloatingPopoverShowForever =        DBL_MAX;

static NSTimeInterval const kDefaultFadeInDuration =        0.25;
static NSTimeInterval const kDefaultFadeOutDuration =       0.25;
static NSTimeInterval const kDefaultShowDuration =          3.0;

static NSString * const kAnimationKey =                     @"com.goonbee.GBToolbox.FloatingPopoverAnimation";

@implementation UIView (GBFloatingPopoverView)

#pragma mark - API

- (void)floatOnView:(nonnull UIView *)targetView animated:(BOOL)animated context:(nonnull id)context layoutConfigurationBlock:(nullable GBFloatingPopoverAutolayoutConfigurationBlock)layoutBlock {
    [self floatOnView:targetView animated:animated autoDismiss:YES context:context layoutConfigurationBlock:layoutBlock];
}

- (void)floatOnView:(nonnull UIView *)targetView animated:(BOOL)animated autoDismiss:(BOOL)autoDismiss context:(nonnull id)context layoutConfigurationBlock:(nullable GBFloatingPopoverAutolayoutConfigurationBlock)layoutBlock {
    [self floatOnView:targetView context:context fadeInDuration:(animated ? kDefaultFadeInDuration : 0) showDuration:(autoDismiss ? kDefaultShowDuration : kGBFloatingPopoverShowForever) fadeOutDuration:(animated ? kDefaultFadeOutDuration : 0) layoutConfigurationBlock:layoutBlock];
}

- (void)floatOnView:(nonnull UIView *)targetView context:(nonnull id)context fadeInDuration:(NSTimeInterval)fadeInDuration showDuration:(NSTimeInterval)showDuration fadeOutDuration:(NSTimeInterval)fadeOutDuration layoutConfigurationBlock:(nullable GBFloatingPopoverAutolayoutConfigurationBlock)layoutBlock {
    if (!targetView) @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"`view` cannot be nil." userInfo:nil];
    if (!context) @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"`context` cannot be nil." userInfo:nil];
    
    // get the old view
    UIView *existingView = [self.class _viewForContext:context];
    
    // compute our params for the animation
    BOOL isOldViewAnimating = !![existingView.layer animationForKey:kAnimationKey];
    CGFloat currentAlpha = isOldViewAnimating ? ((NSNumber *)[existingView.layer.presentationLayer valueForKeyPath:@"opacity"]).doubleValue : 0.0;
    NSTimeInterval remainingFadeInAnimationTime = (1.0 - currentAlpha) * fadeInDuration;
    BOOL isDifferentView = (existingView != self);
    
    // clean up old view if the new one coming in is different
    if (isDifferentView) {
        [existingView.layer removeAnimationForKey:kAnimationKey];
        [existingView removeFromSuperview];
    }
    
    // add and lay out the new view if it is different
    if (self.superview != targetView) {
        // first add to view hierachy
        [targetView addSubview:self];
        
        // now we can set constraints, inverting control
        if (layoutBlock) layoutBlock(self);
        
        // we set the alpha to 0 to avoid a potential flickering issue when the animation is removed from the layer, and the removing from the superview doesn't happen in the same run loop interation which could lead to a short flicker of the view at the original alpha after the animation is removed but before the view is removed from the superview
        self.alpha = 0;
    }
    
    // create and schedule the new animation
    CAKeyframeAnimation *newAnimation = [CAKeyframeAnimation animation];
    newAnimation.keyPath = @"opacity";
    newAnimation.values = @[@(currentAlpha), @1, @1, @0];
    NSTimeInterval totalDuration = remainingFadeInAnimationTime + showDuration + fadeOutDuration;
    NSTimeInterval normalizedPostFadeInKeyTime = remainingFadeInAnimationTime / totalDuration;
    NSTimeInterval normalisedPostFreezeKeyTime = (remainingFadeInAnimationTime + showDuration) / totalDuration;
    newAnimation.keyTimes = @[@0, @(normalizedPostFadeInKeyTime), @(normalisedPostFreezeKeyTime), @1];
    newAnimation.duration = totalDuration;
    newAnimation.removedOnCompletion = YES;
    __weak typeof(self) weakSelf = self;
    newAnimation.delegate = [GBCAAnimationDelegateHandler delegateWithDidStart:nil didStop:[self _animationCleanupBlockForContext:context]];
    [self.layer addAnimation:newAnimation forKey:kAnimationKey];
    
    // remember the new view
    [self.class _setView:self forContext:context];
}

- (void)floatingViewDismissForContext:(id)context animated:(BOOL)animated {
    [self floatingViewDismissForContext:context fadeOutDuration:(animated ? kDefaultFadeOutDuration : 0)];
}

- (void)floatingViewDismissForContext:(id)context fadeOutDuration:(NSTimeInterval)fadeOutDuration {
    if (!context) @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"`context` cannot be nil." userInfo:nil];
    
    // get the currently displayed view
    UIView *existingView = [self.class _viewForContext:context];
    
    // compute our params for the animation
    BOOL isOldViewAnimating = !![existingView.layer animationForKey:kAnimationKey];
    CGFloat currentAlpha = isOldViewAnimating ? ((NSNumber *)[existingView.layer.presentationLayer valueForKeyPath:@"opacity"]).doubleValue : 0.0;
    NSTimeInterval remainingFadeOutAnimationTime = currentAlpha * fadeOutDuration;
    
    // create and schedule the new animation
    CAKeyframeAnimation *newAnimation = [CAKeyframeAnimation animation];
    newAnimation.keyPath = @"opacity";
    newAnimation.values = @[@(currentAlpha), @0];
    newAnimation.keyTimes = @[@0, @1];
    newAnimation.duration = remainingFadeOutAnimationTime;
    newAnimation.removedOnCompletion = YES;
    __weak typeof(self) weakSelf = self;
    newAnimation.delegate = [GBCAAnimationDelegateHandler delegateWithDidStart:nil didStop:[self _animationCleanupBlockForContext:context]];
    [self.layer addAnimation:newAnimation forKey:kAnimationKey];
}

#pragma mark - Private: Utils

- (GBCAAnimationDidStopBlock)_animationCleanupBlockForContext:(id)context {
    __weak typeof(self) weakSelf = self;
    return ^(CAAnimation *animation, BOOL finished) {
        // if this animation ran it's natural course
        if (finished) {
            // remove this view from the superview
            [weakSelf removeFromSuperview];
            [weakSelf.class _removeViewForContext:context];
        }
    };
}

#pragma mark - Private: Contexts Map

static NSMapTable<id, UIView *> *_contextToViewsMap;

+ (nullable UIView *)_viewForContext:(id)context {
    return [_contextToViewsMap objectForKey:context];
}

+ (void)_setView:(nonnull UIView *)view forContext:(nonnull id)context {
    // always lazy create it
    if (!_contextToViewsMap) {
        _contextToViewsMap = [NSMapTable strongToWeakObjectsMapTable];
    }
    
    [_contextToViewsMap setObject:view forKey:context];
}

+ (void)_removeViewForContext:(id)context {
    [_contextToViewsMap removeObjectForKey:context];
    
    // if we have no more keys, then clean up the mapTable as well
    if (_contextToViewsMap.count == 0) {
        _contextToViewsMap = nil;
    }
}

@end
