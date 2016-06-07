//
//  UIViewController+GBToolbox.m
//  GBToolbox
//
//  Created by Luka Mirosevic on 05/02/2013.
//  Copyright (c) 2013 Luka Mirosevic. All rights reserved.
//

#import "UIViewController+GBToolbox.h"

#import "GBUtility_Common.h"
#import <objc/runtime.h>

@implementation UIViewController (GBToolbox)

static char gbIsVisibleKey;
static char gbIsVisibleCurrentlyKey;

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

+ (void)load {
    SwizzleInstanceMethodsInClass(self, @selector(viewWillAppear:), @selector(_swizz_viewWillAppear:));
    SwizzleInstanceMethodsInClass(self, @selector(viewWillDisappear:), @selector(_swizz_viewWillDisappear:));
    SwizzleInstanceMethodsInClass(self, @selector(viewDidDisappear:), @selector(_swizz_viewDidDisappear:));
}

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
    // an actual color
    if (color && ![color isEqual:[UIColor clearColor]]) {
        [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
        self.navigationController.navigationBar.shadowImage = nil;
        self.navigationController.navigationBar.barTintColor = color;
    }
    // no color -> seethrough bar
    else {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        self.navigationController.navigationBar.shadowImage = [UIImage new];
        self.navigationController.navigationBar.barTintColor = nil;
    }
}

- (void)hideBackButtonTitle {
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
}

@end
