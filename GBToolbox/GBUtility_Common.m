//
//  GBUtility_Common.m
//  GBToolbox
//
//  Created by Luka Mirosevic on 05/02/2013.
//  Copyright (c) 2013 Luka Mirosevic. All rights reserved.
//

#import "GBUtility_Common.h"

//delayed execution
#import "NSTimer+GBToolbox.h"

//Swizzling
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

BOOL Lines1DOverlap(CGFloat Line1Origin, CGFloat Line1Length, CGFloat Line2Origin, CGFloat Line2Length) {
    if (Line1Origin+Line1Length < Line2Origin) return NO;
    if (Line1Origin > Line2Origin+Line2Length) return NO;
    return YES;
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

#pragma mark - Type contructors

GBEdgeInsets GBEdgeInsetsMake(CGFloat top, CGFloat left, CGFloat bottom, CGFloat right) {
    GBEdgeInsets edgeInsets;
    
    edgeInsets.top = top;
    edgeInsets.left = left;
    edgeInsets.bottom = bottom;
    edgeInsets.right = right;
    
    return edgeInsets;
}

#pragma mark - Tic Toc

static NSTimeInterval __time;

void Tic() {
    __time = [NSDate timeIntervalSinceReferenceDate];
}

NSTimeInterval TocInterval() {
    return [NSDate timeIntervalSinceReferenceDate] - __time;
}

void Toc() {
    NSLog(@"TicToc: %f", TocInterval());
}

#pragma mark - Truthy/Falsy

BOOL IsTruthy(id object) {
    return (object && (object != [NSNull null]));
}

BOOL IsFalsy(id object) {
    return !IsTruthy(object);
}

#pragma mark - Even/Odd

BOOL IsEvenInt(int number) {
    return (number%2 == 0);
}

BOOL IsEvenUInt(uint number) {
    return (number%2 == 0);
}

BOOL IsEvenInteger(NSInteger number) {
    return (number%2 == 0);
}

BOOL IsEvenUInteger(NSUInteger number) {
    return (number%2 == 0);
}

BOOL IsOddInt(int number) {
    return !IsEvenInt(number);
}
BOOL IsOddUInt(uint number) {
    return !IsEvenUInt(number);
}
BOOL IsOddInteger(NSInteger number) {
    return !IsEvenInteger(number);
}

BOOL IsOddUInteger(NSUInteger number) {
    return !IsEvenUInteger(number);
}

#pragma mark - Method Swizzling

void SwizzleInstanceMethodsInClass(Class aClass, SEL originalSelector, SEL newSelector) {
    method_exchangeImplementations(class_getInstanceMethod(aClass, originalSelector), class_getInstanceMethod(aClass, newSelector));
}

#pragma mark - Delayed execution

static NSMutableDictionary *_cancellableBlocks;
NSMutableDictionary * cancellableBlocks() {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _cancellableBlocks = [NSMutableDictionary new];
    });
    
    return _cancellableBlocks;
}

void ExecuteAfter(CGFloat delay, void(^block)(void)) {
    ExecuteAfterCancellable(nil, delay, block);
}

void ExecuteAfterCancellable(NSString *cancelIdentifier, CGFloat delay, void(^block)(void)) {
    NSTimer *timer;
    
    if (cancelIdentifier) {
        //first create the timer
        timer = [NSTimer timerWithTimeInterval:delay repeats:NO withBlock:^{
            //first call original block
            block();

            //then remove from list
            [cancellableBlocks() removeObjectForKey:cancelIdentifier];
        }];
        
        //then remember it so we can cancel it later
        cancellableBlocks()[cancelIdentifier] = timer;
    }
    else {
        timer = [NSTimer timerWithTimeInterval:delay repeats:NO withBlock:block];
    }
    
    //schedule it
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

void CancelExecuteAfter(NSString *cancelIdentifier) {
    if (cancelIdentifier) {
        //find timer
        NSTimer *timer = cancellableBlocks()[cancelIdentifier];
        
        //invalidate it
        [timer invalidate];
        
        //remove the timer from the list
        [cancellableBlocks() removeObjectForKey:cancelIdentifier];
    }
}

void ExecuteSoon(void(^block)(void)) {
    ExecuteAfter(0, block);
}

void ExecuteAfterScrolling(void(^block)(void)) {
    NSTimer *timer = [NSTimer timerWithTimeInterval:0 repeats:NO withBlock:block];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
}

#pragma mark - Class availability

BOOL IsClassAvailableWithName(NSString *className) {
    return [NSClassFromString(className) class] ? YES : NO;
}

#pragma mark - App introspection

NSString * AppBundleName() {
    return [[NSBundle mainBundle] localizedInfoDictionary][@"CFBundleName"] ?: [[NSBundle mainBundle] infoDictionary][@"CFBundleName"];
}

NSString * AppBundleDisplayName() {
    return [[NSBundle mainBundle] localizedInfoDictionary][@"CFBundleDisplayName"] ?: [[NSBundle mainBundle] infoDictionary][@"CFBundleDisplayName"];
}

NSString * AppBundleIdentifier() {
    return [[NSBundle mainBundle] infoDictionary][@"CFBundleIdentifier"];
}

#pragma mark - Error prevention


NSString * Denilify(NSString *string) {
    return (string ? string : @"");
}

NSString * Stringify(NSString *string) {
    return [NSString stringWithFormat:@"%@", string];
}

#pragma mark - Push notifications

//original from SO: http://stackoverflow.com/a/9372848/399772
NSString * PushDeviceToken2String(NSData *deviceToken) {
    const unsigned *tokenBytes = [deviceToken bytes];
    NSString *hexToken = [NSString stringWithFormat:@"%08x%08x%08x%08x%08x%08x%08x%08x",
                          ntohl(tokenBytes[0]), ntohl(tokenBytes[1]), ntohl(tokenBytes[2]),
                          ntohl(tokenBytes[3]), ntohl(tokenBytes[4]), ntohl(tokenBytes[5]),
                          ntohl(tokenBytes[6]), ntohl(tokenBytes[7])];
    return hexToken;
}

#pragma mark - Locale

//Returns YES if the current locale uses metric units for distance, temperature, etc..
BOOL IsMetric() {
    return [[[NSLocale currentLocale] objectForKey:NSLocaleUsesMetricSystem] boolValue];
}

@end
