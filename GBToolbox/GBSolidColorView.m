//
//  GBSolidColorView.m
//  GBToolbox
//
//  Created by Luka Mirosevic on 13/02/2013.
//  Copyright (c) 2013 Luka Mirosevic. All rights reserved.
//

#import "GBSolidColorView.h"

@implementation GBSolidColorView

-(id)initWithColor:(NSColor *)color {
    if (self = [super init]) {
        self.color = color;
    }
    
    return self;
}

-(void)setColor:(NSColor *)color {
    _color = color;
    
    [self setNeedsDisplay:YES];
}

- (void)drawRect:(NSRect)dirtyRect {
    [self.color setFill];
    NSRectFill(dirtyRect);
}

@end
