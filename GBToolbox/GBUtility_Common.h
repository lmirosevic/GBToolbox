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
long ThresholdLong(long value, long min, long max);

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
BOOL Lines1DOverlap(CGFloat Line1Origin, CGFloat Line1Length, CGFloat Line2Origin, CGFloat Line2Length);

#pragma mark - Matrix grid

GBMatrixGrid GBMatrixGridMake(NSUInteger rows, NSUInteger columns);
+(GBMatrixGrid)prettyMatrixGridLandscapeForCount:(NSUInteger)count;
+(GBMatrixGrid)prettyMatrixGridPortraitForCount:(NSUInteger)count;
+(GBMatrixGrid)prettyMatrixGridLandscapeForCount:(NSUInteger)count maxColumns:(NSUInteger)maxColumns;
+(GBMatrixGrid)prettyMatrixGridPortraitForCount:(NSUInteger)count maxColumns:(NSUInteger)maxColumns;

#pragma mark - Type contructors

GBEdgeInsets GBEdgeInsetsMake(CGFloat top, CGFloat left, CGFloat bottom, CGFloat right);

#pragma mark - Tic Toc

void Tic();
NSTimeInterval TocInterval();
void Toc();

/**
 * Runs the block immediately (on the same thread), and returns the time it took to execute.
 */
NSTimeInterval _TimeToRun(void(^block)());

#pragma mark - Truthy/Falsy

BOOL IsTruthy(id object);
BOOL IsFalsy(id object);

#pragma mark - Even/Odd

BOOL IsEvenInt(int number);
BOOL IsEvenUInt(uint number);
BOOL IsEvenInteger(NSInteger number);
BOOL IsEvenUInteger(NSUInteger number);
BOOL IsOddInt(int number);
BOOL IsOddUInt(uint number);
BOOL IsOddInteger(NSInteger number);
BOOL IsOddUInteger(NSUInteger number);

#pragma mark - Runtime introspection

void AssertCorrectClass(id object, Class aClass);

#pragma mark - Method Swizzling

void SwizzleInstanceMethodsInClass(Class aClass, SEL originalSelector, SEL newSelector);
void SwizzleClassMethodsInClass(Class aClass, SEL originalSelector, SEL newSelector);

#pragma mark - Delayed execution

void ExecuteAfter(CGFloat delay, void(^block)(void));
void ExecuteAfterCancellable(NSString *cancelIdentifier, CGFloat delay, void(^block)(void));
void CancelExecuteAfter(NSString *cancelIdentifier);
void ExecuteSoon(void(^block)(void));
void ExecuteAfterScrolling(void(^block)(void));

#pragma mark - App introspection

NSString * AppBundleName();
NSString * AppBundleDisplayName();
NSString * AppBundleIdentifier();

#pragma mark - Error prevention
//When you don't want nil strings

//If string is nil, returns @""
NSString * Denilify(NSString *string);
//Just passes the string through the format printer guy
NSString * Stringify(NSString *string);

#pragma mark - Push notifications

//Converts an opaque push device token data blob to a string
NSString * PushDeviceToken2String(NSData *deviceToken);

#pragma mark - Locale

//Returns YES if the current locale uses metric units for distance, temperature, etc..
BOOL IsUserLocaleMetric();

//Returns the currency symbol in ISO 4271 for the user's current locale
NSString * PreferredCurrency();

#pragma mark - Random

//Returns a random integer between min and max
NSInteger RandomIntegerBetween(NSInteger min, NSInteger max);

//Returns a random CGFloat between 0 and 1
CGFloat Random();

#pragma mark - Crashing

/**
 Crashes the process by dereferencing a NULL pointer
 */
void CrashByDereferencingNullPointer();

/**
 Throws an exception.
 */
void CrashByThrowingExeption();

#pragma mark - Bitmasks

/**
 Returns YES if bitmask A is a subset of bitmask B.
 */
BOOL IsBitmaskASubsetOfBitmaskB(NSUInteger bitmaskA, NSUInteger bitmaskB);

/**
 Returns YES if bitmask A is a superset of bitmask B.
 */
BOOL IsBitmaskASupersetOfBitmaskB(NSUInteger bitmaskA, NSUInteger bitmaskB);

#pragma mark - String formatting

/**
 Returns a simplified time string from the seconds, e.g. "59:59" or 23:59:59".
 */
NSString * PrettyTimeStringFromSeconds(NSInteger seconds);

/**
 Turns a dictionary of strings into the query string format for use in a URL.
 */
NSString * HTTPQueryStringFromDictionary(NSDictionary *getDictionary);

@end
