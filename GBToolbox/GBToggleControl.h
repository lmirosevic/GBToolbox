//
//  GBToggleControl.h
//  GBToolbox
//
//  Created by Luka Mirosevic on 28/06/2013.
//  Copyright (c) 2013 Goonbee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GBToggleControl : UIControl

@property (strong, nonatomic) UIImage       *imageWhenOff;
@property (strong, nonatomic) UIImage       *imageWhenOn;
@property (strong, nonatomic) UIImage       *backgroundImageWhenOff;
@property (strong, nonatomic) UIImage       *backgroundImageWhenOn;

@property (assign, nonatomic) BOOL          isOn;

@end
