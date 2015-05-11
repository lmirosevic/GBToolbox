//
//  GBCustomViewButtonCell.h
//  GBToolbox
//
//  Created by Luka Mirosevic on 13/02/2013.
//  Copyright (c) 2013 Luka Mirosevic. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface GBCustomViewButtonCell : NSButtonCell

@property (strong, nonatomic) NSView                *customView;
@property (assign, nonatomic) BOOL                  shouldDarkenOnTouch;
@property (copy, nonatomic) NSString                *text;
@property (copy, nonatomic) NSAttributedString      *attributedText;
@property (strong, nonatomic) NSColor               *textColor;
@property (strong, atomic) NSFont                   *font;

@end
