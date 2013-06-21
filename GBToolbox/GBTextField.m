//
//  GBTextField.m
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

#import "GBTextField.h"

#import "GBMessageInterceptor.h"

@interface GBTextField () <UITextFieldDelegate> {
    GBMessageInterceptor    *_delegateInterceptor;
}

@end

@implementation GBTextField

-(void)_initRoutine {
    _delegateInterceptor = [GBMessageInterceptor new];
    _delegateInterceptor.middleMan = self;
    super.delegate = (id)_delegateInterceptor;
}

-(id)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self _initRoutine];
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self _initRoutine];
    }
    return self;
}

#pragma mark - padding

- (CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectMake(bounds.origin.x + self.padding.left,
                      bounds.origin.y + self.padding.top,
                      bounds.size.width - (self.padding.right + self.padding.left),
                      bounds.size.height - (self.padding.bottom + self.padding.top));
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    return [self textRectForBounds:bounds];
}

#pragma mark - util

-(BOOL)isDirty {
    if (self.text && self.text.length > 0) {
        return YES;
    }
    else {
        return NO;
    }
}

#pragma mark - delegate overrides

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    //return
    if ([string isEqualToString:@"\n"]) {
        if ([[self delegate] respondsToSelector:@selector(specialKeyPressed:)]) {
            [[self delegate] specialKeyPressed:GBSpecialKeyReturn];
        }
    }
    //normal letter
    else if (string.length > 0) {
        if ([[self delegate] respondsToSelector:@selector(keyPressed:)]) {
            [[self delegate] keyPressed:string];
        }
    }
    //backspace
    else if (string.length == 0 && range.length == 1) {
        if ([[self delegate] respondsToSelector:@selector(specialKeyPressed:)]) {
            [[self delegate] specialKeyPressed:GBSpecialKeyBackspace];
        }
    }
    
    //forward original call
    if ([[self delegate] respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString::)]) {
        return [[self delegate] textField:textField shouldChangeCharactersInRange:range replacementString:string];
    }
    else {
        return YES;//foo find out what the default is
    }
}

#pragma mark - delegate hijacking
//these 2 hijack the original delegate, but that's ok because we forward all the original messages

-(void)setDelegate:(id<GBTextFieldDelegate>)delegate {
    [super setDelegate:nil];
    _delegateInterceptor.receiver = delegate;
    super.delegate = (id)_delegateInterceptor;
}

-(id<GBTextFieldDelegate>)delegate {
    return (id)[super delegate];
//    return _delegateInterceptor.receiver;
}

@end
