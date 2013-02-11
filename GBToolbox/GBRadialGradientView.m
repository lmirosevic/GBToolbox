//
//  GBRadialGradientView.m
//  GBToolbox
//
//  Created by Luka Mirosevic on 11/02/2013.
//  Copyright (c) 2013 Luka Mirosevic. All rights reserved.
//

#import "GBRadialGradientView.h"

@implementation GBRadialGradientView

#pragma mark - init

-(id)initWithFrame:(NSRect)frameRect {
    if (self = [super initWithFrame:frameRect]) {
        self.innerColor = [[NSColor whiteColor] colorWithAlphaComponent:.12];
        self.outerColor = [NSColor clearColor];
        self.cornerRadius = 4;
    }
    
    return self;
}

#pragma mark - custom properties

-(void)setEdgeInsets:(GBEdgeInsets)edgeInsets {
    _edgeInsets = edgeInsets;
    
    [self setNeedsDisplay:YES];
}

-(void)setInnerColor:(NSColor *)innerColor {
    _innerColor = innerColor;
    
    [self setNeedsDisplay:YES];
}

-(void)setOuterColor:(NSColor *)outerColor {
    _outerColor = outerColor;
    
    [self setNeedsDisplay:YES];
}

-(void)setCornerRadius:(CGFloat)cornerRadius {
    _cornerRadius = cornerRadius;
    
    [self setNeedsDisplay:YES];
}

#pragma mark - drawing

- (void)drawRect:(NSRect)dirtyRect {
    CGRect preliminaryClipRect = CGRectMake(self.edgeInsets.left, self.edgeInsets.bottom, self.bounds.size.width - self.edgeInsets.left - self.edgeInsets.right, self.bounds.size.height - self.edgeInsets.bottom - self.edgeInsets.top);
    NSBezierPath *path = [NSBezierPath bezierPathWithRoundedRect:preliminaryClipRect xRadius:self.cornerRadius yRadius:self.cornerRadius];
    NSGradient *gradient = [[NSGradient alloc] initWithStartingColor:self.innerColor endingColor:self.outerColor];
    [gradient drawInBezierPath:path relativeCenterPosition:NSMakePoint(0, 0)];
}

@end
