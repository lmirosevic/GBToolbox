//
//  GBGradientView.h
//  Pods
//
//  Created by Luka Mirosevic on 13/11/2014.
//
//

#import <UIKit/UIKit.h>

@interface GBGradientView : UIView

typedef NS_ENUM(NSInteger, GBGradientDimension) {
    GBGradientDimensionVertical,
    GBGradientDimensionHorizontal,
};

/**
 Creates a GBGradientView with it's background set to a gradient.
 */
+ (instancetype)gradientViewWithColors:(NSArray<UIColor *> *)colors dimension:(GBGradientDimension)dimension;

@end
