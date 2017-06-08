//
//  UIView+GBOwningViewController.h
//  GBToolbox
//
//  Created by Luka Mirosevic on 08/06/2017.
//  Copyright (c) 2017 Luka Mirosevic. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (GBOwningViewController)

/**
 The view controller that currently has this view set as its `view` property.
 */
@property (weak, nonatomic, nullable, readonly) UIViewController *GBOwningViewController;

@end
