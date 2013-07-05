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

-(void)recalculateHeaderHeightAnimated:(BOOL)animated {
    if (animated) [self beginUpdates];
    self.tableHeaderView = self.tableHeaderView;//causes it to refresh the height
    if (animated) [self endUpdates];
}

-(void)updateHeaderHeightTo:(CGFloat)newHeight animated:(BOOL)animated {
    if (animated) {
        [UIView animateWithDuration:0.25 animations:^{
            self.tableHeaderView.frame = CGRectMake(self.tableHeaderView.frame.origin.x,
                                                    self.tableHeaderView.frame.origin.y,
                                                    self.tableHeaderView.frame.size.width,
                                                    newHeight);
            
            self.tableHeaderView = self.tableHeaderView;//causes it to reconsider the height
            
        } completion:nil];
    }
}

@end