//
//  UIView+GBPopUp.m
//  GBToolbox
//
//  Created by Luka Mirosevic on 08/07/2013.
//  Copyright (c) 2013 Luka Mirosevic. All rights reserved.
//

#import "UIView+GBPopUp.h"

#import "GBMacros_Common.h"
#import "GBMacros_iOS.h"
#import "GBTypes_Common.h"

static CGFloat const kAnimationDuration =                       0.25;

//storage object to help us with memory management and so we don't have too many associative references
@interface GBPopUpStorage : NSObject

@property (assign, nonatomic) BOOL                              isPresentedAsPopUp;
@property (strong, nonatomic) UIView                            *curtainView;
@property (strong, nonatomic) UIView                            *containerView;

@end

@implementation GBPopUpStorage
@end


//the actual class
@interface UIView ()

@property (strong, nonatomic, readonly) GBPopUpStorage          *storage;
@property (assign, nonatomic, readwrite) BOOL                   isPresentedAsPopUp;
@property (strong, nonatomic, readonly) UIView                  *curtainView;
@property (strong, nonatomic, readonly) UIView                  *containerView;

@property (strong, nonatomic) GBPopUpStorage                    *internalStorage;

@end

@implementation UIView (GBPopUp)

_associatedObject(strong, nonatomic, GBPopUpStorage *, internalStorage, setInternalStorage);

#pragma mark - ca

- (GBPopUpStorage *)storage {
    if (!self.internalStorage) {
        self.internalStorage = [GBPopUpStorage new];
    }
    
    return self.internalStorage;
}

- (void)setIsPresentedAsPopUp:(BOOL)isPresentedAsPopUp {
    self.storage.isPresentedAsPopUp = isPresentedAsPopUp;
}

- (BOOL)isPresentedAsPopUp {
    return self.storage.isPresentedAsPopUp;
}

- (void)setPopUpBackgroundColor:(UIColor *)popUpBackgroundColor {
    self.curtainView.backgroundColor = popUpBackgroundColor;
}

- (UIColor *)popUpBackgroundColor {
    return self.curtainView.backgroundColor;
}

- (UIView *)curtainView {
    if (!self.storage.curtainView) {
        self.storage.curtainView = [UIView new];
        self.storage.curtainView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    }
    
    return self.storage.curtainView;
}

- (UIView *)containerView {
    if (!self.storage.containerView) {
        //style self
        self.storage.containerView = [UIView new];
        self.storage.containerView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        self.storage.containerView.backgroundColor = [UIColor clearColor];
        self.storage.containerView.userInteractionEnabled = YES;
        
        //add curtain to container
        self.storage.curtainView.frame = self.storage.containerView.bounds;
        [self.storage.containerView addSubview:self.storage.curtainView];
    }
    
    return self.storage.containerView;
}

#pragma mark - API

- (void)presentAsPopUpOnWindowAnimated:(BOOL)animated {
    [self presentAsPopUpOnWindowAnimated:animated installingAutolayout:nil];
}

- (void)presentAsPopUpOnWindowAnimated:(BOOL)animated installingAutolayout:(GBPopUpAutolayoutInstallationBlock)autolayoutInstallation {
    [self presentAsPopUpOnView:[UIApplication sharedApplication].keyWindow animated:animated installingAutolayout:autolayoutInstallation];
}

- (void)presentAsPopUpOnView:(UIView *)targetView animated:(BOOL)animated {
    [self presentAsPopUpOnView:targetView animated:animated installingAutolayout:nil];
}

