//
//  UIViewController+GBToolbox.m
//  GBToolbox
//
//  Created by Luka Mirosevic on 05/02/2013.
//  Copyright (c) 2013 Luka Mirosevic. All rights reserved.
//

#import "UIViewController+GBToolbox.h"

#import "GBUtility_Common.h"
#import "UINavigationBar+GBToolbox.h"
#import <objc/runtime.h>

@implementation UIViewController (GBToolbox)

static char gbIsVisibleKey;
static char gbIsVisibleCurrentlyKey;

#pragma mark - CA

- (void)setIsVisible:(BOOL)isVisible {
    objc_setAssociatedObject(self, &gbIsVisibleKey, @(isVisible), OBJC_ASSOCIATION_COPY);
}

- (BOOL)isVisible {
    return [objc_getAssociatedObject(self, &gbIsVisibleKey) boolValue];
}

- (void)setIsVisibleCurrently:(BOOL)isVisibleCurrently {
    objc_setAssociatedObject(self, &gbIsVisibleCurrentlyKey, @(isVisibleCurrently), OBJC_ASSOCIATION_COPY);
}

- (BOOL)isVisibleCurrently {
    return [objc_getAssociatedObject(self, &gbIsVisibleCurrentlyKey) boolValue];
}

#pragma mark - Overrides

+ (void)load {
    SwizzleInstanceMethodsInClass(self, @selector(viewWillAppear:), @selector(_swizz_viewWillAppear:));
    SwizzleInstanceMethodsInClass(self, @selector(viewWillDisappear:), @selector(_swizz_viewWillDisappear:));
    SwizzleInstanceMethodsInClass(self, @selector(viewDidDisappear:), @selector(_swizz_viewDidDisappear:));
}

- (void)_swizz_viewWillAppear:(BOOL)animated {
    self.isVisible = YES;
    self.isVisibleCurrently = YES;
    
    [self _swizz_viewWillAppear:animated];
}

- (void)_swizz_viewWillDisappear:(BOOL)animated {
    self.isVisibleCurrently = NO;
    
    [self _swizz_viewWillDisappear:animated];
}

- (void)_swizz_viewDidDisappear:(BOOL)animated {
    self.isVisible = NO;
    
    [self _swizz_viewDidDisappear:animated];
}

#pragma mark - Extensions

- (void)ensureViewIsLoaded {
    [self view];//this causes the view to get loaded
}

- (UIStatusBarStyle)inheritedPreferredStatusBarStyle {
    UIViewController *targetViewController = self.presentingViewController;
    if (!targetViewController) {
        return UIStatusBarStyleLightContent;
    }
    
    // walk all the way up the presenting chain
    while (targetViewController.parentViewController) {
        targetViewController = targetViewController.parentViewController;
    }
    
    // walk all the way down the status bar style chain
    while (targetViewController.childViewControllerForStatusBarStyle) {
        targetViewController = targetViewController.childViewControllerForStatusBarStyle;
    }
    
    return [targetViewController preferredStatusBarStyle];
}

- (void)styleNavigationBarWithColor:(nullable UIColor *)color {
    [self.navigationController.navigationBar styleWithColor:color];
}

- (void)hideBackButtonTitle {
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
}

- (UIViewController *)presentingViewControllerAcrossParents {
    // parent view controller
    if (self.parentViewController) {
        // -> recurse out at the parent;s level
        return self.tabBarController.presentingViewControllerAcrossParents;
    }
    // base case
    else {
        return self.presentingViewController;
    }
}

@end
