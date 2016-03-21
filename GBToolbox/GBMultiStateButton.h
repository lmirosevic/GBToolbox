//
//  GBMultiStateButton.h
//  GBToolbox
//
//  Created by Luka Mirosevic on 20/02/2016.
//  Copyright © 2016 Goonbee e.U. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GBMultiStateButtonState;

@interface GBMultiStateButton : UIControl

@property (strong, nonatomic, readonly) NSArray <GBMultiStateButtonState *>     *states;
@property (strong, nonatomic) GBMultiStateButtonState                           *activeState;
@property (strong, nonatomic) id                                                activeStateIdentifier;
@property (assign, nonatomic) BOOL                                              adjustsImageWhenHighlighted;

- (instancetype)initWithStates:(NSArray<GBMultiStateButtonState *> *)states;

@end

@interface GBMultiStateButtonState : NSObject

@property (strong, nonatomic) id                                                stateIdentifier;
@property (strong, nonatomic) UIImage                                           *image;
@property (strong, nonatomic) UIImage                                           *backgroundImage;
@property (strong, nonatomic) UIImage                                           *imageWhenHighlighted;
@property (strong, nonatomic) UIImage                                           *backgroundImageWhenHighlighted;
@property (assign, nonatomic, getter=isUserSelectable) BOOL                     userSelectable;

+ (instancetype)stateWithIdentifier:(id)identifier image:(UIImage *)image;
+ (instancetype)stateWithIdentifier:(id)identifier image:(UIImage *)image backgroundImage:(UIImage *)backgroundImage;
+ (instancetype)stateWithIdentifier:(id)identifier image:(UIImage *)image backgroundImage:(UIImage *)backgroundImage imageWhenHighlighted:(UIImage *)imageWhenHighlighted backgroundImageWhenHighlighted:(UIImage *)backgroundImageWhenHighlighted;
+ (instancetype)stateWithIdentifier:(id)identifier image:(UIImage *)image backgroundImage:(UIImage *)backgroundImage imageWhenHighlighted:(UIImage *)imageWhenHighlighted backgroundImageWhenHighlighted:(UIImage *)backgroundImageWhenHighlighted userSelectable:(BOOL)userSelectable;

@end
