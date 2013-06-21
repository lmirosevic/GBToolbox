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

@implementation GBTextField

@synthesize paddingTop, paddingRight, paddingBottom, paddingLeft;

- (CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectMake(bounds.origin.x + paddingLeft, bounds.origin.y + paddingTop, bounds.size.width - paddingRight - paddingLeft, bounds.size.height - paddingBottom - paddingTop);
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    return [self textRectForBounds:bounds];
}

@end
