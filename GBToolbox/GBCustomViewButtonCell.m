//
//  GBCustomViewButtonCell.m
//  GBToolbox
//
//  Created by Luka Mirosevic on 13/02/2013.
//  Copyright (c) 2013 Luka Mirosevic. All rights reserved.
//

#import "GBCustomViewButtonCell.h"

#import "GBToolbox.h"


@interface GBCustomViewButtonCell ()

@end


@implementation GBCustomViewButtonCell

#pragma mark - custom accessors

-(void)setIsDarkened:(BOOL)isDarkened {
    if (isDarkened) {
        //apply filter
        CIFilter *filter = [CIFilter filterWithName:@"CIGammaAdjust"];
        [filter setDefaults];
        [filter setValue:@(1.2) forKey:@"inputPower"];
        self.backgroundView.contentFilters = @[filter];
    }
    else {
        //hide darkness
        self.backgroundView.contentFilters = nil;
    }
}

//adds the background view as a subview to the controlView
-(void)setBackgroundView:(NSView *)backgroundView {
    //remove old view
    [_backgroundView removeFromSuperview];
    
    //add new view
    [self.controlView addSubview:backgroundView];
    
    //set frames to match
    backgroundView.frame = self.controlView.bounds;
    
    //set ivar
    _backgroundView = backgroundView;
}

#pragma mark - clicking

-(BOOL)trackMouse:(NSEvent *)theEvent inRect:(NSRect)cellFrame ofView:(NSView *)controlView untilMouseUp:(BOOL)untilMouseUp {
    if ([theEvent type] == NSLeftMouseDown) {
        [self _mouseDown];
        
        NSEvent *myEvent;
        while ((myEvent = [controlView.window nextEventMatchingMask:(NSLeftMouseDragged | NSLeftMouseUp)])) {
            if ([myEvent type] == NSLeftMouseUp) {
                [self _mouseUp];
                
                //perform click if mouse is inside
                if ([self hitTestForEvent:myEvent inRect:cellFrame ofView:controlView]) {
                    [self performClick:controlView];
                }
                
                return YES;
            }
        }
    }
    
    return [super trackMouse:theEvent inRect:cellFrame ofView:controlView untilMouseUp:untilMouseUp];
}

-(void)_mouseDown {
    self.isDarkened = YES;
}

-(void)_mouseUp {
    self.isDarkened = NO;
}

#pragma mark - drawing

-(void)drawBezelWithFrame:(NSRect)frame inView:(NSView *)controlView {
    //nothing
}

-(void)drawImage:(NSImage *)image withFrame:(NSRect)frame inView:(NSView *)controlView {
    //nothing
}

@end
