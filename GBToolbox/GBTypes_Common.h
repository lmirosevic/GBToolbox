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

#pragma mark - General

typedef void(^VoidBlock)(void);

#pragma mark - Range

typedef struct {
    CGFloat min;
    CGFloat max;
} GBRange;

#pragma mark - Linear algebra

typedef struct {
    CGFloat x;
    CGFloat y;
} GBVector2D;

#pragma mark - UI

typedef struct {
    NSUInteger rows;
    NSUInteger columns;
} GBMatrixGrid;

typedef struct {
    CGFloat top;
    CGFloat left;
    CGFloat bottom;
    CGFloat right;
} GBEdgeInsets;

#pragma mark - GBBoolean

typedef enum {
    BUndefined,
    BYES,
    BNO,
} GBBoolean;

static inline BOOL IsTruthyBool(GBBoolean boolean) {
    return boolean == BYES;
}

static inline GBBoolean Number2Bool(NSNumber *number) {
    if ([number isKindOfClass:[NSNumber class]]) {
        if ([number boolValue] == YES) {
            return BYES;
        }
        else if ([number boolValue] == NO) {
            return BNO;
        }
    }
    
    return BUndefined;
}

static inline NSNumber * Bool2Number(GBBoolean boolean) {
    switch (boolean) {
        case BYES:
            return @(YES);
            
        case BNO:
            return @(NO);
            
        case BUndefined:
        default:
            return nil;
    }
}

#endif
