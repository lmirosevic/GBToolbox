//
//  GBColoredBarView.m
//  Russia
//
//  Created by Luka Mirosevic on 27/06/2013.
//  Copyright (c) 2013 Goonbee. All rights reserved.
//

#import "GBColoredBarView.h"

#define kDefaultBorderColor                                 [UIColor blackColor]
#define kDefaultBackgroundColorWhenEmpty                    [UIColor clearColor]
#define kDefaultBackgroundColorWhenFull                     [UIColor clearColor]
static BOOL const kDefaultShowBorderWhenFull =              NO;
static BOOL const kDefaultShowBorderWhenEmpty =             YES;
static CGFloat const kDefaultBorderThickness =              1;

@implementation GBColoredBarView

#pragma mark - custom accessors

-(void)setColors:(NSArray *)colors {
    if (colors.count >= self.fractions.count) {
        _colors = colors;
        
        [self setNeedsDisplay];
    }
    else {
        NSLog(@"ColoredBarView: You must set more colors than fractions!");
    }
}

-(void)setFractions:(NSArray *)fractions {
    if (fractions.count <= self.colors.count) {
        _fractions = fractions;
    
        [self setNeedsDisplay];
    }
    else {
        NSLog(@"ColoredBarView: You must set less colors than fractions, set colors first!");
    }
}

-(void)setBackgroundColorWhenEmpty:(UIColor *)backgroundColorWhenEmpty {
    _backgroundColorWhenEmpty = backgroundColorWhenEmpty;
    
    [self setNeedsDisplay];
}

-(void)setBackgroundColorWhenFull:(UIColor *)backgroundColorWhenFull {
    _backgroundColorWhenFull = backgroundColorWhenFull;
    
    [self setNeedsDisplay];
}

-(void)setBorderColor:(UIColor *)borderColor {
    _borderColor = borderColor;
    
    [self setNeedsDisplay];
}

-(void)setBorderThickness:(CGFloat)borderThickness {
    _borderThickness = borderThickness;
    
    [self setNeedsDisplay];
}

-(void)setShowBorderWhenFull:(BOOL)showBorderWhenFull {
    _showBorderWhenFull = showBorderWhenFull;
    
    [self setNeedsDisplay];
}

-(void)setShowBorderWhenEmpty:(BOOL)showBorderWhenEmpty {
    _showBorderWhenEmpty = showBorderWhenEmpty;
    
    [self setNeedsDisplay];
}

#pragma mark - life

-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self _init];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self _init];
    }
    return self;
}

-(void)_init {
    self.backgroundColorWhenEmpty = kDefaultBackgroundColorWhenEmpty;
    self.backgroundColorWhenFull = kDefaultBackgroundColorWhenFull;
    self.borderColor = kDefaultBorderColor;
    self.showBorderWhenFull = kDefaultShowBorderWhenFull;
    self.showBorderWhenEmpty = kDefaultShowBorderWhenEmpty;
    self.borderThickness = kDefaultBorderThickness;
    
    self.backgroundColor = [UIColor clearColor];
}

#pragma mark - util

-(BOOL)_isEmpty {
    //bail if no fractions set
    if (!self.fractions) return YES;
    
    for (NSNumber *fraction in self.fractions) {
        //find a non zero fraction
        if (![fraction isEqualToNumber:@(0)]) {
            return NO;
        }
    }
    
    //if we didn't return yet, it means we're empty
    return YES;
}

-(UIColor *)_currentBackgroundColor {
    if ([self _isEmpty]) {
        return self.backgroundColorWhenEmpty;
    }
    else {
        return self.backgroundColorWhenFull;
    }
}

#pragma mark - drawing

-(void)drawRect:(CGRect)rect {
    CGContextRef c = UIGraphicsGetCurrentContext();
    
    //background
    CGContextSetFillColorWithColor(c, [self _currentBackgroundColor].CGColor);
    CGContextFillRect(c, rect);
    
    //fill areas
    if (![self _isEmpty]) {
        //calculate sum
        CGFloat fractionsSum = 0;
        for (NSNumber *fraction in self.fractions) {
            fractionsSum += [fraction floatValue];
        }
    
        //do the drawing of individual areas
        CGFloat lastX1 = rect.origin.x;
        for (NSUInteger i=0; i<self.fractions.count; i++) {
            CGFloat fractionFloat = [self.fractions[i] floatValue];
            CGFloat x1 = lastX1;
            CGFloat x2 = (fractionFloat / fractionsSum) * self.bounds.size.width;
            
            CGContextSetFillColorWithColor(c, ((UIColor *)self.colors[i]).CGColor);
            CGContextFillRect(c, CGRectMake(x1, rect.origin.y, x2, rect.size.height));
            
            lastX1 = lastX1 + x2;
        }
    }
    
    //border
    if (([self _isEmpty] && self.showBorderWhenEmpty) ||
        (![self _isEmpty] && self.showBorderWhenFull)) {
        CGContextSetStrokeColorWithColor(c, self.borderColor.CGColor);
        CGContextStrokeRectWithWidth(c, rect, self.borderThickness);
    }
}

@end
