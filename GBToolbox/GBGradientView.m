//
//  GBGradientView.m
//  Pods
//
//  Created by Luka Mirosevic on 13/11/2014.
//
//

#import "GBGradientView.h"

#import "NSArray+GBToolbox.h"

@interface GBGradientView ()

@property (strong, nonatomic) CAGradientLayer   *myGradientLayer;

@end

@implementation GBGradientView

#pragma mark - API

+ (instancetype)gradientViewWithColors:(NSArray<UIColor *> *)colors dimension:(GBGradientDimension)dimension {
    // configure my view
    GBGradientView *view = [[self alloc] initWithFrame:CGRectMake(0., 0., 0., 0.)];
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    
    switch (dimension) {
        case GBGradientDimensionHorizontal: {
            gradientLayer.startPoint = CGPointMake(0.0, 0.5);
            gradientLayer.endPoint = CGPointMake(1.0, 0.5);
        } break;
            
        case GBGradientDimensionVertical: {
            gradientLayer.startPoint = CGPointMake(0.5, 0.0);
            gradientLayer.endPoint = CGPointMake(0.5, 1.0);
        } break;
    }
    
    gradientLayer.frame = view.bounds;
    gradientLayer.colors = [colors map:^id(id object) {
        return (id)[object CGColor];
    }];
    [view.layer insertSublayer:gradientLayer atIndex:0];
    
    // store the layer
    view.myGradientLayer = gradientLayer;
    
    return view;
}

#pragma mark - Overrides

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // resize the layer when the view changes size
    self.myGradientLayer.frame = self.bounds;
}

@end
