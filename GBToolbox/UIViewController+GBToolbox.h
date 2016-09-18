//
//  UIViewController+GBToolbox.h
//  GBToolbox
//
//  Created by Luka Mirosevic on 05/02/2013.
//  Copyright (c) 2013 Luka Mirosevic. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (GBToolbox)

/**
 Returns YES when the view controller is visible (in between viewWillAppear: and viewDidDisappear:)
 */
@property (assign, nonatomic) BOOL isVisible;

/**
 Returns YES when the view controller is visible (in between viewWillAppear: and viewWillDisappear:)
 */
@property (assign, nonatomic) BOOL isVisibleCurrently;

/**
 Makes sure that the view is loaded
 */
- (void)ensureViewIsLoaded;

/**
 Returns the preferred status bar style of the view controller that's currently shown.
 */
@property (assign, nonatomic, readonly) UIStatusBarStyle inheritedPreferredStatusBarStyle;

/**
 Set this viewcontroller's navigation bar background color with a more sane behaviour than the standard Cocoa Touch methods.
 
 If color is nil, the bar will be transparent.
 */
- (void)styleNavigationBarWithColor:(nullable UIColor *)color;

/**
 Hides the title next to the back button, showing only the chevron.
 */
- (void)hideBackButtonTitle;

@end
