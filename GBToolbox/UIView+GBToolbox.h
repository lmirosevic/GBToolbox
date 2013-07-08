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

//Resigns the first responder for any subview of the receiver. Some code from SO: http://stackoverflow.com/a/1823360/399772
-(BOOL)findAndResignFirstResponder;

@end
