//
//  GBTextField.h
//  Business cards
//
//  Created by Luka Mirosevic on 28/09/2012.
//  Copyright (c) 2012 Luka Mirosevic.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.

#import <UIKit/UIKit.h>

#import "GBTypes_Common.h"

@protocol GBTextFieldDelegate;

@interface GBTextField : UITextField

@property (assign, nonatomic) UIEdgeInsets              padding;
@property (assign, nonatomic, readonly) BOOL            isDirty;
@property (assign, nonatomic) CGFloat                   leftViewLeftOffset;
@property (assign, nonatomic) CGFloat                   rightViewRightOffset;
@property (assign, nonatomic) CGRect                    leftViewFrame;
@property (assign, nonatomic) CGRect                    rightViewFrame;

@property (assign, nonatomic) BOOL                      invalidatesIntrinsicContentSizeDuringEditing;// default: YES

//This is an augmented protocol. Adds 2 new methods, see below.
-(id<GBTextFieldDelegate>)delegate;
-(void)setDelegate:(id<GBTextFieldDelegate>)delegate;

@end

@protocol GBTextFieldDelegate <UITextFieldDelegate>
@optional

-(void)textField:(GBTextField *)textField keyPressed:(NSString *)string;
-(void)textField:(GBTextField *)textField specialKeyPressed:(GBSpecialKey)specialKey;

@end
