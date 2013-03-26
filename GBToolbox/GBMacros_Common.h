//
//  GBMacros.h
//  GBToolbox
//
//  Created by Luka Mirosevic on 11/09/2012.
//  Copyright (c) 2012 Luka Mirosevic. All rights reserved.
//

#ifndef Macros_Common_h
#define Macros_Common_h

#import <objc/runtime.h>

//Variadic macros
#define __NARGS(unused, _1, _2, _3, _4, _5, VAL, ...) VAL
#define NARGS(...) __NARGS(unused, ## __VA_ARGS__, 5, 4, 3, 2, 1, 0)

//Macro indirections
#define STRINGIFY2(string) [NSString stringWithFormat:@"%s", #string]
#define STRINGIFY(string) STRINGIFY2(string)

//Logging
#define l(...) NSLog(__VA_ARGS__)

//Localisation
#define _s(string, description) NSLocalizedString(string, description)

//Lazy instantiation
#define _lazy(Class, propertyName, ivar) -(Class *)propertyName {if (!ivar) {ivar = [[Class alloc] init];}return ivar;}

//Associated objects
static inline int AssociationPolicyFromStorageAndAtomicity(NSString *storage, NSString *atomicity) {
    //_Pragma("clang diagnostic pop")
    if ([atomicity isEqualToString:@"atomic"]) {
        if ([storage isEqualToString:@"assign"]) {
            return OBJC_ASSOCIATION_ASSIGN;
        }
        else if ([storage isEqualToString:@"retain"]) {
            return OBJC_ASSOCIATION_RETAIN;
        }
        else if ([storage isEqualToString:@"copy"]) {
            return OBJC_ASSOCIATION_COPY;
        }
        else {
            NSLog(@"No such storage policy: %@", storage);
            assert(false);
        }
    }
    else if ([atomicity isEqualToString:@"nonatomic"]) {
        if ([storage isEqualToString:@"assign"]) {
            return OBJC_ASSOCIATION_ASSIGN;
        }
        else if ([storage isEqualToString:@"retain"]) {
            return OBJC_ASSOCIATION_RETAIN_NONATOMIC;
        }
        else if ([storage isEqualToString:@"copy"]) {
            return OBJC_ASSOCIATION_COPY_NONATOMIC;
        }
        else {
            NSLog(@"No such storage policy: %@", storage);
            assert(false);
        }
    }
    else {
        NSLog(@"No such atomicity policy: %@", atomicity);
        assert(false);
    }
    
    return 0;
}
#define _associatedObject(storage, atomicity, type, getter, setter) static char gb_##getter##_key; -(void)setter:(type)getter { objc_setAssociatedObject(self, &gb_##getter##_key, getter, AssociationPolicyFromStorageAndAtomicity(STRINGIFY(storage), STRINGIFY(atomicity))); } -(type)getter { return objc_getAssociatedObject(self, &gb_##getter##_key); }


//Set
#define _set(...) ([NSSet setWithArray:@[__VA_ARGS__]])

//Resource Bundles
#define _res(bundle, resource) [NSString stringWithFormat:@"%@Resources.bundle/%@", bundle, resource]

//Singleton
#define _singleton(Class, accessor) +(Class *)accessor {static Class *accessor;@synchronized(self) {if (!accessor) {accessor = [[Class alloc] init];}return accessor;}}

//Debugging
#define _b(expression) expression ? @"YES" : @"NO"
#define _lRect(rect) l(@"Rect: %f %f %f %f", rect.origin.x, rect.origin.y, rect.size.width, rect.size.height);
#define _lPoint(point) l(@"Point: %f %f", point.x, point.y);
#define _lSize(size) l(@"Size: %f %f", size.width, size.height);
#define _lObject(object) l(@"Object: %@", object);
#define _lString(string) l(@"String: %@", string);
#define _lFloating(floating) l(@"Floating: %f", floating);
#define _lIntegral(integral) l(@"Integral: %d", integral);
#define _lBoolean(boolean) l(@"Boolean: %@", _b(boolean));

//Strings
#define IsEmptyString(string) ((![string isKindOfClass:[NSString class]] || (string == nil) || ([string isEqualToString:@""])) ? YES : NO)
#define IsValidString(string) !IsEmptyString(string)
#define _f(string, ...) ([NSString stringWithFormat:string, __VA_ARGS__])

//Code introspection
#define IsClassAvailable(classType) ([NSClassFromString(STRINGIFY(classType)) class] ? YES : NO)

//Info.plist
#define InfoPlist [[NSBundle mainBundle] infoDictionary]

#endif