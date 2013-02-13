//
//  GBResizableImageView.m
//  GBToolbox
//
//  Created by Luka Mirosevic on 04/02/2013.
//  Copyright (c) 2013 Luka Mirosevic. All rights reserved.
//

#import "GBResizableImageView.h"

@interface GBResizableImageView ()

@property (strong, nonatomic) NSImage *topLeftCornerImage;
@property (strong, nonatomic) NSImage *topEdgeFillImage;
@property (strong, nonatomic) NSImage *topRightCornerImage;
@property (strong, nonatomic) NSImage *leftEdgeFillImage;
@property (strong, nonatomic) NSImage *centerFillImage;
@property (strong, nonatomic) NSImage *rightEdgeFillImage;
@property (strong, nonatomic) NSImage *bottomLeftCornerImage;
@property (strong, nonatomic) NSImage *bottomEdgeFillImage;
@property (strong, nonatomic) NSImage *bottomRightCornerImage;

@end


@implementation GBResizableImageView

#pragma mark - public api

-(void)setImage:(NSImage *)image {
    _image = image;
    
    [self _generateFragmentImages];
    [self setNeedsDisplay:YES];
}

-(void)setCapInsets:(GBEdgeInsets)capInsets {
    _capInsets = capInsets;

    [self _generateFragmentImages];
    [self setNeedsDisplay:YES];
}

#pragma mark - drawing

-(void)drawRect:(NSRect)dirtyRect {
    NSDrawNinePartImage([self bounds], self.topLeftCornerImage, self.topEdgeFillImage, self.topRightCornerImage, self.leftEdgeFillImage, self.centerFillImage, self.rightEdgeFillImage, self.bottomLeftCornerImage, self.bottomEdgeFillImage, self.bottomRightCornerImage, NSCompositeSourceOver, 1.0, NO);
}

#pragma mark - private