- (void)presentAsPopUpOnView:(UIView *)targetView animated:(BOOL)animated installingAutolayout:(GBPopUpAutolayoutInstallationBlock)autolayoutInstallation {
    if (!self.isPresentedAsPopUp) {
        //bail if bad arguments
        if (!targetView) @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"Must provide non nil targetView" userInfo:nil];
        
        //start keyboard listening
        [self _startListeningForKeyboardChanges];
        
        //add the container view
        self.containerView.alpha = 0;
        [targetView addSubview:self.containerView];
        
        //handle container view frame so it covers the target
        [self _handleContainerViewFrame];
        
        //update curtain view frame, so it matches the container
        [self _handleCurtainViewFrame];
        
        //add ourselves
        [self.containerView addSubview:self];
        
        //handle our own frame/autolayout
        [self _handleOwnLayout:autolayoutInstallation];
        
        // perform our animations
        VoidBlock animationsBlock = ^{
            self.containerView.alpha = 1;
        };
        if (animated) {
            [UIView animateWithDuration:kAnimationDuration animations:animationsBlock completion:nil];
        }
        else {
            animationsBlock();
        }
        
        //set this immediately
        self.isPresentedAsPopUp = YES;
    }
}

- (void)dismissPopUpWithAnimation:(GBPopUpAnimation)animationType {
    [self _dismissWithAnimation:animationType animated:YES];
}

- (void)dismissPopUpAnimated:(BOOL)animated {
    [self _dismissWithAnimation:GBPopUpAnimationFadeAway animated:animated];
}

#pragma mark - Animations util

- (void)_dismissWithAnimation:(GBPopUpAnimation)animationType animated:(BOOL)animated {
    if (self.isPresentedAsPopUp) {
        //start keyboard listening
        [self _stopListeningForKeyboardChanges];
        
        VoidBlock actionsBlock;
        
        switch (animationType) {
            case GBPopUpAnimationFlyUp: {
                actionsBlock = ^{
                    self.frame = CGRectMake(self.frame.origin.x,
                                            0 - self.frame.size.height,
                                            self.frame.size.width,
                                            self.frame.size.height);
                    self.containerView.alpha = 0;
                };
            } break;
                
            case GBPopUpAnimationFadeAway: {
                actionsBlock = ^{
                    self.containerView.alpha = 0;
                };
            } break;
        }
        
        
        VoidBlock completionBlock = ^{
            //remove ourselves from the container
            [self removeFromSuperview];
            
            //remove the container view
            [self.containerView removeFromSuperview];
        };
        
        //perform the actual stuff
        if (animated) {
            [UIView animateWithDuration:kAnimationDuration animations:actionsBlock completion:^(BOOL finished) {completionBlock();}];
        }
        else {
            actionsBlock();
            completionBlock();
        }
        
        //no longer presented
        self.isPresentedAsPopUp = NO;
    }
}

#pragma mark - keyboard util

- (void)_startListeningForKeyboardChanges {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_GBPopUp_keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_GBPopUp_keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)_stopListeningForKeyboardChanges {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)_GBPopUp_keyboardWillShow:(NSNotification *)notification {
    NSTimeInterval animationDuration;
    CGRect keyboardFrame;
    
    [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&animationDuration];
    [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] getValue:&keyboardFrame];
    
    CGPoint targetCenter = CGPointMake(self.containerView.center.x,
                                       self.containerView.center.y - (keyboardFrame.size.height * 0.5));
    
    [UIView animateWithDuration:animationDuration delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.center = targetCenter;
    } completion:nil];
}

- (void)_GBPopUp_keyboardWillHide:(NSNotification *)notification {
    NSTimeInterval animationDuration;
    [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&animationDuration];
    
    CGPoint targetCenter = CGPointMake(self.containerView.center.x,
                                       self.containerView.center.y);
    
    [UIView animateWithDuration:animationDuration delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.center = targetCenter;
    } completion:nil];
}

#pragma mark - util

- (void)_handleOwnLayout:(GBPopUpAutolayoutInstallationBlock)autolayoutBlock {
    // autolayout
    if (autolayoutBlock) {
        // enable autolayout
        AutoLayout(self);
        
        // call the block with the parent and ourselves so he can install the constraints
        autolayoutBlock(self.storage.containerView, self);
    }
    // classic frames/bounds
    else {
        //set our positioning mask
        self.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
        
        //just centers ourselves
        self.center = self.storage.containerView.center;
    }
}

- (void)_handleContainerViewFrame {
    self.storage.containerView.frame = self.storage.containerView.superview.bounds;
}

- (void)_handleCurtainViewFrame {
    self.storage.curtainView.frame = self.storage.curtainView.superview.bounds;
}

@end
