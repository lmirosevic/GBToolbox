//
//  GBUtility_iOS.m
//  GBToolbox
//
//  Created by Luka Mirosevic on 05/02/2013.
//  Copyright (c) 2013 Luka Mirosevic. All rights reserved.
//

#import "GBUtility_iOS.h"

#import "GBMacros_Common.h"

#import <Twitter/Twitter.h>
#import <Social/Social.h>
#import <AudioToolbox/AudioToolbox.h>

@implementation GBToolbox (iOS)

#pragma mark - UIView

NSUInteger tagFromUIViewSubclass(id sender) {
    if ([sender isKindOfClass:[UIView class]]) {
        return ((UIView *)sender).tag;
    }
    else return 0;
}

#pragma mark - View Hierarchy

UIViewController * TopmostViewController() {
    return TopmostViewControllerWithRootViewController([UIApplication sharedApplication].keyWindow.rootViewController);
}

UIViewController * TopmostViewControllerWithRootViewController(UIViewController *rootViewController) {
    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabBarController = (UITabBarController *)rootViewController;
        return TopmostViewControllerWithRootViewController(tabBarController.selectedViewController);
    }
    else if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navigationController = (UINavigationController *)rootViewController;
        return TopmostViewControllerWithRootViewController(navigationController.visibleViewController);
    }
    else if (rootViewController.presentedViewController) {
        UIViewController *presentedViewController = rootViewController.presentedViewController;
        return TopmostViewControllerWithRootViewController(presentedViewController);
    }
    else {
        return rootViewController;
    }
}

#pragma mark - Screen Locking

+(BOOL)isAutoScreenLockingEnabled {
	UIApplication *me = [UIApplication sharedApplication];
	return me.idleTimerDisabled;
}

+(void)enableAutoScreenLocking:(BOOL)enable {
	UIApplication *me = [UIApplication sharedApplication];
	me.idleTimerDisabled = !enable;
}

#pragma mark - App Store redirect

void RedirectToAppStore(NSString *appID) {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/id%@?mt=8", appID]]];
}

#pragma mark - Images

UIImage * ImageResizableWithCapInsets(NSString *name, CGFloat topCap, CGFloat leftCap, CGFloat bottomCap, CGFloat rightCap) {
    return [[UIImage imageNamed:name] resizableImageWithCapInsets:UIEdgeInsetsMake(topCap, leftCap, bottomCap, rightCap)];
}

#pragma mark - Clipping

CAShapeLayer * RoundClippingMaskInRectWithMargin(CGRect rect, UIEdgeInsets margin) {
    UIBezierPath *bezierPath = RoundBezierPathForRectWithMargin(rect, margin);
    
    CAShapeLayer *shapeMask = [CAShapeLayer new];
    shapeMask.frame = rect;
    shapeMask.path = bezierPath.CGPath;
    
    return shapeMask;
}

UIBezierPath * RoundBezierPathForRectWithMargin(CGRect rect, UIEdgeInsets margin) {
    return [UIBezierPath bezierPathWithOvalInRect:CGRectMake(rect.origin.x + margin.left,
                                                             rect.origin.y + margin.top,
                                                             rect.size.width - (margin.left + margin.right),
                                                             rect.size.height - (margin.top + margin.bottom))];
}

#pragma mark - Push Notifications

BOOL IsPushDisabled() {
    return [[UIApplication sharedApplication] enabledRemoteNotificationTypes] == UIRemoteNotificationTypeNone;
}

#pragma mark - UITableView

BOOL IsCellAtIndexPathFullyVisible(NSIndexPath *indexPath, UITableView *tableView) {
    CGRect cellRect = [tableView rectForRowAtIndexPath:indexPath];
    cellRect = [tableView convertRect:cellRect toView:tableView.superview];
    return CGRectContainsRect(tableView.frame, cellRect);
}

#pragma mark - Keyboard hiding

void DismissKeyboard() {
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
}

#pragma mark - Twitter

BOOL IsTwitterAccountAvailable() {
#if TARGET_IPHONE_SIMULATOR
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    //Suppressing deprecation warning as this is only used for the Simulator, and only so to work around a Simulator bug
    return [TWTweetComposeViewController canSendTweet];
#pragma clang diagnostic pop
#else
    if (IsClassAvailable(SLComposeViewController)) {
        return [SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter];
    }
    else {
        return [TWTweetComposeViewController canSendTweet];
    }
#endif
}

#pragma mark - Localisation

NSString * UIKitLocalizedString(NSString *string) {
	NSBundle *UIKitBundle = [NSBundle bundleForClass:[UIApplication class]];
    NSString *localizedString = [UIKitBundle localizedStringForKey:string value:string table:nil];
    
    return localizedString ?: string;
}

#pragma mark - Vibration

void VibrateDevice() {
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}

#pragma mark - Colors

//Returns a random color with a bias towards the more saturated and brighter colors
UIColor *RandomColor() {
    CGFloat hue = Random();
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}

@end