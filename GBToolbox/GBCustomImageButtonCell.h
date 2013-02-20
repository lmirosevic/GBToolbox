//
//  GBCustomImageButtonCell.h
//  GBToolbox
//
//  Created by Luka Mirosevic on 13/02/2013.
//  Copyright (c) 2013 Luka Mirosevic. All rights reserved.
//

#import "GBCustomViewButtonCell.h"

#import "GBTypes_OSX.h"

@interface GBCustomImageButtonCell : GBCustomViewButtonCell

@property (strong, nonatomic) NSImage           *backgroundImage;
@property (assign, nonatomic) GBEdgeInsets      backgroundImageCapInsets;
@property (strong, nonatomic) NSImage           *foregroundImage;

@end
