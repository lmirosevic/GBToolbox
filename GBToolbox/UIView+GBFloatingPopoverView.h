//
//  UIView+GBFloatingPopoverView.h
//  GBToolbox
//
//  Created by Luka Mirosevic on 16/09/16.
//  Copyright © 2016 Goonbee e.U. All rights reserved.
//

#import <UIKit/UIKit.h>

FOUNDATION_EXPORT NSTimeInterval const kGBFloatingPopoverShowForever;

typedef void(^GBFloatingPopoverAutolayoutConfigurationBlock)(UIView * _Nonnull view);

@interface UIView (GBFloatingPopoverView)

/**
 Shows receiver on the targetView. `layoutBlock` is called synchronously as soon as the view has been added to targetView (unless if the view is already a subview of targetView. Handles intelligent nesting of views within a context.
 */
- (void)floatOnView:(nonnull UIView *)targetView animated:(BOOL)animated context:(nonnull id)context layoutConfigurationBlock:(nullable GBFloatingPopoverAutolayoutConfigurationBlock)layoutBlock;

/**
 Shows receiver on the targetView. `layoutBlock` is called synchronously as soon as the view has been added to targetView (unless if the view is already a subview of targetView. Handles intelligent nesting of views within a context. If autoDismiss is set to YES, this view will show for a while and then dismiss itself.
 */
- (void)floatOnView:(nonnull UIView *)targetView animated:(BOOL)animated autoDismiss:(BOOL)autoDismiss context:(nonnull id)context layoutConfigurationBlock:(nullable GBFloatingPopoverAutolayoutConfigurationBlock)layoutBlock;

/**
 Shows receiver on the targetView. `layoutBlock` is called synchronously as soon as the view has been added to targetView (unless if the view is already a subview of targetView. Handles intelligent nesting of views within a context. If you do not want the view to dismiss, pass a `kGBFloatingPopoverShowForever` as the `showDuration.`
 
 Note: If you pass a non-nil layoutConfigurationBlock, the `view` will have its `translatesAutoresizingMaskIntoConstraints` property set to NO.
 
 Warning: Passing different durations for a particular context, will have undefined behaviour if another view is already being shown in this context.
 */
- (void)floatOnView:(nonnull UIView *)targetView context:(nonnull id)context fadeInDuration:(NSTimeInterval)fadeInDuration showDuration:(NSTimeInterval)showDuration fadeOutDuration:(NSTimeInterval)fadeOutDuration layoutConfigurationBlock:(nullable GBFloatingPopoverAutolayoutConfigurationBlock)layoutBlock;

/**
 Dismisses the receiver.
 */
- (void)floatingViewDismissForContext:(nonnull id)context animated:(BOOL)animated;

/**
 Dismisses the receiver with a desired animation duration.
 */
- (void)floatingViewDismissForContext:(nonnull id)context fadeOutDuration:(NSTimeInterval)fadeOutDuration;

@end
