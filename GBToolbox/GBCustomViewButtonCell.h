//
//  GBCustomViewButtonCell.h
//  GBToolbox
//
//  Created by Luka Mirosevic on 13/02/2013.
//  Copyright (c) 2013 Luka Mirosevic. All rights reserved.
//

#import <Cocoa/Cocoa.h>

//#import "GBToolbox.h"

//cell which u can add a custom view to
@interface GBCustomViewButtonCell : NSButtonCell

@property (strong, nonatomic) NSView            *backgroundView;

@end
