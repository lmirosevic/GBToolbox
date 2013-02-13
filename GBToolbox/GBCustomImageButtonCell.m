//
//  GBCustomImageButtonCell.m
//  GBToolbox
//
//  Created by Luka Mirosevic on 13/02/2013.
//  Copyright (c) 2013 Luka Mirosevic. All rights reserved.
//

#import "GBCustomImageButtonCell.h"


@interface GBCustomImageButtonCell ()

@property (strong, nonatomic) GBResizableImageView *resizableImageView;

@end


@implementation GBCustomImageButtonCell

#pragma mark - lazy

-(GBResizableImageView *)resizableImageView {
    if (!_resizableImageView) {
        _resizableImageView = [[GBResizableImageView alloc] initWithFrame:self.controlView.frame];
//        _resizableImageView.capInsets = self.backgroundImageCapInsets;
//        _resizableImageView.image = self.backgroundImage;
        _resizableImageView.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
    }
    
    return _resizableImageView;
}

#pragma mark - custom setter

-(void)setBackgroundImage:(NSImage *)backgroundImage {
    self.resizableImageView.image = backgroundImage;
    
//    _backgroundImage = backgroundImage;
}

-(NSImage *)backgroundImage {
    return self.resizableImageView.image;
}

-(void)setBackgroundImageCapInsets:(GBEdgeInsets)backgroundImageCapInsets {
    self.resizableImageView.capInsets = backgroundImageCapInsets;
    
//    _backgroundImageCapInsets = backgroundImageCapInsets;
}

-(GBEdgeInsets)backgroundImageCapInsets {
    return self.resizableImageView.capInsets;
}

#pragma mark - init

-(void)awakeFromNib {
    self.backgroundView = self.resizableImageView;
}

//-(void)_performMyInitializations {
//    //set the resizable imageview as own background
//    
//    self.backgroundView = self.resizableImageView;
//}
//
//-(id)init {
//    if (self = [super init]) {
//        [self _performMyInitializations];
//    }
//    
//    return self;
//}
//
//-(id)initImageCell:(NSImage *)image {
//    if (self = [super initImageCell:image]) {
//        [self _performMyInitializations];
//    }
//    
//    return self;
//}
//
//-(id)initTextCell:(NSString *)aString {
//    if (self = [super initTextCell:aString]) {
//        [self _performMyInitializations];
//    }
//    
//    return self;
//}
//
//-(id)initWithCoder:(NSCoder *)aDecoder {
//    if (self = [super initWithCoder:aDecoder]) {
//        [self _performMyInitializations];
//    }
//    
//    return self;
//}

@end
