//
//  GBMacros_iOS.h
//  GBToolbox
//
//  Created by Luka Mirosevic on 05/02/2013.
//  Copyright (c) 2013 Luka Mirosevic. All rights reserved.
//

#ifndef GBToolbox_GBMacros_iOS_h
#define GBToolbox_GBMacros_iOS_h

#import <UIKit/UIKit.h>

//Universal app device detection
#define _d ((UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) ? Phone : Pad)

//View controller instantiation
#define __sb(ARGC, ARGS...) sb_ ## ARGC (ARGS)
#define _sb(ARGC, ARGS...) __sb(ARGC, ARGS)
#define sb(...) _sb(NARGS(__VA_ARGS__), __VA_ARGS__)
#define sb_0(...) (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) ? @"StoryboardPhone" :  @"StoryboardPad"
#define sb_1(ARG, ...) (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) ? ARG @"Phone" : ARG @"Pad"

#define vc(storyboardID) [[UIStoryboard storyboardWithName:sb() bundle:nil] instantiateViewControllerWithIdentifier:storyboardID]
#define vcsb(storyboardID, storyboardName) [[UIStoryboard storyboardWithName:sb(storyboardName) bundle:nil] instantiateViewControllerWithIdentifier:storyboardID]

//View instantiation and controller hookup
#define vSelfLink(nibName) [[NSBundle.mainBundle loadNibNamed:nibName owner:self options:nil] objectAtIndex:0];
#define v(nibName) [[NSBundle.mainBundle loadNibNamed:nibName owner:nil options:nil]  objectAtIndex:0];

//View loading from nib
#define _loadFromNib(nibName) -(id)awakeAfterUsingCoder:(NSCoder *)aDecoder { \
    BOOL needsLoading = (self.subviews.count == 0); \
    if (needsLoading) { \
        UIView *nibView = [[NSBundle.mainBundle loadNibNamed:nibName owner:nil options:nil]  objectAtIndex:0]; \
        \
        nibView.frame = self.frame; \
        nibView.autoresizingMask = self.autoresizingMask; \
        nibView.alpha = self.alpha; \
        nibView.opaque = self.opaque; \
        nibView.hidden = self.hidden; \
        nibView.backgroundColor = self.backgroundColor; \
        nibView.userInteractionEnabled = self.userInteractionEnabled; \
        nibView.contentMode = self.contentMode; \
        nibView.clearsContextBeforeDrawing = self.clearsContextBeforeDrawing; \
        nibView.clipsToBounds = self.clipsToBounds; \
        nibView.autoresizesSubviews = self.autoresizesSubviews; \
        nibView.multipleTouchEnabled = self.multipleTouchEnabled; \
        nibView.tag = self.tag; \
        \
        return nibView; \
    } \
    \
    return self; \
}

//Rotation
#define o (UIInterfaceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation]) ? Portrait : Landscape)

//Debugging
static inline void _lEdgeInsets(UIEdgeInsets edgeInsets) {l(@"EdgeInsets: %f %f %f %f", edgeInsets.top, edgeInsets.left, edgeInsets.bottom, edgeInsets.right);}

#endif
