//
//  UIView+GBFloatingPopoverView.m
//  GBToolbox
//
//  Created by Luka Mirosevic on 16/09/16.
//  Copyright © 2016 Goonbee e.U. All rights reserved.
//

#import "UIView+GBFloatingPopoverView.h"

static NSTimeInterval kFadeInDuration =     0.3;
static NSTimeInterval kFadeOutDuration =    0.3;
static NSTimeInterval kShowDuration =       3;

@implementation UIView (GBFloatingPopoverView)

#pragma mark - Life

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.backgroundColor = [UIColor clearColor];
}

#pragma mark - API

- (void)showOnView:(nonnull UIView *)view animated:(BOOL)animated context:(nonnull id)context layoutConfigurationBlock:(nullable GBFloatingPopoverAutolayoutConfigurationBlock)layoutBlock {
    if (!view) @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"`view` cannot be nil." userInfo:nil];
    if (!context) @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"`context` cannot be nil." userInfo:nil];
    
    // ensure that this view does not exist in another context already
    
    
    // also ensure that our context variable gets cleaned up when views have faded out
    //lm todo: we don't want to leak the context variable forever
    
    // clear out any potentially deferred fade-out animation blocks for self
    [self.class _releaseFadoutAnimatorForView:self];
    
    // get the existing view for the context
    __weak UIView *existingView = [self.class _visibleViewForContext:context];
    
    // if we have an old one get rid of it immediately. This ref is weak so this also immediately releases it if the superview was the only one retaining it.
    BOOL existingOneWasPresent = !!existingView;
    BOOL showingSameViewAgain = (existingView == self);
    BOOL viewStillShown = (self.superview == view);
    
    // if it;s a new one: add it as a subview
    // if its the same one, don't do anything
    
    NSLog(@"existingOneWasPresent: %@", existingOneWasPresent ? @"Yes": @"no");
    NSLog(@"showingSameViewAgain:  %@", showingSameViewAgain ? @"Yes": @"no");
    NSLog(@"viewStillShown:        %@", viewStillShown ? @"Yes": @"no");
    
    if (!viewStillShown) {
        // remove old view
//        NSLog(@"removing old one");
        [existingView removeFromSuperview];
        
        // prepare ourselves
        self.alpha = 0.0;
        [view addSubview:self];
    } else {
        self.alpha = 1.0;
    }
    
    // configure layout
    if (layoutBlock) layoutBlock(self);
    
    // fade us in
    void(^fadeIn)() = ^{
        self.alpha = 1.0;
    };
    if (animated && !existingOneWasPresent) {
        [UIView animateWithDuration:kFadeInDuration animations:fadeIn];
    } else {
        fadeIn();
    }
    
    // autofade it out after a few seconds and then remove it from the superview. We weakify the animator because we want to control it's existence externally--as a mechanism for cancelling the block.
    __weak typeof(self) weakSelf = self;
    __weak void(^animator)() = [self.class _fadoutAnimatorForView:self duration:kFadeOutDuration context:context animations:^{
//        NSLog(@"alpha: 0");
        weakSelf.alpha = 0.0;
    } completion:^(BOOL finished) {
//        NSLog(@"finished?: %@", finished ? @"yes" :@"no");
        [weakSelf removeFromSuperview];
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kShowDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // call our animator if it still exists
        if (animator) {
            animator();
        } else {
            NSLog(@"Doesn't exist!");
        }
    });
    
    // associate the current view to the context
    [self.class _setVisibleView:self forContext:context];
}

#pragma mark - Private: Fadout Animator

static NSMapTable *_fadeoutAnimatorsMap;

+ (void)_releaseFadoutAnimatorForView:(UIView *)view {
//    NSLog(@"removing TOR:       %@", [_fadeoutAnimatorsMap objectForKey:view]);
    [_fadeoutAnimatorsMap removeObjectForKey:view];
}

+ (void(^)())_fadoutAnimatorForView:(UIView *)view duration:(NSTimeInterval)duration context:(id)context animations:(void(^)())animations completion:(void(^)(BOOL finished))completion {
    if (!_fadeoutAnimatorsMap) {
        _fadeoutAnimatorsMap = [NSMapTable mapTableWithKeyOptions:NSMapTableStrongMemory valueOptions:NSMapTableStrongMemory];
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    // create our animator block
    __weak typeof(view) weakView = view;
    void(^animator)() = ^{
        // if the view is the last view for our context, then remove it. If not then it has been superceded and it will be removed by it's handler
        if ([self _visibleViewForContext:context] == view) {
            [self _removeVisibleViewForContext:context];
        }
        
        // run the animations
        [UIView animateWithDuration:duration animations:animations completion:^(BOOL finished) {
            // if this view is still in the context then we skip this part
            if ([self _visibleViewForContext:context] == view) {
                NSLog(@"still in context");
                
                
                
            } else {
                NSLog(@"out of context");
                
                completion(finished);
            }
            
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                NSLog(@"and now? %@", [self _viewForContext:context] == view ? @"yes" : @"no");
//            });
        }];
        
        // remove the animator from the map
        [_fadeoutAnimatorsMap removeObjectForKey:weakView];
    };
    
//    NSLog(@"created TOR:        %@", animator);
    
    // retain the animator block inside our map table. The map table will automatically copy the animator to the heap
    [_fadeoutAnimatorsMap setObject:animator forKey:view];
    
    // give it back, this is what will get run after some time
    return animator;
}

#pragma mark - Private: Contexts Map

static NSMapTable *_contextToVisibleViewsMap;
static NSMapTable *_contextToAnimatingViewsMap;


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

+ (nullable UIView *)_animatingViewForContext:(id)context {
    return [_contextToAnimatingViewsMap objectForKey:context];
}

+ (void)_removeVisibleViewForContext:(id)context {
    [_contextToVisibleViewsMap removeObjectForKey:context];
}

+ (void)_setAnimatingView:(nonnull UIView *)view forContext:(nonnull id)context {
    // lazy create it
    if (!_contextToAnimatingViewsMap) {
        _contextToAnimatingViewsMap = [NSMapTable strongToWeakObjectsMapTable];
    }
    
    [_contextToAnimatingViewsMap setObject:view forKey:context];
}

+ (void)_removeAnimatingViewForContext:(id)context {
    [_contextToAnimatingViewsMap removeObjectForKey:context];
}



//- (void)dealloc {
//    // clean ourselves up from the animator map
//    [self.class _releaseFadoutAnimatorForView:self];
//}

@end
