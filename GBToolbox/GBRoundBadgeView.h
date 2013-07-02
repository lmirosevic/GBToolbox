//
//  GBRoundBadgeView.h
//  Russia
//
//  Created by Luka Mirosevic on 26/06/2013.
//  Copyright (c) 2013 Goonbee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GBRoundBadgeView : UIView

@property (strong, nonatomic) UIImage           *backgroundImage;
@property (strong, nonatomic) UIImage           *foregroundImage;

@property (assign, nonatomic) UIEdgeInsets      clippingMargin;
@property (assign, nonatomic) UIEdgeInsets      backgroundImageMargin;
@property (assign, nonatomic) UIEdgeInsets      foregroundImageMargin;

@end
