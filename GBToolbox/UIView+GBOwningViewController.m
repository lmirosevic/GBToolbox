//
//  UIView+GBOwningViewController.m
//  GBToolbox
//
//  Created by Luka Mirosevic on 08/06/2017.
//  Copyright (c) 2017 Luka Mirosevic. All rights reserved.
//

#import "UIView+GBToolbox.h"

#import "GBUtility_Common.h"
#import <objc/runtime.h>

@interface UIView ()

@property (weak, nonatomic, nullable, readwrite) UIViewController *GBOwningViewController;

@end

@implementation UIView (GBOwningViewController)

#pragma mark - CA

static char gbOwningViewController;

- (void)setGBOwningViewController:(UIViewController *)owningViewController {
    objc_setAssociatedObject(self, &gbOwningViewController, owningViewController, OBJC_ASSOCIATION_ASSIGN);
}

- (UIViewController *)GBOwningViewController {
    return objc_getAssociatedObject(self, &gbOwningViewController);
}

@end

@interface UIViewController (GBOwningViewController)

@end

@implementation UIViewController (GBOwningViewController)

#pragma mark - Overrides

+ (void)load {
    SwizzleInstanceMethodsInClass(self, @selector(setView:), @selector(_swizz_setView:));
}

- (void)_swizz_setView:(UIView *)view {
    // deassociate self from old view
    if (self.isViewLoaded) {
        self.view.GBOwningViewController = nil;
    }
    
    // call default implementation
    [self _swizz_setView:view];
    
    // associate self to new view
    view.GBOwningViewController = self;
}

@end
