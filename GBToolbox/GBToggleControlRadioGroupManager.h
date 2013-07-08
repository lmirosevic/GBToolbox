//
//  GBToggleControlRadioGroupManager.h
//  GBToolbox
//
//  Created by Luka Mirosevic on 08/07/2013.
//  Copyright (c) 2013 Luka Mirosevic. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GBToggleControl;

@protocol GBToggleControlRadioGroupManagerDelegate;

@interface GBToggleControlRadioGroupManager : NSObject

@property (weak, nonatomic) id<GBToggleControlRadioGroupManagerDelegate>        delegate;

@property (strong, nonatomic) NSArray                                           *toggleControls;

@property (assign, nonatomic) NSInteger                                         selectedControlIndex;
@property (strong, nonatomic) GBToggleControl                                   *selectedControl;

-(void)deselectAllControls;

@end

@protocol GBToggleControlRadioGroupManagerDelegate <NSObject>
@optional

-(void)toggleControlRadioGroupManager:(GBToggleControlRadioGroupManager *)toggleControlRadioGroupManager didSelectToggleControl:(GBToggleControl *)toggleControl withIndex:(NSInteger)index;

-(void)toggleControlRadioGroupManagerDidResetSelection:(GBToggleControlRadioGroupManager *)toggleControlRadioGroupManager;

@end