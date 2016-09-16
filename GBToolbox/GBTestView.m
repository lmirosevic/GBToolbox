//
//  GBTestView.m
//  GBToolbox
//
//  Created by Luka Mirosevic on 12/07/2013.
//  Copyright (c) 2013 Luka Mirosevic. All rights reserved.
//

#import "GBTestView.h"

#import "GBToolbox.h"

@implementation GBTestView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)setFrame:(CGRect)frame {
//    _lRect(frame);
    [super setFrame:frame];
}

- (void)dealloc {
    NSLog(@"deallocating GBTestView instance %@", self);
}

@end
