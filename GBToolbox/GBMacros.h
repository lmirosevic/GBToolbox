//
//  GBMacros.h
//  Remote Mouse
//
//  Created by Luka Mirosevic on 11/09/2012.
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

#ifndef Remote_Mouse_Macros_h
#define Remote_Mouse_Macros_h

//Variadic macros
#define __NARGS(unused, _1, _2, _3, _4, _5, VAL, ...) VAL
#define NARGS(...) __NARGS(unused, ## __VA_ARGS__, 5, 4, 3, 2, 1, 0)

//Logging
#define l(...) NSLog(__VA_ARGS__)

//Localisation
#define _s(string, description) NSLocalizedString(string, description)

//Universal app device detection
typedef enum {
    Phone,
    Pad
} GBDevice;
#define _d ((UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) ? Phone : Pad)

//View controller instantiation
#define __sb(ARGC, ARGS...) sb_ ## ARGC (ARGS)
#define _sb(ARGC, ARGS...) __sb(ARGC, ARGS)
#define sb(...) _sb(NARGS(__VA_ARGS__), __VA_ARGS__)
#define sb_0(...) (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) ? @"StoryboardPhone" :  @"StoryboardPad"
#define sb_1(ARG, ...) (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) ? ARG @"Phone" : ARG @"Pad"

#define vc(storyboardID) [[UIStoryboard storyboardWithName:sb() bundle:nil] instantiateViewControllerWithIdentifier:storyboardID]
#define vcsb(storyboardID, storyboardName) [[UIStoryboard storyboardWithName:sb(storyboardName) bundle:nil] instantiateViewControllerWithIdentifier:storyboardID]

//Object instantiation
#define ai(Class) [[Class alloc] init] //might be easier to just use new instead

//Rotation
typedef enum {
    Portrait,
    Landscape
} GBOrientation;
#define o (UIInterfaceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation]) ? Portrait : Landscape)

//View stuff
//NSString *buttonTitle = NSLocalizedString(@"Done", @"done button title in editor");
//[self.doneButton setTitle:buttonTitle forState:UIControlStateNormal];
//[self.doneButton setBackgroundImage:[[UIImage imageNamed:@"grey-button"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 8, 0, 8)] forState:UIControlStateNormal];
//CGFloat oldRightAnchorX = self.doneButton.frame.origin.x + self.doneButton.frame.size.width;
//CGFloat newWidth = [buttonTitle sizeWithFont:[UIFont fontWithName:@"Helvetica-Bold" size:14]].width + 24;//constant is the padding
//CGFloat newX = oldRightAnchorX - newWidth;
//self.doneButton.frame = CGRectMake(newX, self.doneButton.frame.origin.y, newWidth, self.doneButton.frame.size.height);

//Lazy instantiation
#define _lazy(Class, propertyName, ivar) -(Class *)propertyName {if (!ivar) {ivar = [[Class alloc] init];}return ivar;}
//add an atomic version

//Set
#define _set(...) ([NSSet setWithArray:@[__VA_ARGS__]])

//Resource Bundles
#define _res(bundle, resource) [NSString stringWithFormat:@"%@Resources.bundle/%@", bundle, resource]

//Singleton
#define _singleton(Class, accessor) +(Class *)accessor {static Class *accessor;@synchronized(self) {if (!accessor) {accessor = [[Class alloc] init];}return accessor;}}

//Debugging
#define _b(expression) expression ? @"YES" : @"NO"

//Strings
#define IsEmptyString(string) ((![string isKindOfClass:[NSString class]] || (string == nil) || ([string isEqualToString:@""])) ? YES : NO)
#define IsValidString(string) !IsEmptyString(string)
#define _f(string, ...) ([NSString stringWithFormat:string, __VA_ARGS__])

#endif