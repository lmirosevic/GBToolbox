//
//  UINavigationBar+GBToolbox.h
//  Pods
//
//  Created by Luka Mirosevic on 18/09/2016.
//
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (GBToolbox)

/**
 Set the navigation bar background color with a more sane behaviour than the standard Cocoa Touch methods.
 
 If color is nil, the bar will be transparent.
 */
- (void)styleWithColor:(nullable UIColor *)color;

@end
