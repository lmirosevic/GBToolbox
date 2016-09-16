//
//  UIView+GBFloatingPopoverView.m
//  GBToolbox
//
//  Created by Luka Mirosevic on 16/09/16.
//  Copyright © 2016 Goonbee e.U. All rights reserved.
//

#import "UIView+GBFloatingPopoverView.h"

#import "GBToolbox.h"//lm kill

static NSTimeInterval kFadeInDuration =     3;
static NSTimeInterval kFadeOutDuration =    3;
static NSTimeInterval kShowDuration =       3;//lm fix

static NSString *kAnimationKey =            @"com.goonbee.GBToolbox.FloatingPopoverAnimation";

typedef void(^GBCAAnimationDidStartBlock)(CAAnimation *animation);
typedef void(^GBCAAnimationDidStopBlock)(CAAnimation *animation, BOOL finished);

@interface GBCAAnimationDelegateHandler : NSObject <CAAnimationDelegate>

+ (nonnull instancetype)delegateWithDidStart:(nullable GBCAAnimationDidStartBlock)didStart didStop:(nullable GBCAAnimationDidStopBlock)didStop;

@end

@interface GBCAAnimationDelegateHandler ()

@property (copy, nonatomic) GBCAAnimationDidStartBlock  didStart;
@property (copy, nonatomic) GBCAAnimationDidStopBlock   didStop;

@end

#pragma mark - API

@implementation GBCAAnimationDelegateHandler

+ (nonnull instancetype)delegateWithDidStart:(nullable GBCAAnimationDidStartBlock)didStart didStop:(nullable GBCAAnimationDidStopBlock)didStop {
    GBCAAnimationDelegateHandler *delegate = [self.class new];
    delegate.didStart = didStart;
    delegate.didStop = didStop;
    
    return delegate;
}

#pragma mark - CAAnimationDelegate

- (void)animationDidStart:(CAAnimation *)animation {
    if (self.didStart) self.didStart(animation);
}

- (void)animationDidStop:(CAAnimation *)animation finished:(BOOL)flag {
    if (self.didStop) self.didStop(animation, flag);
}

@end

@implementation UIView (GBFloatingPopoverView)

#pragma mark - Life

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.backgroundColor = [UIColor clearColor];
}

#pragma mark - API

- (void)showOnView:(nonnull UIView *)targetView animated:(BOOL)animated context:(nonnull id)context layoutConfigurationBlock:(nullable GBFloatingPopoverAutolayoutConfigurationBlock)layoutBlock {
    if (!targetView) @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"`view` cannot be nil." userInfo:nil];
    if (!context) @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"`context` cannot be nil." userInfo:nil];
    
    // ensure that this view does not exist in another context already
    
//    
//    // also ensure that our context variable gets cleaned up when views have faded out
//    //lm todo: we don't want to leak the context variable forever
//    
//    // clear out any potentially deferred fade-out animation blocks for self
//    [self.class _releaseFadoutAnimatorForView:self];
//    
//    // get the existing view for the context
//    __weak UIView *existingView = [self.class _visibleViewForContext:context];
//    
//    // if we have an old one get rid of it immediately. This ref is weak so this also immediately releases it if the superview was the only one retaining it.
//    BOOL existingOneWasPresent = !!existingView;
//    BOOL showingSameViewAgain = (existingView == self);
//    BOOL viewStillShown = (self.superview == view);
//    
//    // if it;s a new one: add it as a subview
//    // if its the same one, don't do anything
//    
//    NSLog(@"existingOneWasPresent: %@", existingOneWasPresent ? @"Yes": @"no");
//    NSLog(@"showingSameViewAgain:  %@", showingSameViewAgain ? @"Yes": @"no");
//    NSLog(@"viewStillShown:        %@", viewStillShown ? @"Yes": @"no");
//    
//    if (!viewStillShown) {
//        // remove old view
////        NSLog(@"removing old one");
//        [existingView removeFromSuperview];
//        
//        // prepare ourselves
//        self.alpha = 0.0;
//        [view addSubview:self];
//    } else {
//        self.alpha = 1.0;
//    }
//    
//    // configure layout
//    if (layoutBlock) layoutBlock(self);
//    
//    // fade us in
//    void(^fadeIn)() = ^{
//        self.alpha = 1.0;
//    };
//    if (animated && !existingOneWasPresent) {
//        [UIView animateWithDuration:kFadeInDuration animations:fadeIn];
//    } else {
//        fadeIn();
//    }
    
    //    NSLog(@"beginTime: %f", oldAnimation.beginTime);
    
    
    
    // get the old view
