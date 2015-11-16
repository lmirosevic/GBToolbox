//
//  UIView+GBPopUp.h
//  GBToolbox
//
//  Created by Luka Mirosevic on 08/07/2013.
//  Copyright (c) 2013 Luka Mirosevic. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    GBPopUpAnimationFlyUp,
    GBPopUpAnimationFadeAway,
} GBPopUpAnimation;

typedef void(^GBPopUpAutolayoutInstallationBlock)(UIView *superview, UIView *view);

@interface UIView (GBPopUp)

@property (strong, nonatomic) UIColor               *popUpBackgroundColor;
@property (assign, nonatomic, readonly) BOOL        isPresentedAsPopUp;

/**
 Presents this view directly onto the key window.
 */
- (void)presentAsPopUpOnWindowAnimated:(BOOL)animated;

/**
 Presents this view directly onto the key window, with an optional block for installing autolayout constraints.
 */
- (void)presentAsPopUpOnWindowAnimated:(BOOL)animated installingAutolayout:(GBPopUpAutolayoutInstallationBlock)autolayoutInstallation;

/**
 Presents this view onto the desired view.
 */
- (void)presentAsPopUpOnView:(UIView *)targetView animated:(BOOL)animated;

/**
 Presents this view onto the desired view, with an optional block for installing autolayout constraints.
 */
- (void)presentAsPopUpOnView:(UIView *)targetView animated:(BOOL)animated installingAutolayout:(GBPopUpAutolayoutInstallationBlock)autolayoutInstallation;

/**
 Dismisses the popup with the default fade animation.
 */
- (void)dismissPopUpAnimated:(BOOL)animated;

/**
 Dismisses the popup with a specific animation style.
 */
- (void)dismissPopUpWithAnimation:(GBPopUpAnimation)animationType;

@end
