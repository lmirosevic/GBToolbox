//
//  GBResizableImageView.m
//  GBToolbox
//
//  Created by Luka Mirosevic on 04/02/2013.
//  Copyright (c) 2013 Luka Mirosevic. All rights reserved.
//

#import "GBResizableImage.h"

#import "GBToolbox.h"

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

@property (assign, nonatomic) BOOL hasGeneratedFragments;

@end


@implementation GBResizableImageView

#pragma mark - public api

GBCapInsets GBCapInsetsMake(CGFloat top, CGFloat left, CGFloat bottom, CGFloat right) {
    GBCapInsets capInsets;
    
    capInsets.top = top;
    capInsets.left = left;
    capInsets.bottom = bottom;
    capInsets.right = right;
    
    return capInsets;
}

-(void)setImage:(NSImage *)image {
    l(@"set iamge");
    
    _image = image;
    
    [self _generateFragmentImages];
    [self setNeedsDisplay:YES];
}

-(void)setCapInsets:(GBCapInsets)capInsets {
    l(@"set capinsets");
    
    _capInsets = capInsets;

    [self _generateFragmentImages];
    [self setNeedsDisplay:YES];
}

#pragma mark - drawing

-(void)drawRect:(NSRect)dirtyRect {
    l(@"drawrect");
    
    NSDrawNinePartImage([self bounds], self.topLeftCornerImage, self.topEdgeFillImage, self.topRightCornerImage, self.leftEdgeFillImage, self.centerFillImage, self.rightEdgeFillImage, self.bottomLeftCornerImage, self.bottomEdgeFillImage, self.bottomRightCornerImage, NSCompositeSourceOver, 1.0, NO);
}

#pragma mark - private

//static NSImage *croppedImageWithRect(NSImage *image, NSRect rect) {//foo test
//    NSImage *subImage = [[NSImage alloc] initWithSize:rect.size];
//    NSRect drawRect = NSZeroRect;
//    drawRect.size = rect.size;
//    [subImage lockFocus];
//    [image drawInRect:drawRect
//             fromRect:rect
//            operation:NSCompositeSourceOver
//             fraction:1.0f];
//    [subImage unlockFocus];
//    return subImage;
//}


-(void)_generateFragmentImages {
    {
        CGRect targetRect = CGRectMake(0, self.bounds.size.height - self.capInsets.top, self.capInsets.left, self.capInsets.top);
        CGRect sourceRect = CGRectMake(0, self.image.size.height - self.capInsets.top, self.capInsets.left, self.capInsets.top);
        
        if (IsNonZeroSize(targetRect.size)) {
            NSImage *targetFragment = [[NSImage alloc] initWithSize:targetRect.size];
            [targetFragment lockFocus];
            [self.image drawInRect:targetRect fromRect:sourceRect operation:NSCompositeCopy fraction:1.0];
            [targetFragment unlockFocus];
            self.topLeftCornerImage = targetFragment;
            
            l(@"target rect: %f %f %f %f", targetRect.origin.x, targetRect.origin.y, targetRect.size.width, targetRect.size.height);
            [self.topLeftCornerImage saveAsJpegWithName:@"/Users/lm/Desktop/image.jpg"];
        }
    }
    
    {
        CGRect targetRect = CGRectMake(self.capInsets.left, self.bounds.size.height - self.capInsets.top, self.bounds.size.width - self.capInsets.left - self.capInsets.right, self.capInsets.top);
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
        CGRect targetRect = CGRectMake(self.bounds.size.width - self.capInsets.right, self.bounds.size.height - self.capInsets.top, self.capInsets.right, self.capInsets.top);
        CGRect sourceRect = CGRectMake(self.image.size.width - self.capInsets.right, self.image.size.height - self.capInsets.top, self.capInsets.left, self.capInsets.top);
        
        if (IsNonZeroSize(targetRect.size)) {
            NSImage *targetFragment = [[NSImage alloc] initWithSize:targetRect.size];
            [targetFragment lockFocus];
            [self.image drawInRect:targetRect fromRect:sourceRect operation:NSCompositeCopy fraction:1.0];
            [targetFragment unlockFocus];
            self.topRightCornerImage = targetFragment;
        }
    }
    
    
    
    
    
    
    {
        CGRect targetRect = CGRectMake(0, self.capInsets.bottom, self.capInsets.left, self.bounds.size.height - self.capInsets.top - self.capInsets.bottom);
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
        CGRect targetRect = CGRectMake(self.capInsets.left, self.capInsets.bottom, self.bounds.size.width - self.capInsets.left - self.capInsets.right, self.bounds.size.height - self.capInsets.top - self.capInsets.bottom);
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
        CGRect targetRect = CGRectMake(self.bounds.size.width - self.capInsets.right, self.capInsets.bottom, self.capInsets.right, self.bounds.size.height - self.capInsets.top - self.capInsets.bottom);
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
        CGRect targetRect = CGRectMake(self.capInsets.left, 0, self.bounds.size.width - self.capInsets.left - self.capInsets.right, self.capInsets.bottom);
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
        CGRect targetRect = CGRectMake(self.bounds.size.width - self.capInsets.right, 0, self.capInsets.right, self.capInsets.bottom);
        CGRect sourceRect = CGRectMake(self.bounds.size.width - self.capInsets.right, 0, self.capInsets.right, self.capInsets.bottom);
        
        if (IsNonZeroSize(targetRect.size)) {
	        NSImage *targetFragment = [[NSImage alloc] initWithSize:targetRect.size];
	        [targetFragment lockFocus];
	        [self.image drawInRect:targetRect fromRect:sourceRect operation:NSCompositeCopy fraction:1.0];
	        [targetFragment unlockFocus];
	        self.bottomRightCornerImage = targetFragment;
        }
    }

    
    self.hasGeneratedFragments = YES;
}

@end
