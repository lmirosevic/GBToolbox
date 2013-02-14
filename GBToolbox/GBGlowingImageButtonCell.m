//
//  GBGlowingImageButtonCell.m
//  GBToolbox
//
//  Created by Luka Mirosevic on 13/02/2013.
//  Copyright (c) 2013 Luka Mirosevic. All rights reserved.
//

#import "GBGlowingImageButtonCell.h"

#import "GBToolbox.h"


@interface GBGlowingImageButtonCell ()

@property (strong, nonatomic) GBRadialGradientView      *glowView;

@end


@implementation GBGlowingImageButtonCell


#pragma mark - lazy

-(GBRadialGradientView *)glowView {
    if (!_glowView) {
        _glowView = [[GBRadialGradientView alloc] initWithFrame:self.controlView.bounds];
        _glowView.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
        _glowView.innerColor = [[NSColor whiteColor] colorWithAlphaComponent:.07];
        _glowView.outerColor = [NSColor clearColor];
        _glowView.cornerRadius = 4;
    }
    
    return _glowView;
}

#pragma mark - custom accessor

-(void)setIsGlowing:(BOOL)isGlowing {
    //if theres a change
    if (isGlowing != _isGlowing) {
        if (isGlowing) {
            //add glow on top
            [self.controlView addSubview:self.glowView positioned:NSWindowAbove relativeTo:self.controlView.subviews.lastObject];
        }
        else {
            //remove the glow
            [self.glowView removeFromSuperview];
        }
    }
    
    //save ivar
    _isGlowing = isGlowing;
}

#pragma mark - init

-(void)awakeFromNib {
    [super awakeFromNib];
    
    self.isGlowing = YES;
}

@end
