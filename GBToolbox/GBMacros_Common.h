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

//Message forwarding
#define _forwardMessages(target) -(id)forwardingTargetForSelector:(SEL)selector { if ([target respondsToSelector:selector]) return target; return nil; }

//Abstract methods
#define _abstract { @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:_f(@"Abstract method called on %@, override in subclass and don't call super!", NSStringFromClass(self.class)) userInfo:nil]; }

//Associated objects
static inline int AssociationPolicyFromStorageAndAtomicity(NSString *storage, NSString *atomicity) {
    //_Pragma("clang diagnostic pop")
    if ([atomicity isEqualToString:@"atomic"]) {
        if ([storage isEqualToString:@"assign"] || [storage isEqualToString:@"weak"]) {
            return OBJC_ASSOCIATION_ASSIGN;
        }
        else if ([storage isEqualToString:@"retain"] || [storage isEqualToString:@"strong"]) {
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
        if ([storage isEqualToString:@"assign"] || [storage isEqualToString:@"weak"]) {
            return OBJC_ASSOCIATION_ASSIGN;
        }
        else if ([storage isEqualToString:@"retain"] || [storage isEqualToString:@"strong"]) {
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

//Bitmasks
static inline BOOL _bitmask(int var, int comparison) {
    return ((var & comparison) == comparison);
}
#define _attachToBitmask(targetBitmask, whatToAttach, shouldAttach) if (shouldAttach) { targetBitmask |= whatToAttach; }

//Debugging
static inline NSString * _b(BOOL expression) {if (expression) {return @"YES";} else {return @"NO";}}
static inline void _lRect(CGRect rect) {l(@"Rect: %f %f %f %f", rect.origin.x, rect.origin.y, rect.size.width, rect.size.height);}
static inline void _lPoint(CGPoint point) {l(@"Point: %f %f", point.x, point.y);}
static inline void _lSize(CGSize size) {l(@"Size: %f %f", size.width, size.height);}
static inline void _lObject(id object) {l(@"Object: %@", object);}
static inline void _lString(NSString *string) {l(@"String: %@", string);}
static inline void _lFloating(CGFloat floating) {l(@"Floating: %f", floating);}
static inline void _lIntegral(NSInteger integer) {l(@"Integer: %ld", (long)integer);}
static inline void _lBoolean(BOOL boolean) {l(@"Boolean: %@", _b(boolean));}

//Equality checking (where nil == nil evals to YES)
#define IsEqual(a, b) ((a == b) || [a isEqual:b])

//Strings
#define IsValidString(string) (([string isKindOfClass:NSString.class] && ((NSString *)string).length > 0) ? YES : NO)
#define IsEmptyString(string) !IsValidString(string)
#define _f(string, ...) ([NSString stringWithFormat:string, __VA_ARGS__])

//Arrays
#define IsPopulatedArray(array) ([array isKindOfClass:[NSArray class]] && array.count > 0)

//Code introspection
#define IsClassAvailable(classType) ([NSClassFromString(STRINGIFY(classType)) class] ? YES : NO)

//Info.plist
#define InfoPlist [[NSBundle mainBundle] infoDictionary]

//Localization
#define PreferredLanguage [[NSLocale preferredLanguages] objectAtIndex:0]

#endif