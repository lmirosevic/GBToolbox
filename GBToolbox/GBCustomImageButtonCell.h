//
//  GBCustomImageButtonCell.h
//  GBToolbox
//
//  Created by Luka Mirosevic on 13/02/2013.
//  Copyright (c) 2013 Luka Mirosevic. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "GBToolbox.h"

@interface GBCustomImageButtonCell : GBCustomViewButtonCell

@property (strong, nonatomic) NSImage           *backgroundImage;
@property (assign, nonatomic) GBEdgeInsets      backgroundImageCapInsets;

@end
