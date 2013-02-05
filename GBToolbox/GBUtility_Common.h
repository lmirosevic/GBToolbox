//
//  GBUtility_Common.h
//  GBToolbox
//
//  Created by Luka Mirosevic on 05/02/2013.
//  Copyright (c) 2013 Luka Mirosevic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

@interface GBToolbox : NSObject

#pragma mark - Graphics

BOOL IsNonZeroSize(CGSize size);

#pragma mark - Thresholding

CGFloat ThresholdFloat(CGFloat value, CGFloat min, CGFloat max);
double ThresholdDouble(double value, double min, double max);
int ThresholdInt(int value, int min, int max);

#pragma mark - Degrees & Radians

CGFloat DegreesToRadians(CGFloat degrees);
CGFloat RadiansToDegrees(CGFloat radians);

#pragma mark - Range

typedef struct {
    CGFloat min;
    CGFloat max;
} GBRange;

GBRange GBRangeMake(CGFloat min, CGFloat max);

#pragma mark - Easing

double EaseOutExponential(double frame, double start, double delta, double totalFrames);
double EaseOutQuadratic(double frame, double start, double delta, double totalFrames);

#pragma mark - Linear algebra

typedef struct {
    CGFloat x;
    CGFloat y;
} GBVector2D;

CGFloat ScalarAbsolute(CGFloat value);
CGFloat Vector2DMagnitude(GBVector2D vector);

#pragma mark - Matrix grid

typedef struct {
    NSUInteger rows;
    NSUInteger columns;
} GBMatrixGrid;

GBMatrixGrid GBMatrixGridMake(NSUInteger rows, NSUInteger columns);
+(GBMatrixGrid)prettyMatrixGridLandscapeForCount:(NSUInteger)count;
+(GBMatrixGrid)prettyMatrixGridPortraitForCount:(NSUInteger)count;
+(GBMatrixGrid)prettyMatrixGridLandscapeForCount:(NSUInteger)count maxColumns:(NSUInteger)maxColumns;
+(GBMatrixGrid)prettyMatrixGridPortraitForCount:(NSUInteger)count maxColumns:(NSUInteger)maxColumns;

#pragma mark - Tic Toc

+(void)tic;
+(NSTimeInterval)toc;

#pragma mark - Truthy/Falsy

BOOL Truthy(id object);
BOOL Falsy(id object);

#pragma mark - Even/Odd

BOOL EvenInt(int number);
BOOL EvenUInt(uint number);
BOOL EvenInteger(NSInteger number);
BOOL EvenUInteger(NSUInteger number);
BOOL OddInt(int number);
BOOL OddUInt(uint number);
BOOL OddInteger(NSInteger number);
BOOL OddUInteger(NSUInteger number);

@end