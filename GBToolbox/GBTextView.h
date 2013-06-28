//
//  GBTextView.h
//  GBToolbox
//
//  Created by Luka Mirosevic on 28/06/2013.
//  Copyright (c) 2013 Goonbee. All rights reserved.
//
// Original code from SO: http://stackoverflow.com/a/1704469/399772

#import <UIKit/UIKit.h>

@interface GBTextView : UITextView

@property (nonatomic, retain) NSString      *placeholder;
@property (nonatomic, retain) UIColor       *placeholderColor;

-(void)textChanged:(NSNotification*)notification;

@end