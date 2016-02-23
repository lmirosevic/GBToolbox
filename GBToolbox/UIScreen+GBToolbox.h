//
//  UIScreen+GBToolbox.h
//  GBToolbox
//
//  Created by Luka Mirosevic on 23/02/16.
//  Copyright © 2016 Luka Mirosevic. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScreen (GBToolbox)

/**
 Returns the bounds of the display, irrespective of the rotation.
 */
@property (assign, nonatomic, readonly) CGRect fixedBounds;

@end
