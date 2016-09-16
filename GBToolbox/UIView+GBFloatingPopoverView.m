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
    __weak UIView *existingView = [self.class _viewForContext:context];
    
    // if we have an old one get rid of it immediately. This ref is weak so this also immediately releases it if the superview was the only one retaining it.
    BOOL existingOneWasPresent = !!existingView;
    [existingView removeFromSuperview];
    
    // prepare ourselves
    self.alpha = 0.0;
    [view addSubview:self];
    
    // configure layout
    if (layoutBlock) layoutBlock(self);
    
    // fade us in
    [UIView animateWithDuration:((animated && !existingOneWasPresent) ? kFadeInDuration : 0.0) animations:^{
        self.alpha = 1.0;
    }];
    
    // autofade it out after a few seconds and then remove it from the superview. We weakify because we don't want the block to retain the view.
    __weak typeof(self) weakSelf = self;
    __weak void(^animator)() = [self.class _fadoutAnimator:^{
        // fade out animation
        [UIView animateWithDuration:kFadeOutDuration animations:^{
            weakSelf.alpha = 0.0;
        } completion:^(BOOL finished) {
            [weakSelf removeFromSuperview];
        }];
    } forView:self];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kShowDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // call our animator if it still exists
        if (animator) {
            animator();
        } else {
            NSLog(@"Doesn't exist!");
        }
    });
    
    // associate the current view to the context
    [self.class _setView:self forContext:context];
}

#pragma mark - Private: Fadout Animator

static NSMapTable *_fadeoutAnimatorsMap;

+ (void)_releaseFadoutAnimatorForView:(UIView *)view {
    [_fadeoutAnimatorsMap removeObjectForKey:view];
}

+ (void(^)())_fadoutAnimator:(void(^)())animations forView:(UIView *)view {
    if (!_fadeoutAnimatorsMap) {
        _fadeoutAnimatorsMap = [NSMapTable mapTableWithKeyOptions:NSMapTableStrongMemory valueOptions:NSMapTableCopyIn];
    }
    
    // create our animator block
    __weak typeof(view) weakView = view;
    void(^animator)() = ^{
        // run the animations
        animations();
        
        // remove the animator from the map
        [_fadeoutAnimatorsMap removeObjectForKey:weakView];
    };
    
    // retain the animator block inside our map table. The map table will automatically copy the animator to the heap
    [_fadeoutAnimatorsMap setObject:animator forKey:view];
    
    // give it back, this is what will get run after some time
    return animator;
}

#pragma mark - Private: Contexts Map

static NSMapTable *_contextsMap;

+ (nullable UIView *)_viewForContext:(id)context {
    return [_contextsMap objectForKey:context];
}

+ (void)_setView:(nonnull UIView *)view forContext:(nonnull id)context {
    // lazy create it
    if (!_contextsMap) {
        _contextsMap = [NSMapTable strongToWeakObjectsMapTable];
    }
    
    [_contextsMap setObject:view forKey:context];
}

- (void)dealloc {
    // clean ourselves up from the animator map
    [self.class _releaseFadoutAnimatorForView:self];
}

@end
