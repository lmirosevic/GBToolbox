//
//  GBToggleControl.h
//  GBToolbox
//
//  Created by Luka Mirosevic on 28/06/2013.
//  Copyright (c) 2013 Goonbee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GBToggleControl : UIControl

@property (strong, nonatomic) IBInspectable UIImage       *imageWhenOff;
@property (strong, nonatomic) IBInspectable UIImage       *imageWhenOn;
@property (strong, nonatomic) IBInspectable UIImage       *backgroundImageWhenOff;
@property (strong, nonatomic) IBInspectable UIImage       *backgroundImageWhenOn;

@property (assign, nonatomic) IBInspectable BOOL          isOn;

@end
