//
//  GBUtility_Common.h
//  GBToolbox
//
//  Created by Luka Mirosevic on 05/02/2013.
//  Copyright (c) 2013 Luka Mirosevic. All rights reserved.
//

#import "GBTypes_Common.h"

@interface GBToolbox : NSObject

#pragma mark - Graphics

BOOL IsNonZeroSize(CGSize size);

#pragma mark - Thresholding

CGFloat ThresholdCGFloat(CGFloat value, CGFloat min, CGFloat max);
float ThresholdFloat(float value, float min, float max);
double ThresholdDouble(double value, double min, double max);
int ThresholdInt(int value, int min, int max);

#pragma mark - Degrees & Radians

CGFloat DegreesToRadians(CGFloat degrees);
CGFloat RadiansToDegrees(CGFloat radians);

#pragma mark - Range

GBRange GBRangeMake(CGFloat min, CGFloat max);

#pragma mark - Easing

double EaseOutExponential(double frame, double start, double delta, double totalFrames);
double EaseOutQuadratic(double frame, double start, double delta, double totalFrames);

#pragma mark - Linear algebra

CGFloat ScalarAbsolute(CGFloat value);
CGFloat Vector2DMagnitude(GBVector2D vector);

#pragma mark - Matrix grid

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

#pragma mark - Method Swizzling

void SwizzleInstanceMethodsInClass(Class aClass, SEL originalSelector, SEL newSelector);

#pragma mark - Delayed execution

void ExecuteAfter(CGFloat delay, void(^block)(void));

#pragma mark - Class availability

BOOL IsClassAvailableWithName(NSString *className);

@end