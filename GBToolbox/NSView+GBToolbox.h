//
//  NSView+GBToolbox.h
//  GBToolbox
//
//  Created by Luka Mirosevic on 05/02/2013.
//  Copyright (c) 2013 Luka Mirosevic. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NSView (GBToolbox)

//returns the view's frame in global coordinates
@property (assign, nonatomic, readonly) NSRect globalFrame;

//enumarate all subviews depth first
-(void)enumerateSubviewsWithBlock:(void(^)(NSView *view))block;

@end