-(void)_generateFragmentImages {
    {
        CGRect targetRect = CGRectMake(0, 0, self.capInsets.left, self.capInsets.top);
        CGRect sourceRect = CGRectMake(0, self.image.size.height - self.capInsets.top, self.capInsets.left, self.capInsets.top);
        
        if (IsNonZeroSize(targetRect.size)) {
            NSImage *targetFragment = [[NSImage alloc] initWithSize:targetRect.size];
            [targetFragment lockFocus];
            [self.image drawInRect:targetRect fromRect:sourceRect operation:NSCompositeCopy fraction:1.0];
            [targetFragment unlockFocus];
            self.topLeftCornerImage = targetFragment;
        }
    }
    
    {
        CGRect targetRect = CGRectMake(0, 0, self.image.size.width - self.capInsets.left - self.capInsets.right, self.capInsets.top);
        CGRect sourceRect = CGRectMake(self.capInsets.left, self.image.size.height - self.capInsets.top, self.image.size.width - self.capInsets.left - self.capInsets.right, self.capInsets.top);
        
        if (IsNonZeroSize(targetRect.size)) {
            NSImage *targetFragment = [[NSImage alloc] initWithSize:targetRect.size];
            [targetFragment lockFocus];
            [self.image drawInRect:targetRect fromRect:sourceRect operation:NSCompositeCopy fraction:1.0];
            [targetFragment unlockFocus];
            self.topEdgeFillImage = targetFragment;
        }
    }
    
    {
        CGRect targetRect = CGRectMake(0, 0, self.capInsets.right, self.capInsets.top);
        CGRect sourceRect = CGRectMake(self.image.size.width - self.capInsets.right, self.image.size.height - self.capInsets.top, self.capInsets.right, self.capInsets.top);
        
        if (IsNonZeroSize(targetRect.size)) {
            NSImage *targetFragment = [[NSImage alloc] initWithSize:targetRect.size];
            [targetFragment lockFocus];
            [self.image drawInRect:targetRect fromRect:sourceRect operation:NSCompositeCopy fraction:1.0];
            [targetFragment unlockFocus];
            self.topRightCornerImage = targetFragment;
        }
    }
    
    {
        CGRect targetRect = CGRectMake(0, 0, self.capInsets.left, self.image.size.height - self.capInsets.top - self.capInsets.bottom);
        CGRect sourceRect = CGRectMake(0, self.capInsets.bottom, self.capInsets.left, self.image.size.height - self.capInsets.top - self.capInsets.bottom);
        
        if (IsNonZeroSize(targetRect.size)) {
	        NSImage *targetFragment = [[NSImage alloc] initWithSize:targetRect.size];
	        [targetFragment lockFocus];
	        [self.image drawInRect:targetRect fromRect:sourceRect operation:NSCompositeCopy fraction:1.0];
	        [targetFragment unlockFocus];
	        self.leftEdgeFillImage = targetFragment;
        }
    }

    {
        CGRect targetRect = CGRectMake(0, 0, self.image.size.width - self.capInsets.left - self.capInsets.right, self.image.size.height - self.capInsets.top - self.capInsets.bottom);
        CGRect sourceRect = CGRectMake(self.capInsets.left, self.capInsets.bottom, self.image.size.width - self.capInsets.left - self.capInsets.right, self.image.size.height - self.capInsets.top - self.capInsets.bottom);
        
        if (IsNonZeroSize(targetRect.size)) {
	        NSImage *targetFragment = [[NSImage alloc] initWithSize:targetRect.size];
	        [targetFragment lockFocus];
	        [self.image drawInRect:targetRect fromRect:sourceRect operation:NSCompositeCopy fraction:1.0];
	        [targetFragment unlockFocus];
            self.centerFillImage = targetFragment;
        }
    }

    {
        CGRect targetRect = CGRectMake(0, 0, self.capInsets.right, self.bounds.size.height - self.capInsets.top - self.capInsets.bottom);
        CGRect sourceRect = CGRectMake(self.image.size.width - self.capInsets.right, self.capInsets.bottom, self.capInsets.right, self.image.size.height - self.capInsets.top - self.capInsets.bottom);
        
        if (IsNonZeroSize(targetRect.size)) {
	        NSImage *targetFragment = [[NSImage alloc] initWithSize:targetRect.size];
	        [targetFragment lockFocus];
	        [self.image drawInRect:targetRect fromRect:sourceRect operation:NSCompositeCopy fraction:1.0];
	        [targetFragment unlockFocus];
	        self.rightEdgeFillImage = targetFragment;
        }
    }
        
    {
        CGRect targetRect = CGRectMake(0, 0, self.capInsets.left, self.capInsets.bottom);
        CGRect sourceRect = CGRectMake(0, 0, self.capInsets.left, self.capInsets.bottom);
        
        if (IsNonZeroSize(targetRect.size)) {
	        NSImage *targetFragment = [[NSImage alloc] initWithSize:targetRect.size];
	        [targetFragment lockFocus];
	        [self.image drawInRect:targetRect fromRect:sourceRect operation:NSCompositeCopy fraction:1.0];
	        [targetFragment unlockFocus];
	        self.bottomLeftCornerImage = targetFragment;
        }
    }

    {
        CGRect targetRect = CGRectMake(0, 0, self.image.size.width - self.capInsets.left - self.capInsets.right, self.capInsets.bottom);
        CGRect sourceRect = CGRectMake(self.capInsets.left, 0, self.image.size.width - self.capInsets.left - self.capInsets.right, self.capInsets.bottom);
        
        if (IsNonZeroSize(targetRect.size)) {
	        NSImage *targetFragment = [[NSImage alloc] initWithSize:targetRect.size];
	        [targetFragment lockFocus];
	        [self.image drawInRect:targetRect fromRect:sourceRect operation:NSCompositeCopy fraction:1.0];
	        [targetFragment unlockFocus];
	        self.bottomEdgeFillImage = targetFragment;
        }
    }
    
    {
        CGRect targetRect = CGRectMake(0, 0, self.capInsets.right, self.capInsets.bottom);
        CGRect sourceRect = CGRectMake(self.image.size.width - self.capInsets.right, 0, self.capInsets.right, self.capInsets.bottom);
        
        if (IsNonZeroSize(targetRect.size)) {
	        NSImage *targetFragment = [[NSImage alloc] initWithSize:targetRect.size];
	        [targetFragment lockFocus];
	        [self.image drawInRect:targetRect fromRect:sourceRect operation:NSCompositeCopy fraction:1.0];
	        [targetFragment unlockFocus];
	        self.bottomRightCornerImage = targetFragment;
        }
    }
}

@end
