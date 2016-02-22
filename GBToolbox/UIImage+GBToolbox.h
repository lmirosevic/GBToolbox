//
//  UIImage+GBToolbox.h
//  GBToolbox
//
//  Created by Luka Mirosevic on 05/02/2013.
//  Copyright (c) 2013 Luka Mirosevic. All rights reserved.
//
//
//  Based on:
//
// UIImage+Resize.h
// Created by Trevor Harmon on 8/5/09.
// Free for personal or commercial use, with or without modification.
// No warranty is expressed or implied.

#import <UIKit/UIKit.h>

@interface UIImage (GBToolbox)

-(UIImage *)cropToRect:(CGRect)rect;
-(UIImage *)resizedImage:(CGSize)newSize interpolationQuality:(CGInterpolationQuality)quality;
-(UIImage *)resizedImageWithContentMode:(UIViewContentMode)contentMode bounds:(CGSize)bounds interpolationQuality:(CGInterpolationQuality)quality;

#pragma mark - Programmatic images

+ (UIImage *)imageWithSolidColor:(UIColor *)color size:(CGSize)size;
+ (UIImage *)imageWithSolidColor:(UIColor *)color size:(CGSize)size capInsets:(UIEdgeInsets)capInsets;

#pragma mark - Apple UIImage+ImageEffects

-(UIImage *)applyLightEffect;
-(UIImage *)applyExtraLightEffect;
-(UIImage *)applyDarkEffect;
-(UIImage *)applyTintEffectWithColor:(UIColor *)tintColor;

-(UIImage *)applyBlurWithRadius:(CGFloat)blurRadius tintColor:(UIColor *)tintColor saturationDeltaFactor:(CGFloat)saturationDeltaFactor maskImage:(UIImage *)maskImage;

#pragma mark - Tint

- (UIImage *)tintedImage:(UIColor *)tintColor;

@end
