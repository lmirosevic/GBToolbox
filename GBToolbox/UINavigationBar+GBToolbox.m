//
//  UINavigationBar+GBToolbox.m
//  Pods
//
//  Created by Luka Mirosevic on 18/09/2016.
//
//

#import "UINavigationBar+GBToolbox.h"

@implementation UINavigationBar (GBToolbox)

- (void)styleWithColor:(nullable UIColor *)color {
    // an actual color
    if (color && ![color isEqual:[UIColor clearColor]]) {
        [self setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
        self.shadowImage = nil;
        self.barTintColor = color;
    }
    // no color -> seethrough bar
    else {
        [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        self.shadowImage = [UIImage new];
        self.barTintColor = nil;
    }
}

@end
