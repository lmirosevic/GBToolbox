//
//  GBUtility_iOS.m
//  GBToolbox
//
//  Created by Luka Mirosevic on 05/02/2013.
//  Copyright (c) 2013 Luka Mirosevic. All rights reserved.
//

#import "GBUtility_iOS.h"

@implementation GBToolbox (iOS)

#pragma mark - UIView

NSUInteger tagFromUIViewSubclass(id sender) {
    if ([sender isKindOfClass:[UIView class]]) {
        return ((UIView *)sender).tag;
    }
    else return 0;
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

@end