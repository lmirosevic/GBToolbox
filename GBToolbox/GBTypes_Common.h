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
typedef BOOL(^BoolBlock)(void);
typedef void(^VoidBlockBool)(BOOL isTrue);

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

#pragma mark - Special keys

typedef enum {
    GBSpecialKeyReturn      = 1,
    GBSpecialKeyBackspace   = 2,
    GBSpecialKeyF1          = 3,
    GBSpecialKeyF2          = 4,
    GBSpecialKeyF3          = 5,
    GBSpecialKeyF4          = 6,
    GBSpecialKeyF5          = 7,
    GBSpecialKeyF6          = 8,
    GBSpecialKeyF7          = 9,
    GBSpecialKeyF8          = 10,
    GBSpecialKeyF9          = 11,
    GBSpecialKeyF10         = 12,
    GBSpecialKeyF11         = 13,
    GBSpecialKeyF12         = 14,
    GBSpecialKeyEsc         = 15,
    GBSpecialKeyCmdDown     = 16,
    GBSpecialKeyCtrlDown    = 17,
    GBSpecialKeyAltDown     = 18,
    GBSpecialKeyHome        = 19,
    GBSpecialKeyPageUp      = 20,
    GBSpecialKeyEnd         = 21,
    GBSpecialKeyPageDown    = 22,
    GBSpecialKeyUp          = 23,
    GBSpecialKeyLeft        = 24,
    GBSpecialKeyDown        = 25,
    GBSpecialKeyRight       = 26,
    GBSpecialKeyCtrlUp      = 27,
    GBSpecialKeyAltUp       = 28,
    GBSpecialKeyCmdUp       = 29,
} GBSpecialKey;

#endif
