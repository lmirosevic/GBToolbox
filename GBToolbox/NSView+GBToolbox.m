//
//  NSView+GBToolbox.m
//  GBToolbox
//
//  Created by Luka Mirosevic on 05/02/2013.
//  Copyright (c) 2013 Luka Mirosevic. All rights reserved.
//

#import "NSView+GBToolbox.h"

#import "GBToolbox.h"

@implementation NSView (GBToolbox)

//returns the view's frame in global coordinates
-(NSRect)globalFrame {
    if ([self.window respondsToSelector:@selector(convertRectToScreen:)]) {//10.7
        return [self.window convertRectToScreen:self.frame];
    }
    else {
        NSRect frame = [self frame];
        frame.origin = [self.window convertBaseToScreen:frame.origin];
        return frame;
    }
}

//enumarate all subviews depth first
-(void)enumerateSubviewsWithBlock:(void(^)(NSView *view))block {
    //itself
    block(self);
    
    //then all its subviews
    for (NSView *subview in self.subviews) {
        [subview enumerateSubviewsWithBlock:block];
    }
}

@end
