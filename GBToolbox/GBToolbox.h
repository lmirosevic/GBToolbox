//
//  GBToolbox.h
//  GBToolbox
//
//  Created by Luka Mirosevic on 28/09/2012.
//  Copyright (c) 2012 Luka Mirosevic. All rights reserved.
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


/* Common imports */

#import "GBTypes_Common.h"

#import "GBConstants_Common.h"

#import "GBMacros_Common.h"
#import "GBUtility_Common.h"

#import "GBFastArray.h"
#import "GBMessageInterceptor.h"
#import "GBCompletable.h"
#import "GBCache.h"
#import "GBEnumWrapper.h"
#import "GBAddress.h"
#import "GBRemoteDebugMessages.h"

#import "NSObject+GBToolbox.h"
#import "NSTimer+GBToolbox.h"
#import "NSData+GBToolbox.h"
#import "NSString+GBToolbox.h"
#import "CALayer+GBToolbox.h"
#import "NSArray+GBToolbox.h"
#import "NSMutableArray+GBToolbox.h"
#import "NSDictionary+GBToolbox.h"
#import "NSMutableDictionary+GBToolbox.h"
#import "NSMutableURLRequest+GBToolbox.h"
#import "NSDate+GBToolbox.h"
#import "NSInvocation+GBToolbox.h"
#import "NSMapTable+GBToolbox.h"

#import "GBFrameChangedProtocol.h"


/* iOS imports */

#if TARGET_OS_IPHONE

#import "GBTypes_iOS.h"

#import "GBMacros_iOS.h"
#import "GBUtility_iOS.h"

#import "GBCustomNavigationBar.h"
#import "GBTextField.h"
#import "GBTextView.h"
#import "GBButton.h"
#import "GBToggleControl.h"
#import "GBToggleControlRadioGroupManager.h"
#import "GBAlertBadgeView.h"
#import "GBRoundBadgeView.h"
#import "GBColoredBarView.h"
#import "GBTextBox.h"
#import "GBTestView.h"
#import "GBTableViewController.h"
#import "GBGradientView.h"

#import "UITableView+GBToolbox.h"
#import "UIViewController+GBToolbox.h"
#import "UIView+GBToolbox.h"
#import "UIImage+GBToolbox.h"
#import "UIScrollView+GBToolbox.h"
#import "UIImageView+GBToolbox.h"
#import "MKMapView+GBToolbox.h"
#import "UIColor+GBToolbox.h"

#import "UITableViewCell+AdditionalViews.h"
#import "UIView+GBPopUp.h"

#endif


/* OS X imports */

#if !TARGET_OS_IPHONE

#import "GBTypes_OSX.h"

#import "GBMacros_OSX.h"
#import "GBUtility_OSX.h"

#import "GBResizableImageView.h"
#import "GBRadialGradientView.h"
#import "GBCustomViewButtonCell.h"
#import "GBCustomImageButtonCell.h"
#import "GBGlowingImageButtonCell.h"
#import "GBSolidColorView.h"

#import "NSImage+GBToolbox.h"
#import "NSView+GBToolbox.h"

#endif


/* Notes */


//distill the press and hold guy from GBPingInitiatorViewController, look at the following methods:
//
//-(void)touchUp:(id)sender tapHandler:(void(^)(void))tapHandler;
//-(void)touchDown:(id)sender pressAndHoldHandler:(void(^)(void))pressAndHoldHandler;