//
//  GBResizableImageView.h
//  GBToolbox
//
//  Created by Luka Mirosevic on 04/02/2013.
//  Copyright (c) 2013 Luka Mirosevic. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "GBToolbox.h"

@interface GBResizableImageView : NSImageView

@property (strong, nonatomic) NSImage           *image;
@property (assign, nonatomic) GBEdgeInsets      capInsets;

@end