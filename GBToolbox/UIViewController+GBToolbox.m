//
//  UIViewController+GBToolbox.m
//  GBToolbox
//
//  Created by Luka Mirosevic on 05/02/2013.
//  Copyright (c) 2013 Luka Mirosevic. All rights reserved.
//

#import "UIViewController+GBToolbox.h"

#import <objc/runtime.h>

#import "GBUtility_Common.h"

@implementation UIViewController (GBToolbox)

//returns YES when the view controller is visible
static char gbIsVisibleKey;

-(void)setIsVisible:(BOOL)isVisible {
    objc_setAssociatedObject(self, &gbIsVisibleKey, @(isVisible), OBJC_ASSOCIATION_COPY);
}

-(BOOL)isVisible {
    return [objc_getAssociatedObject(self, &gbIsVisibleKey) boolValue];
}

-(void)_SwizzViewWillAppear:(BOOL)animated {
    self.isVisible = YES;
    
    [self _SwizzViewWillAppear:animated];
}

-(void)_SwizzViewDidDisappear:(BOOL)animated {
    self.isVisible = NO;
    
    [self _SwizzViewDidDisappear:animated];
}

+(void)load {
    SwizzleInstanceMethods(self, @selector(viewWillAppear:), @selector(_SwizzViewWillAppear:));
    SwizzleInstanceMethods(self, @selector(viewDidDisappear:), @selector(_SwizzViewDidDisappear:));
}

@end