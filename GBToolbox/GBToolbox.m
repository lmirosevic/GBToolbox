//
//  GBToolbox.m
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

#import "GBToolbox.h"

@implementation GBToolbox

#pragma mark - Math

//threshold
CGFloat ThresholdFloat(CGFloat value, CGFloat min, CGFloat max) {
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

//degrees & radians
CGFloat DegreesToRadians(CGFloat degrees) {return degrees * M_PI / 180;};
CGFloat RadiansToDegrees(CGFloat radians) {return radians * 180 / M_PI;};

// range
GBRange GBRangeMake(CGFloat min, CGFloat max) {
    GBRange newRange;
    newRange.min = min;
    newRange.max = max;
    return newRange;
}

//easing
double EaseOutExponential(double frame, double start, double delta, double totalFrames) {
	return delta * ( -pow( 2, -30 * (double)frame/(double)totalFrames ) + 1 ) + start;
}

double EaseOutQuadratic(double frame, double start, double delta, double totalFrames) {
    frame /= totalFrames;
	return -delta * frame*(frame-2) + start;
}


#pragma mark - UI

// matrix grid
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

// UIView convenience
NSUInteger tagFromUIViewSubclass(id sender) {
    if ([sender isKindOfClass:[UIView class]]) {
        return ((UIView *)sender).tag;
    }
    else return 0;
}

#pragma mark - timing

// tic toc
static NSTimeInterval __time;

+(void)tic {
    __time = [NSDate timeIntervalSinceReferenceDate];
}

+(NSTimeInterval)toc {
    return [NSDate timeIntervalSinceReferenceDate] - __time;
}


#pragma mark - Convenience

// truthy/falsy
BOOL Truthy(id object) {
    return (object && (object != [NSNull null]));
}

BOOL Falsy(id object) {
    return !Truthy(object);
}


// even/odd
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

@end


#pragma mark - String category

@implementation NSString (NSString_GBUtil)

//check if string is an integer
-(BOOL)isInteger {
    NSCharacterSet *alphaNums = [NSCharacterSet decimalDigitCharacterSet];
    NSCharacterSet *stringSet = [NSCharacterSet characterSetWithCharactersInString:self];
    
    return [alphaNums isSupersetOfSet:stringSet];
}

@end



#pragma mark - UIImage category

@implementation UIImage (UIImage_GBUtil)

//crop to rect
-(UIImage *)cropToRect:(CGRect)rect {
    CGImageRef imageRef = CGImageCreateWithImageInRect([self CGImage], rect);
    
    UIImage *croppedImage = [[UIImage alloc] initWithCGImage:imageRef scale:1.0 orientation:self.imageOrientation];
    
    CGImageRelease(imageRef);
    
    return croppedImage;
}

@end


#pragma mark - NSData category

#import <CommonCrypto/CommonDigest.h>

@implementation NSData (NSData_GBUtil)

//md5 hash
-(NSString *)md5 {
    unsigned char result[16];
    CC_MD5(self.bytes, self.length, result);
    
    return [NSString stringWithFormat: @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

@end


#pragma mark - NSTimer Category

@interface NSTimer (GBToolbox_Private)

//blocks
-(void)callBlock:(HandlerBlock)block;

@end

@implementation NSTimer (GBToolbox)

//blocks
+(NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)interval repeats:(BOOL)repeats withBlock:(HandlerBlock)handler {
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[self instanceMethodSignatureForSelector:@selector(callBlock:)]];
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:interval invocation:invocation repeats:repeats];
                      
    [invocation setTarget:timer];
    [invocation setSelector:@selector(callBlock:)];
    
    HandlerBlock copy = [handler copy];
//    Block_copy(handler);//foo make sure i'm not leaking blocks here, or causing a crash by not copying it
    [invocation setArgument:&copy atIndex:2];
//    Block_release(handler);
    
    return timer;
}

-(void)callBlock:(HandlerBlock)block {
    block();
}

@end


#pragma mark - NSObject Category

#import <objc/runtime.h>

@implementation NSObject (GBToolbox)

static char gbDescriptionKey;

-(void)setGbDescription:(NSString *)gbDescription {
    objc_setAssociatedObject(self, &gbDescriptionKey, gbDescription, OBJC_ASSOCIATION_COPY);
}

-(NSString *)gbDescription {
    return objc_getAssociatedObject(self, &gbDescriptionKey);
}

@end


#pragma mark - UITableView Category

#define kIsScrolledToBottomTolerance 2

@implementation UITableView (GBToolbox)

-(BOOL)isScrolledToBottom {
    if (self.contentSize.height - self.bounds.size.height - self.contentOffset.y <= kIsScrolledToBottomTolerance) {
        return YES;
    }
    else {
        return NO;
    }
}

@end