//
//  UIView+GBFloatingPopoverView.h
//  GBToolbox
//
//  Created by Luka Mirosevic on 16/09/16.
//  Copyright © 2016 Goonbee e.U. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^GBFloatingPopoverAutolayoutConfigurationBlock)(UIView * _Nonnull view);

@interface UIView (GBFloatingPopoverView)

/**
 Shows receiver on the targetView. `layoutBlock` is called synchonously as soon as the view has been added to targetView (unless if the view is already a subview of targetView. Handles intelligent nesting of views within a context.
 */
- (void)floatOnView:(nonnull UIView *)targetView animated:(BOOL)animated context:(nonnull id)context layoutConfigurationBlock:(nullable GBFloatingPopoverAutolayoutConfigurationBlock)layoutBlock;

@end
