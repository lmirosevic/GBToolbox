//
//  CALayer+GBToolbox.m
//  GBToolbox
//
//  Created by Luka Mirosevic on 11/02/2013.
//  Copyright (c) 2013 Luka Mirosevic. All rights reserved.
//

#import "CALayer+GBToolbox.h"

@implementation CALayer (GBToolbox)

-(void)enumerateSublayersWithBlock:(void(^)(CALayer *layer))block {
    //itself
    block(self);

    //then all its subviews
    for (CALayer *sublayer in self.sublayers) {
        [sublayer enumerateSublayersWithBlock:block];
    }
}

@end
