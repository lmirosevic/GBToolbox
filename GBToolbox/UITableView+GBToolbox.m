//
//  UITableView+GBToolbox.m
//  GBToolbox
//
//  Created by Luka Mirosevic on 05/02/2013.
//  Copyright (c) 2013 Luka Mirosevic. All rights reserved.
//

#import "UITableView+GBToolbox.h"

@implementation UITableView (GBToolbox)

-(BOOL)isScrolledToBottomWithTolerance:(CGFloat)tolerance {
    if (self.contentSize.height - self.bounds.size.height - self.contentOffset.y <= tolerance) {
        return YES;
    }
    else {
        return NO;
    }
}

-(BOOL)isScrolledToBottom {
    return [self isScrolledToBottomWithTolerance:0];
}

@end