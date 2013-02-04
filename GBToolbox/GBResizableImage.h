//
//  GBResizableImageView.h
//  GBToolbox
//
//  Created by Luka Mirosevic on 04/02/2013.
//  Copyright (c) 2013 Luka Mirosevic. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "GBMacros.h"

typedef struct {
    CGFloat top;
    CGFloat left;
    CGFloat bottom;
    CGFloat right;
} GBCapInsets;


@interface GBResizableImageView : NSView

@property (strong, nonatomic) NSImage           *image;
@property (assign, nonatomic) GBCapInsets       capInsets;

//- (void)setImage:(NSImage *)newImage;

GBCapInsets GBCapInsetsMake(CGFloat top, CGFloat left, CGFloat bottom, CGFloat right);

@end