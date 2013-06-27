//
//  UIView+GBToolbox.h
//  GBToolbox
//
//  Created by Luka Mirosevic on 22/05/2013.
//  Copyright (c) 2013 Luka Mirosevic. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (GBToolbox)

//Removes all subviews
-(void)removeAllSubviews;

//Sets the view's frame to the receiver's bounds and adds it as a subview
-(void)embedView:(UIView *)view;

@end
