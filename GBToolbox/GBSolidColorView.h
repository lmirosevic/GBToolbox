//
//  GBSolidColorView.h
//  GBToolbox
//
//  Created by Luka Mirosevic on 13/02/2013.
//  Copyright (c) 2013 Luka Mirosevic. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface GBSolidColorView : NSView

@property (strong, nonatomic) NSColor   *color;

-(id)initWithColor:(NSColor *)color;

@end
