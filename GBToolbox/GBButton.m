//
//  GBButton.m
//  GBToolbox
//
//  Created by Luka Mirosevic on 28/06/2013.
//  Copyright (c) 2013 Luka Mirosevic. All rights reserved.
//

#import "GBButton.h"

@implementation GBButton

#pragma mark - custom accessors

-(void)setLeftView:(UIView *)leftView {
    if (_leftView != leftView) {
        //remove old one
        [_leftView removeFromSuperview];
        
        //remeber it
        _leftView = leftView;
        
        //show new one
        [self addSubview:leftView];
        
        //configure it
        [self _layoutLeftView];
    }
}

-(void)setLeftViewLeftOffset:(CGFloat)leftViewLeftOffset {
    _leftViewLeftOffset = leftViewLeftOffset;
    
    [self _layoutLeftView];
}

-(void)setLeftViewVerticalOffset:(CGFloat)leftViewVerticalOffset {
    _leftViewVerticalOffset = leftViewVerticalOffset;
    
    [self _layoutLeftView];
}

-(void)setRightView:(UIView *)rightView {
    if (_rightView != rightView) {
        //remove old one
        [_rightView removeFromSuperview];
        
        //remeber it
        _rightView = rightView;
        
        //show new one
        [self addSubview:rightView];
        
        //configure it
        [self _layoutRightView];
    }
}

-(void)setRightViewRightOffset:(CGFloat)rightViewRightOffset {
    _rightViewRightOffset = rightViewRightOffset;
    
    [self _layoutRightView];
}

-(void)setRightViewVerticalOffset:(CGFloat)rightViewVerticalOffset {
    _rightViewVerticalOffset = rightViewVerticalOffset;
    
    [self _layoutRightView];
}

-(void)layoutSubviews {
    [super layoutSubviews];
    
    //make sure my views are on top
    if (self.leftView) [self bringSubviewToFront:self.leftView];
    if (self.rightView) [self bringSubviewToFront:self.rightView];
}

#pragma mark - util

-(void)_layoutLeftView {
    self.leftView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleRightMargin;
    self.leftView.frame = CGRectMake(self.bounds.origin.x + self.leftViewLeftOffset,
                                     self.bounds.origin.y + (self.bounds.size.height - self.leftView.frame.size.height) * 0.5 + self.leftViewVerticalOffset,
                                     self.leftView.frame.size.width,
                                     self.leftView.frame.size.height);
}

-(void)_layoutRightView {
    self.rightView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin;
    self.rightView.frame = CGRectMake(self.bounds.origin.x + self.bounds.size.width - self.rightView.frame.size.width - self.rightViewRightOffset,
                                      self.bounds.origin.y + (self.bounds.size.height - self.rightView.frame.size.height) * 0.5 + self.rightViewVerticalOffset,
                                      self.rightView.frame.size.width,
                                      self.rightView.frame.size.height);
}

@end
