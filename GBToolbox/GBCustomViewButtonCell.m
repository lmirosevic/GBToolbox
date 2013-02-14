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

@property (assign, nonatomic) BOOL              isDarkened;

@end


@implementation GBCustomViewButtonCell

#pragma mark - custom accessors

-(void)setShouldDarkenOnTouch:(BOOL)shouldDarkenOnTouch {
    _shouldDarkenOnTouch = shouldDarkenOnTouch;
    
    //set darkened again to retrigger the side effects
    self.isDarkened = self.isDarkened;
}

-(void)setIsDarkened:(BOOL)isDarkened {
    if (self.shouldDarkenOnTouch) {
        if (isDarkened) {
            //apply filter
            CIFilter *filter = [CIFilter filterWithName:@"CIGammaAdjust"];
            [filter setDefaults];
            [filter setValue:@(1.2) forKey:@"inputPower"];
            self.customView.contentFilters = @[filter];
        }
        else {
            //hide darkness
            self.customView.contentFilters = nil;
        }
    }
    
    _isDarkened = isDarkened;
}

//adds the custom view as a subview to the controlView
-(void)setCustomView:(NSView *)customView {
    //remove old view
    [_customView removeFromSuperview];
    
    //add new view
    [self.controlView addSubview:customView];
    
    //set frames to match
    _customView.frame = self.controlView.bounds;
    
    //set ivar
    _customView = customView;
}

#pragma mark - init

-(void)awakeFromNib {
    [super awakeFromNib];
    
    self.shouldDarkenOnTouch = YES;
}

#pragma mark - clicking

-(NSUInteger)hitTestForEvent:(NSEvent *)event inRect:(NSRect)cellFrame ofView:(NSView *)controlView {
    //see if the hit is inside or outside of the cell
    NSPoint pointInWindow = event.locationInWindow;
    NSRect rectInWindow = [controlView convertRect:controlView.bounds toView:nil];
    
    return NSPointInRect(pointInWindow, rectInWindow) ? NSCellHitContentArea : NSCellHitNone;
}

-(BOOL)trackMouse:(NSEvent *)theEvent inRect:(NSRect)cellFrame ofView:(NSView *)controlView untilMouseUp:(BOOL)untilMouseUp {
    if ([theEvent type] == NSLeftMouseDown) {
        [self _mouseDown];
        
        NSEvent *myEvent;
        while ((myEvent = [controlView.window nextEventMatchingMask:(NSLeftMouseDragged | NSLeftMouseUp)])) {
            if ([myEvent type] == NSLeftMouseUp) {
                [self _mouseUp];
                
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

-(void)drawInteriorWithFrame:(NSRect)cellFrame inView:(NSView *)controlView {
    //nothing
}

-(void)drawBezelWithFrame:(NSRect)frame inView:(NSView *)controlView {
    //nothing
}

-(void)drawImage:(NSImage *)image withFrame:(NSRect)frame inView:(NSView *)controlView {
    //nothing
}

@end
