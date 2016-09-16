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

- (void)showOnView:(nonnull UIView *)view animated:(BOOL)animated context:(nonnull id)context layoutConfigurationBlock:(nullable GBFloatingPopoverAutolayoutConfigurationBlock)layoutBlock;

@end
