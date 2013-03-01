//
//  GBTypes_Common.h
//  GBToolbox
//
//  Created by Luka Mirosevic on 11/02/2013.
//  Copyright (c) 2013 Luka Mirosevic. All rights reserved.
//

#ifndef GBToolbox_GBTypes_Common_h
#define GBToolbox_GBTypes_Common_h

#import <CoreGraphics/CoreGraphics.h>

typedef struct {
    CGFloat min;
    CGFloat max;
} GBRange;

typedef struct {
    CGFloat x;
    CGFloat y;
} GBVector2D;

typedef struct {
    NSUInteger rows;
    NSUInteger columns;
} GBMatrixGrid;

typedef void(^VoidBlock)(void);

#endif
