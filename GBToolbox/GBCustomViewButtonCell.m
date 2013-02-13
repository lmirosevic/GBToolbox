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

-(void)setImage:(NSImage *)image {
    [super setImage:image];
    
    l(@"set image");
}

#pragma mark - drawing

-(void)drawBezelWithFrame:(NSRect)frame inView:(NSView *)controlView {
    //nothing
}

-(void)drawImage:(NSImage *)image withFrame:(NSRect)frame inView:(NSView *)controlView {
    //nothing
}

@end
