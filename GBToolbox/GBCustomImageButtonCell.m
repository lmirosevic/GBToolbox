//
//  GBCustomImageButtonCell.m
//  GBToolbox
//
//  Created by Luka Mirosevic on 13/02/2013.
//  Copyright (c) 2013 Luka Mirosevic. All rights reserved.
//

#import "GBCustomImageButtonCell.h"

#import "GBToolbox.h"

@interface GBCustomImageButtonCell ()

@property (strong, nonatomic) GBResizableImageView      *resizableImageView;
@property (strong, nonatomic) NSImageView               *foregroundImageView;

@end


@implementation GBCustomImageButtonCell

#pragma mark - lazy

-(GBResizableImageView *)resizableImageView {
    if (!_resizableImageView) {
        _resizableImageView = [[GBResizableImageView alloc] initWithFrame:self.controlView.bounds];
        _resizableImageView.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
    }
    
    return _resizableImageView;
}

-(NSImageView *)foregroundImageView {
    if (!_foregroundImageView) {
        _foregroundImageView = [[NSImageView alloc] initWithFrame:self.controlView.bounds];
        _foregroundImageView.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
        //set scaling and alignment to just center the image without resizing
        _foregroundImageView.imageAlignment = NSImageAlignCenter;
        _foregroundImageView.imageScaling = NSScaleNone;
    }
    
    return _foregroundImageView;
}

#pragma mark - custom setter

-(void)setForegroundImage:(NSImage *)foregroundImage {
    _foregroundImage = foregroundImage;
    
    self.foregroundImageView.image = foregroundImage;
}

-(void)setBackgroundImage:(NSImage *)backgroundImage {
    self.resizableImageView.image = backgroundImage;
}

-(NSImage *)backgroundImage {
    return self.resizableImageView.image;
}

-(void)setBackgroundImageCapInsets:(GBEdgeInsets)backgroundImageCapInsets {
    self.resizableImageView.capInsets = backgroundImageCapInsets;
}

-(GBEdgeInsets)backgroundImageCapInsets {
    return self.resizableImageView.capInsets;
}

#pragma mark - init

-(void)awakeFromNib {
    self.backgroundView = self.resizableImageView;
    [self.backgroundView addSubview:self.foregroundImageView];
//    [self.controlView addSubview:self.foregroundImageView positioned:NSWindowAbove relativeTo:self.backgroundView];
}

@end
