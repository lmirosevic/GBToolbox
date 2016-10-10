//
//  GBRoundBadgeView.h
//  Russia
//
//  Created by Luka Mirosevic on 26/06/2013.
//  Copyright (c) 2013 Goonbee. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 A round badge view, that is composed of a background image that is aspect filled and a foreground image whose content mode can be freely specified. 
 
 It clips the edges to create a circle. 
 
 Useful for rounded profile pics, with an optional background image.
 */
@interface GBRoundBadgeView : UIView

@property (strong, nonatomic) UIImage                   *backgroundImage;
@property (strong, nonatomic) UIImage                   *foregroundImage;
@property (assign, nonatomic) UIViewContentMode         foregroundImageContentMode;
@property (assign, nonatomic) UIEdgeInsets              clippingMargin;
@property (assign, nonatomic) UIEdgeInsets              backgroundImageMargin;
@property (assign, nonatomic) UIEdgeInsets              foregroundImageMargin;

@end