//    UIView *existingView = [self.class _visibleViewForContext:context];
    
    // remember the new view
//    [self.class _setVisibleView:self forContext:context];
    
//    BOOL isDifferentView = (existingView != self);
//    CABasicAnimation *oldAnimation = [existingView.layer animationForKey:kAnimationKey];
//    BOOL isOldViewAnimating = !!oldAnimation;
//    CGFloat currentAlpha = isOldViewAnimating ? ((NSNumber *)[existingView.layer.presentationLayer valueForKeyPath:@"opacity"]).doubleValue : 0.0;
//    NSTimeInterval remainingFadeInAnimationTime = (1.0 - currentAlpha) * kFadeInDuration;

    CABasicAnimation *oldAnimation = [self.layer animationForKey:kAnimationKey];
    BOOL isOldViewAnimating = !!oldAnimation;
    CGFloat currentAlpha = isOldViewAnimating ? ((NSNumber *)[self.layer.presentationLayer valueForKeyPath:@"opacity"]).doubleValue : 0.0;
    NSTimeInterval remainingFadeInAnimationTime = (1.0 - currentAlpha) * kFadeInDuration;    
    
    NSLog(@"alpha: %f", currentAlpha);
    NSLog(@"fade:  %f", remainingFadeInAnimationTime);
    
    // remove the old animation
//    [existingView.layer removeAnimationForKey:kAnimationKey];//many shows for same view while still trying to show???
    
    
    if (self.superview != targetView) {
        NSLog(@"adding");
        [targetView addSubview:self];
        if (layoutBlock) layoutBlock(self);
        self.alpha = 0;//lm just for testing
    }
    
    
//    // if it's a different view
//    if (isDifferentView) {
//        // remove old one
//        [existingView removeFromSuperview];
//        
//        // add new one
//        [targetView addSubview:self];
//        
//        // let caller perform layout
//        if (layoutBlock) layoutBlock(self);
//        
//        // set initial alpha value
////        self.alpha = currentAlpha;
//    }
    
    // guard against the case if it's the same view and it's in the process of being shown. In this case we don't want to do anything
//    if (!isDifferentView && isOldViewAnimating && [self.class _animationIsFadeIn:oldAnimation]) {} else {
        NSLog(@"scheduling");
        // create and schedule the new animation
        CAKeyframeAnimation *newAnimation = [CAKeyframeAnimation animation];
        newAnimation.keyPath = @"opacity";
//        newAnimation.values = @[@0, @1, @1, @0];
        newAnimation.values = @[@(currentAlpha), @1, @1, @0];
        NSTimeInterval totalDuration = remainingFadeInAnimationTime + kShowDuration + kFadeOutDuration;
        NSTimeInterval normalizedPostFadeInKeyTime = remainingFadeInAnimationTime / totalDuration;
        NSTimeInterval normalisedPostFreezeKeyTime = (remainingFadeInAnimationTime + kShowDuration) / totalDuration;
        newAnimation.keyTimes = @[@0, @(normalizedPostFadeInKeyTime), @(normalisedPostFreezeKeyTime), @1];
        newAnimation.duration = totalDuration;
        newAnimation.removedOnCompletion = YES;
        newAnimation.delegate = [GBCAAnimationDelegateHandler delegateWithDidStart:nil didStop:^(CAAnimation *animation, BOOL finished) {
            NSLog(@"done animating");
            // if we finished
            if (finished) {
                // remove this view from the superview
                NSLog(@"removing");
                [self removeFromSuperview];
            } else {
                NSLog(@"not finished");
            }
        }];//lm make sure that his guy is released on time
        [self.layer addAnimation:newAnimation forKey:kAnimationKey];
//    }
}

+ (BOOL)_animationIsFadeIn:(CAKeyframeAnimation *)animation {
    return YES;
//    return ((NSNumber *)animation.toValue).doubleValue == 1.0;
}










//
//    [targetView addSubview:self];
//    
//    if (layoutBlock) layoutBlock(self);
//    
//    self.alpha = 0;
//    [UIView animateWithDuration:5 animations:^{
//        self.alpha = 1.0;
//    } completion:^(BOOL finished) {
//        _lBoolean(finished);
//    }];
//    
//    ExecuteAfter(2, ^{
////        [self.layer removeAnimationForKey:]
//        self.alpha = 0.5;
//    });
//    
//    // autofade it out after a few seconds and then remove it from the superview. We weakify the animator because we want to control it's existence externally--as a mechanism for cancelling the block.
//    __weak typeof(self) weakSelf = self;
//    __weak void(^animator)() = [self.class _fadoutAnimatorForView:self duration:kFadeOutDuration context:context animations:^{
////        NSLog(@"alpha: 0");
//        weakSelf.alpha = 0.0;
//    } completion:^(BOOL finished) {
////        NSLog(@"finished?: %@", finished ? @"yes" :@"no");
//        [weakSelf removeFromSuperview];
//    }];
//    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kShowDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        // call our animator if it still exists
//        if (animator) {
//            animator();
//        } else {
//            NSLog(@"Doesn't exist!");
//        }
//    });
    
    // associate the current view to the context
