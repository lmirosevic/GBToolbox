//
//  GBToolbox.h
//  Goonbee Toolbox
//
//  Created by Luka Mirosevic on 28/09/2012.
//  Copyright (c) 2012 Luka Mirosevic.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#import "GBMacros.h"

@interface GBToolbox : NSObject

#pragma mark - Math

// threshold
CGFloat ThresholdFloat(CGFloat value, CGFloat min, CGFloat max);
int ThresholdInt(int value, int min, int max);

// degrees & radians
CGFloat DegreesToRadians(CGFloat degrees);
CGFloat RadiansToDegrees(CGFloat radians);

// range
typedef struct {
    CGFloat min;
    CGFloat max;
} GBRange;
GBRange GBRangeMake(CGFloat min, CGFloat max);

// easing
double EaseOutExponential(double frame, double start, double delta, double totalFrames);
double EaseOutQuadratic(double frame, double start, double delta, double totalFrames);


#pragma mark - UI

// matrix grid
typedef struct {
    NSUInteger rows;
    NSUInteger columns;
} GBMatrixGrid;
GBMatrixGrid GBMatrixGridMake(NSUInteger rows, NSUInteger columns);
+(GBMatrixGrid)prettyMatrixGridLandscapeForCount:(NSUInteger)count;
+(GBMatrixGrid)prettyMatrixGridPortraitForCount:(NSUInteger)count;
+(GBMatrixGrid)prettyMatrixGridLandscapeForCount:(NSUInteger)count maxColumns:(NSUInteger)maxColumns;
+(GBMatrixGrid)prettyMatrixGridPortraitForCount:(NSUInteger)count maxColumns:(NSUInteger)maxColumns;

// UIView convenience
NSUInteger tagFromUIViewSubclass(id sender);

#pragma mark - Timing

// tic toc
+(void)tic;
+(NSTimeInterval)toc;


BOOL StringIsNumber(NSString *string);

@end


#pragma mark - String Category

@interface NSString (GBToolbox)

//check if string is integer
-(BOOL)isInteger;

@end


#pragma mark - UIImage Category

@interface UIImage (GBToolbox)

//crop to rect
-(UIImage *)cropToRect:(CGRect)rect;

@end


#pragma mark - NSData Category

@interface NSData (GBToolbox)

//md5 hash
-(NSString *)md5;

@end

#pragma mark - NSTimer Category

@interface NSTimer (GBToolbox)

//identifier 


//blocks
typedef void(^HandlerBlock)(void);
+(NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)interval repeats:(BOOL)repeats withBlock:(HandlerBlock)handler;

@end