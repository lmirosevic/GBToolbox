//
//  GBMacros_OSX.h
//  GBToolbox
//
//  Created by Luka Mirosevic on 05/02/2013.
//  Copyright (c) 2013 Luka Mirosevic. All rights reserved.
//

#ifndef GBToolbox_GBMacros_OSX_h
#define GBToolbox_GBMacros_OSX_h

//View controller instantiation
static inline id InstantiateViewControllerWithXib(NSString *xibName) {
    NSString *className = [xibName stringByAppendingString:@"ViewController"];
    return [[NSClassFromString(className) alloc] initWithNibName:className bundle:nil];
}
#define vc(xibName) InstantiateViewControllerWithXib(xibName)

#endif
