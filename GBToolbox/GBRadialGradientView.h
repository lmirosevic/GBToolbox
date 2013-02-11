//
//  GBRadialGradientView.h
//  GBToolbox
//
//  Created by Luka Mirosevic on 11/02/2013.
//  Copyright (c) 2013 Luka Mirosevic. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "GBToolbox.h"

@interface GBRadialGradientView : NSView

@property (strong, nonatomic) NSColor           *innerColor;
@property (strong, nonatomic) NSColor           *outerColor;
@property (assign, nonatomic) CGFloat           cornerRadius;
@property (assign, nonatomic) GBEdgeInsets      edgeInsets;

@end
