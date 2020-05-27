//
//  UISearchBar+GBToolbox.m
//  Pods
//
//  Created by Luka Mirosevic on 18/10/2016.
//
//

#import "UISearchBar+GBToolbox.h"

@implementation UISearchBar (GBToolbox)

- (nullable UITextField *)textField {
    if (@available(iOS 13, *)) {
        return [self searchTextField];
    } else {
        return (UITextField *)[self valueForKey:@"searchField"];
    }
}

@end
