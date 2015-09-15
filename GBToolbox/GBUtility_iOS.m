//
//  GBUtility_iOS.m
//  GBToolbox
//
//  Created by Luka Mirosevic on 05/02/2013.
//  Copyright (c) 2013 Luka Mirosevic. All rights reserved.
//

#import "GBUtility_iOS.h"

#import "GBMacros_Common.h"
#import "NSObject+GBToolbox.h"
#import "NSArray+GBToolbox.h"
#import "NSString+GBToolbox.h"

#import "GBAddress.h"

#import <Twitter/Twitter.h>
#import <Social/Social.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AddressBook/AddressBook.h>
#import <MapKit/MapKit.h>

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

UIImage * Image(NSString *name) {
    return [UIImage imageNamed:name];
}

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
    //iOS 8+
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(isRegisteredForRemoteNotifications)]) {
        return [[UIApplication sharedApplication] isRegisteredForRemoteNotifications];
    }
    //iOS 7 and below
    else {
        return [[UIApplication sharedApplication] enabledRemoteNotificationTypes] == UIRemoteNotificationTypeNone;
    }
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

#pragma mark - Auto Layout

void AutoLayoutDebugOn(BOOL crashOnTrigger) {
    UIWindow *keyWindow = [UIWindow performSelector:@selector(keyWindow)];
    if (keyWindow.hasAmbiguousLayout) {
        // we're calling a private method here so we need to do some trickery to avoid a compiler warning
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        NSLog(@"%@", [keyWindow performSelector:NSSelectorFromString(@"_autolayoutTrace")]);
#pragma clang diagnostic pop
        
        if (crashOnTrigger) {
            NSCAssert(false, @"Checking Autolayout... AMBIGUOUS!!!");
        }
        else {
            NSLog(@"Checking Autolayout... AMBIGUOUS!!!");
        }
    }
    else {
        NSLog(@"Checking Autolayout... OK");
    }
}

NSString *AutoLayoutViewPointer(NSObject *object) {
    return [NSString stringWithFormat:@"_%@", object.pointerAddress];
}

NSDictionary *AutoLayoutPointerViewsDictionaryForViews(NSArray *views) {
    return [NSDictionary dictionaryWithObjects:views forKeys:[views map:^id(id object) {
        // ...We need a unique string that points to the selected object. Sounds a bit like a pointer, so... why don't we use a pointer, just stringified, courtesy of a little utility  function.
        return AutoLayoutViewPointer(object);
    }]];
}

#pragma mark - Geocoding

void ReverseGeocodeLocation(CLLocation *location, void(^block)(GBAddress *address)) {
    CLGeocoder *geocoder = [CLGeocoder new];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        GBAddress *address;
        
        if (placemarks && placemarks.count > 0) {
            CLPlacemark *placemark = [placemarks firstObject];
            NSDictionary *addressDictionary = placemark.addressDictionary;
            
            address = [GBAddress new];
            address.street = addressDictionary[(NSString *)kABPersonAddressStreetKey];
            address.city = addressDictionary[(NSString *)kABPersonAddressCityKey];
            address.zip = addressDictionary[(NSString *)kABPersonAddressZIPKey];
            address.country = addressDictionary[(NSString *)kABPersonAddressCountryKey];
            address.countryCode = addressDictionary[(NSString *)kABPersonAddressCountryCodeKey];
            address.state = addressDictionary[(NSString *)kABPersonAddressStateKey];
        }
        
        if (block) block(address);
    }];
}

#pragma mark - UIViewController containment

void AddChildViewController(UIViewController *hostViewController, UIViewController *childViewController) {
    AddChildViewControllerToView(hostViewController, hostViewController.view, childViewController);
}

void AddChildViewControllerToView(UIViewController *hostViewController, UIView *hostView, UIViewController *childViewController) {
    [hostViewController addChildViewController:childViewController];
    [hostView addSubview:childViewController.view];
    [childViewController didMoveToParentViewController:hostViewController];
}

void RemoveChildViewController(UIViewController *childViewController) {
    [childViewController willMoveToParentViewController:nil];
    [childViewController.view removeFromSuperview];
    [childViewController removeFromParentViewController];
}

#pragma mark - Actions

void OpenLinkInSafari(NSString *link) {
    NSString *urlString = link;

    // add protocol if it's not there yet
    if (![urlString containsSubstring:@"://"]) {
        urlString = [NSString stringWithFormat:@"http://%@", urlString];
    }

    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
}

void OpenMap(CLLocation *location, NSString *name) {
    MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:location.coordinate addressDictionary:nil];
    MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:placemark];
    if (name) mapItem.name = name;
    
    [mapItem openInMapsWithLaunchOptions:nil];
}

static void _performPhoneNumberActionWithNumber(NSString *number, NSString *prefix) {
    NSCharacterSet *characterSet = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789+"] invertedSet];
    NSString *processedNumber = [[number componentsSeparatedByCharactersInSet:characterSet] componentsJoinedByString:@""];
    NSString *urlString = [NSString stringWithFormat:@"%@://%@", prefix, processedNumber];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
}

void CallPhone(NSString *number) {
    _performPhoneNumberActionWithNumber(number, @"tel");
}

void SendSMS(NSString *number) {
    _performPhoneNumberActionWithNumber(number, @"sms");
}

#pragma mark - Fonts

void ListAvailableFonts() {
    for (NSString *fontFamily in [UIFont familyNames]) {
        NSLog(@"%@: %@", fontFamily, [UIFont fontNamesForFamilyName:fontFamily]);
    }
}

#pragma mark - Disk utils

NSString * DocumentsDirectoryPath() {
#if TARGET_OS_IPHONE
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
#else
    NSString *documentsDirectory = [[NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:[[NSBundle mainBundle] infoDictionary][@"CFBundleIdentifier"]];
#endif
    
    return documentsDirectory;
}

NSURL * DocumentsDirectoryURL() {
    return [NSURL fileURLWithPath:DocumentsDirectoryPath()];
}

#pragma mark - Cookies

void ClearCookies() {
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (NSHTTPCookie *cookie in [storage cookies]) {
        [storage deleteCookie:cookie];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
