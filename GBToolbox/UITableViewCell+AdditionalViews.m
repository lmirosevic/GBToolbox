//
//  UITableViewCell+AdditionalViews.m
//  Russia
//
//  Created by Luka Mirosevic on 27/06/2013.
//  Copyright (c) 2013 Goonbee. All rights reserved.
//

#import "UITableViewCell+AdditionalViews.h"

#import "GBMacros_Common.h"

@interface UITableViewCell ()

@property (strong, nonatomic) UIView            *internalLeftView;
@property (assign, nonatomic) NSValue           *internalLeftViewFrame;
@property (strong, nonatomic) UIView            *internalRightView;
@property (assign, nonatomic) NSValue           *internalRightViewFrame;

@end

@implementation UITableViewCell (AdditionalViews)

#pragma mark - mem

_associatedObject(strong, nonatomic, UIView *, internalLeftView, setInternalLeftView)
_associatedObject(strong, nonatomic, NSValue *, internalLeftViewFrame, setInternalLeftViewFrame)

_associatedObject(strong, nonatomic, UIView *, internalRightView, setInternalRightView)
_associatedObject(strong, nonatomic, NSValue *, internalRightViewFrame, setInternalRightViewFrame)

#pragma mark - custom accessors

-(void)setLeftView:(UIView *)leftView {
    if (self.internalLeftView != leftView) {
        //remove old one
        [self.internalLeftView removeFromSuperview];
    
        //remeber it
        self.internalLeftView = leftView;
        
        //show new one
        [self.contentView addSubview:leftView];
        
        //configure it
        [self _layoutLeftView];
    }
}

-(UIView *)leftView {
    return self.internalLeftView;
}

-(void)setLeftViewFrame:(CGRect)leftViewFrame {
    self.internalLeftViewFrame = [NSValue valueWithCGRect:leftViewFrame];
    
    [self _layoutLeftView];
}

-(CGRect)leftViewFrame {
    return [self.internalLeftViewFrame CGRectValue];
}

-(void)setRightView:(UIView *)rightView {
    if (self.internalRightView != rightView) {
        //remove old one
        [self.internalRightView removeFromSuperview];
        
        //remeber it
        self.internalRightView = rightView;
        
        //show new one
        [self.contentView addSubview:rightView];
        
        //configure it
        [self _layoutRightView];
    }
}

-(UIView *)rightView {
    return self.internalRightView;
}

-(void)setRightViewFrame:(CGRect)rightViewFrame {
    self.internalRightViewFrame = [NSValue valueWithCGRect:rightViewFrame];
    
    [self _layoutRightView];
}

-(CGRect)rightViewFrame {
    return [self.internalRightViewFrame CGRectValue];
}

#pragma mark - util

-(void)_layoutLeftView {
    self.internalLeftView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleRightMargin;
    self.internalLeftView.frame = self.leftViewFrame;
}

-(void)_layoutRightView {
    self.internalRightView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin;
    self.internalRightView.frame = self.rightViewFrame;
}

@end
