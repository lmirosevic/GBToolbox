//
//  UIView+GBPopUp.h
//  GBToolbox
//
//  Created by Luka Mirosevic on 08/07/2013.
//  Copyright (c) 2013 Luka Mirosevic. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (GBPopUp)

@property (strong, nonatomic) UIColor               *popUpBackgroundColor;
@property (assign, nonatomic, readonly) BOOL        isPresentedAsPopUp;

-(void)presentAsPopUpOnWindowAnimated:(BOOL)animated;
-(void)presentAsPopUpOnView:(UIView *)targetView animated:(BOOL)animated;
-(void)dismissAsPopUpAnimated:(BOOL)animated;

@end
