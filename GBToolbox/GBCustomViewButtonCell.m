//
//  GBCustomViewButtonCell.m
//  GBToolbox
//
//  Created by Luka Mirosevic on 13/02/2013.
//  Copyright (c) 2013 Luka Mirosevic. All rights reserved.
//

#import "GBCustomViewButtonCell.h"

#import "GBToolbox.h"

@interface NSDisabledTextView : NSTextView
@end

@implementation NSDisabledTextView

-(NSView *)hitTest:(NSPoint)aPoint {
    return nil;
}

@end

@interface GBCustomViewButtonCell ()

@property (assign, nonatomic) BOOL                      isDarkened;
@property (strong, nonatomic) NSDisabledTextView        *label;

@end


@implementation GBCustomViewButtonCell

#pragma mark - custom accessors

-(void)setFont:(NSFont *)font {
    self.label.font = font;
    
    CGFloat lineHeight = [[NSLayoutManager new] defaultLineHeightForFont:font];
    self.label.frame = NSMakeRect(0, (self.controlView.bounds.size.height - lineHeight)/2., self.controlView.bounds.size.width, lineHeight);
}

-(NSFont *)font {
    return self.label.font;
}

-(void)setTextColor:(NSColor *)textColor {
    self.label.textColor = textColor;
}

-(NSColor *)textColor {
    return self.label.textColor;
}

-(void)setText:(NSString *)text {
    self.label.string = [text copy];
}

-(NSString *)text {
    return self.label.string;
}

-(void)setAttributedText:(NSAttributedString *)attributedText {
    [self.label.textStorage setAttributedString:[attributedText copy]];
}

-(void)setEnabled:(BOOL)isEnabled {
    [super setEnabled:isEnabled];
    
    if (isEnabled) {
        self.customView.alphaValue = 1.;
    }
    else {
        self.customView.alphaValue = 0.5;
    }

}

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
    [self.controlView addSubview:customView positioned:NSWindowBelow relativeTo:self.label];
    
    //set frames to match
    _customView.frame = self.controlView.bounds;
    
    //set ivar
    _customView = customView;
}

#pragma mark - init

-(void)awakeFromNib {
    [super awakeFromNib];
    
    self.shouldDarkenOnTouch = YES;
    
    //label
    NSDisabledTextView *newTextView = [[NSDisabledTextView alloc] initWithFrame:self.controlView.bounds];
    newTextView.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
    newTextView.font = [NSFont fontWithName:@"HelveticaNeue-Bold" size:11];
    newTextView.textColor = [NSColor grayColor];
    newTextView.alignment = NSCenterTextAlignment;
    newTextView.editable = NO;
    newTextView.drawsBackground = YES;
    newTextView.backgroundColor = [NSColor clearColor];
    newTextView.selectable = NO;
    
    self.label = newTextView;
    [self.controlView addSubview:newTextView];
}

#pragma mark - clicking

-(NSCellHitResult)hitTestForEvent:(NSEvent *)event inRect:(NSRect)cellFrame ofView:(NSView *)controlView {
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
