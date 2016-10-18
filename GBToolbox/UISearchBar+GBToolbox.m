//
//  UISearchBar+GBToolbox.m
//  Pods
//
//  Created by Luka Mirosevic on 18/10/2016.
//
//

#import "UISearchBar+GBToolbox.h"

@implementation UISearchBar (GBToolbox)

- (nullable UITextField *)searchTextField {
    return (UITextField *)[self valueForKey:@"searchField"];
}

@end
