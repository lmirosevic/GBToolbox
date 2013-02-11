//
//  GBUtility_Common.m
//  GBToolbox
//
//  Created by Luka Mirosevic on 05/02/2013.
//  Copyright (c) 2013 Luka Mirosevic. All rights reserved.
//

#import "GBUtility_Common.h"

#import <objc/runtime.h>

@implementation GBToolbox

#pragma mark - Graphics

BOOL IsNonZeroSize(CGSize size) {
    return ((size.width != 0) && (size.height != 0));
}

#pragma mark - Thresholding

CGFloat ThresholdCGFloat(CGFloat value, CGFloat min, CGFloat max) {
    if (value < min) {
        return min;
    }
    else if (value > max) {
        return max;
    }
    else {
        return value;
    }
}

float ThresholdFloat(float value, float min, float max) {
    if (value < min) {
        return min;
    }
    else if (value > max) {
        return max;
    }
    else {
        return value;
    }
}

double ThresholdDouble(double value, double min, double max) {
    if (value < min) {
        return min;
    }
    else if (value > max) {
        return max;
    }
    else {
        return value;
    }
}

int ThresholdInt(int value, int min, int max) {
    if (value < min) {
        return min;
    }
    else if (value > max) {
        return max;
    }
    else {
        return value;
    }
}

#pragma mark - Degrees & Radians

CGFloat DegreesToRadians(CGFloat degrees) {return degrees * M_PI / 180;};
CGFloat RadiansToDegrees(CGFloat radians) {return radians * 180 / M_PI;};

#pragma mark - Range

GBRange GBRangeMake(CGFloat min, CGFloat max) {
    GBRange newRange;
    newRange.min = min;
    newRange.max = max;
    return newRange;
}

#pragma mark - Easing

double EaseOutExponential(double frame, double start, double delta, double totalFrames) {
	return delta * ( -pow( 2, -30 * (double)frame/(double)totalFrames ) + 1 ) + start;
}

double EaseOutQuadratic(double frame, double start, double delta, double totalFrames) {
    frame /= totalFrames;
	return -delta * frame*(frame-2) + start;
}


#pragma mark - Linear algebra

CGFloat ScalarAbsolute(CGFloat value) {
    return value >= 0 ? value : -value;
}

CGFloat Vector2DMagnitude(GBVector2D vector) {
    return pow(vector.x * vector.x + vector.y * vector.y, 0.5);
}

#pragma mark - Matrix grid

GBMatrixGrid GBMatrixGridMake(NSUInteger rows, NSUInteger columns) {
    GBMatrixGrid matrixSize;
    matrixSize.rows = rows;
    matrixSize.columns = columns;
    
    return matrixSize;
}

+(GBMatrixGrid)prettyMatrixGridLandscapeForCount:(NSUInteger)count {
    return [self prettyMatrixGridLandscapeForCount:count maxColumns:NSUIntegerMax];
}
+(GBMatrixGrid)prettyMatrixGridPortraitForCount:(NSUInteger)count {
    return [self prettyMatrixGridPortraitForCount:count maxColumns:NSUIntegerMax];
}

+(GBMatrixGrid)prettyMatrixGridLandscapeForCount:(NSUInteger)count maxColumns:(NSUInteger)maxColumns {
    if (count <= 3) {
        switch (count) {
            case 1:
                return GBMatrixGridMake(1, 1);
            case 2:
                return GBMatrixGridMake(1, 2);
            case 3:
                return GBMatrixGridMake(1, 3);
                
            default:
                return GBMatrixGridMake(0, 0);
        }
    }
    else {
        CGFloat root = sqrt((CGFloat)count);
        NSUInteger rows = floor(root);
        NSUInteger columns = round(root)+1;
        
        if (columns <= maxColumns) {
            return GBMatrixGridMake(rows, columns);
            
        }
        else {
            NSUInteger rows = ceil((CGFloat)count/(CGFloat)maxColumns);
            return GBMatrixGridMake(rows, maxColumns);
        }
    }
}

+(GBMatrixGrid)prettyMatrixGridPortraitForCount:(NSUInteger)count maxColumns:(NSUInteger)maxColumns {
    if (count <= 2) {
        switch (count) {
            case 1:
                return GBMatrixGridMake(1, 1);
            case 2:
                return GBMatrixGridMake(1, 2);
                
            default:
                return GBMatrixGridMake(0, 0);
        }
    }
    else {
        CGFloat root = sqrt((CGFloat)count);
        NSUInteger rows = floor(root);
        NSUInteger columns = round(root)+1;
        
        if (columns <= maxColumns) {
            return GBMatrixGridMake(rows, columns);
        }
        else {
            NSUInteger rows = ceil((CGFloat)count/(CGFloat)maxColumns);
            return GBMatrixGridMake(rows, maxColumns);
        }
    }
    
}

#pragma mark - Tic Toc

static NSTimeInterval __time;

+(void)tic {
    __time = [NSDate timeIntervalSinceReferenceDate];
}

+(NSTimeInterval)toc {
    return [NSDate timeIntervalSinceReferenceDate] - __time;
}

#pragma mark - Truthy/Falsy

BOOL Truthy(id object) {
    return (object && (object != [NSNull null]));
}

BOOL Falsy(id object) {
    return !Truthy(object);
}

#pragma mark - Even/Odd

BOOL EvenInt(int number) {
    return (number%2 == 0);
}

BOOL EvenUInt(uint number) {
    return (number%2 == 0);
}

BOOL EvenInteger(NSInteger number) {
    return (number%2 == 0);
}

BOOL EvenUInteger(NSUInteger number) {
    return (number%2 == 0);
}

BOOL OddInt(int number) {
    return !EvenInt(number);
}
BOOL OddUInt(uint number) {
    return !EvenUInt(number);
}
BOOL OddInteger(NSInteger number) {
    return !EvenInteger(number);
}

BOOL OddUInteger(NSUInteger number) {
    return !EvenUInteger(number);
}

#pragma mark - Method Swizzling

void SwizzleInstanceMethods(Class aClass, SEL originalSelector, SEL newSelector) {
    method_exchangeImplementations(class_getInstanceMethod(aClass, originalSelector), class_getInstanceMethod(aClass, newSelector));
}

@end
