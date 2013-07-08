//
//  UIView+GBToolbox.m
//  GBToolbox
//
//  Created by Luka Mirosevic on 22/05/2013.
//  Copyright (c) 2013 Luka Mirosevic. All rights reserved.
//

#import "UIView+GBToolbox.h"

@implementation UIView (GBToolbox)

-(void)removeAllSubviews {
    NSArray *subviews = [self.subviews copy];
    [subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
}

-(void)embedView:(UIView *)view {
    view.frame = self.bounds;
    [self addSubview:view];
}

-(BOOL)findAndResignFirstResponder {
    if (self.isFirstResponder) {
        [self resignFirstResponder];
        return YES;
    }
    for (UIView *subView in self.subviews) {
        if ([subView findAndResignFirstResponder]) {
            return YES;
        }
    }
    return NO;
}

@end


//foo add some utils to UIView to set its autoresizing mask to Top, TopRight, Center, CenterRight, etc. so I don't have to mess with the autoresizing mask bs