//    [self.class _setVisibleView:self forContext:context];
//}







#pragma mark - Private: Fadout Animator

//static NSMapTable *_fadeoutAnimatorsMap;
//
//+ (void)_releaseFadoutAnimatorForView:(UIView *)view {
////    NSLog(@"removing TOR:       %@", [_fadeoutAnimatorsMap objectForKey:view]);
//    [_fadeoutAnimatorsMap removeObjectForKey:view];
//}
//
//+ (void(^)())_fadoutAnimatorForView:(UIView *)view duration:(NSTimeInterval)duration context:(id)context animations:(void(^)())animations completion:(void(^)(BOOL finished))completion {
//    if (!_fadeoutAnimatorsMap) {
//        _fadeoutAnimatorsMap = [NSMapTable mapTableWithKeyOptions:NSMapTableStrongMemory valueOptions:NSMapTableStrongMemory];
//    }
//    
//    
//    
//    
//    
//    
//    
//    
//    
//    
//    
//    
//    
//    
//    
//    
//    // create our animator block
//    __weak typeof(view) weakView = view;
//    void(^animator)() = ^{
//        // if the view is the last view for our context, then remove it. If not then it has been superceded and it will be removed by it's handler
//        if ([self _visibleViewForContext:context] == view) {
//            [self _removeVisibleViewForContext:context];
//        }
//        
//        // run the animations
//        [UIView animateWithDuration:duration animations:animations completion:^(BOOL finished) {
//            // if this view is still in the context then we skip this part
//            if ([self _visibleViewForContext:context] == view) {
//                NSLog(@"still in context");
//                
//                
//                
//            } else {
//                NSLog(@"out of context");
//                
//                completion(finished);
//            }
//            
////            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
////                NSLog(@"and now? %@", [self _viewForContext:context] == view ? @"yes" : @"no");
////            });
//        }];
//        
//        // remove the animator from the map
//        [_fadeoutAnimatorsMap removeObjectForKey:weakView];
//    };
//    
////    NSLog(@"created TOR:        %@", animator);
//    
//    // retain the animator block inside our map table. The map table will automatically copy the animator to the heap
//    [_fadeoutAnimatorsMap setObject:animator forKey:view];
//    
//    // give it back, this is what will get run after some time
//    return animator;
//}
//
//#pragma mark - Private: Contexts Map
//
static NSMapTable *_contextToVisibleViewsMap;
//static NSMapTable *_contextToAnimatingViewsMap;


+ (nullable UIView *)_visibleViewForContext:(id)context {
    return [_contextToVisibleViewsMap objectForKey:context];
}

+ (void)_setVisibleView:(nonnull UIView *)view forContext:(nonnull id)context {
    // lazy create it
    if (!_contextToVisibleViewsMap) {
        _contextToVisibleViewsMap = [NSMapTable strongToWeakObjectsMapTable];
    }
    
    [_contextToVisibleViewsMap setObject:view forKey:context];
}

+ (void)_removeVisibleViewForContext:(id)context {
    [_contextToVisibleViewsMap removeObjectForKey:context];
}

//+ (nullable UIView *)_animatingViewForContext:(id)context {
//    return [_contextToAnimatingViewsMap objectForKey:context];
//}
//
//
//+ (void)_setAnimatingView:(nonnull UIView *)view forContext:(nonnull id)context {
//    // lazy create it
//    if (!_contextToAnimatingViewsMap) {
//        _contextToAnimatingViewsMap = [NSMapTable strongToWeakObjectsMapTable];
//    }
//    
//    [_contextToAnimatingViewsMap setObject:view forKey:context];
//}
//
//+ (void)_removeAnimatingViewForContext:(id)context {
//    [_contextToAnimatingViewsMap removeObjectForKey:context];
//}
//
//
//
////- (void)dealloc {
////    // clean ourselves up from the animator map
////    [self.class _releaseFadoutAnimatorForView:self];
////}

@end
