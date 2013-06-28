//
//  GBButton.h
//  GBToolbox
//
//  Created by Luka Mirosevic on 28/06/2013.
//  Copyright (c) 2013 Luka Mirosevic. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GBButton : UIButton

@property (strong, nonatomic) UIView        *leftView;
@property (assign, nonatomic) CGFloat       leftViewLeftOffset;
@property (assign, nonatomic) CGFloat       leftViewVerticalOffset;
@property (strong, nonatomic) UIView        *rightView;
@property (assign, nonatomic) CGFloat       rightViewRightOffset;
@property (assign, nonatomic) CGFloat       rightViewVerticalOffset;

@end
