//
//  NSString+GBToolbox.m
//  GBToolbox
//
//  Created by Luka Mirosevic on 05/02/2013.
//  Copyright (c) 2013 Luka Mirosevic. All rights reserved.
//

#import "NSString+GBToolbox.h"

#import <CommonCrypto/CommonDigest.h>

@implementation NSString (GBToolbox)

//check if string is an integer
-(BOOL)isInteger {
    NSCharacterSet *alphaNums = [NSCharacterSet decimalDigitCharacterSet];
    NSCharacterSet *stringSet = [NSCharacterSet characterSetWithCharactersInString:self];
    
    return [alphaNums isSupersetOfSet:stringSet];
}

//check if it contains a substring
-(BOOL)containsSubstring:(NSString *)substring {
    return [self containsSubstring:substring caseSensitive:YES];
}

-(BOOL)containsSubstring:(NSString *)substring caseSensitive:(BOOL)isCaseSensitive {
    return [self rangeOfString:substring options:(isCaseSensitive ? 0 : NSCaseInsensitiveSearch)].location != NSNotFound;
}

//returns yes if the receiver equals any of the strings in the strings array
-(BOOL)isEqualToOneOf:(NSArray *)strings {
    for (NSString *string in strings) {
        if ([string isKindOfClass:NSString.class]) {
            if ([self isEqualToString:string]) {
                return YES;
            }
        }
        else {
            break;
        }
    }
    
    //if we got here we failed
    return NO;
}

//best attempt to get int out of string
-(int)attemptConversionToInt {
    NSString *numberString;
    
    NSScanner *scanner = [NSScanner scannerWithString:self];
    NSCharacterSet *numbers = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    
    // Throw away characters before the first number.
    [scanner scanUpToCharactersFromSet:numbers intoString:NULL];
    
    // Collect numbers.
    [scanner scanCharactersFromSet:numbers intoString:&numberString];
    
    // Result.
    return [numberString intValue];
}

//10.7 only
//could rewrite this to simply scan for the . from the back and trim all of that off
-(NSString *)stringByDeletingDNSSuffix {
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"^(([0-9a-zA-Z]+[0-9a-zA-Z-]*[0-9a-zA-Z]+|[0-9a-zA-Z]+)[.][a-zA-Z]+)$" options:NSRegularExpressionCaseInsensitive error:NULL];
    NSRange rangeOfFirstMatch = [regex rangeOfFirstMatchInString:self options:0 range:NSMakeRange(0, [self length])];
    if (!NSEqualRanges(rangeOfFirstMatch, NSMakeRange(NSNotFound, 0))) {
        NSRange dotRange = [self rangeOfString:@"."];
        return [self substringToIndex:dotRange.location];
    }
    else {
        return self;
    }
}

//checks to see if a string is an IP. requires 10.7+
-(BOOL)isIp {
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"^(([1-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])[.]([0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])[.]([0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])[.]([1-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5]))$" options:0 error:NULL];
    NSRange rangeOfFirstMatch = [regex rangeOfFirstMatchInString:self options:0 range:NSMakeRange(0, [self length])];
    if (!NSEqualRanges(rangeOfFirstMatch, NSMakeRange(NSNotFound, 0))) {
        return YES;
    }
    else {
        return NO;
    }
}

//Trims leading and trailing whitespace
-(NSString *)stringByTrimmingLeadingAndTrailingWhitespace {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

//Hashes, original under Public Domain: https://github.com/hypercrypt/NSString-Hashes
static inline NSString *NSStringCCHashFunction(unsigned char *(function)(const void *data, CC_LONG len, unsigned char *md), CC_LONG digestLength, NSString *string) {
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    uint8_t digest[digestLength];
    
    function(data.bytes, (CC_LONG)data.length, digest);
    
    NSMutableString *output = [NSMutableString stringWithCapacity:digestLength * 2];
    
    for (int i = 0; i < digestLength; i++) {
        [output appendFormat:@"%02x", digest[i]];
    }
    
    return output;
}

- (NSString *)md5 {
    return NSStringCCHashFunction(CC_MD5, CC_MD5_DIGEST_LENGTH, self);
}

- (NSString *)sha1 {
    return NSStringCCHashFunction(CC_SHA1, CC_SHA1_DIGEST_LENGTH, self);
}

- (NSString *)sha224 {
    return NSStringCCHashFunction(CC_SHA224, CC_SHA224_DIGEST_LENGTH, self);
}

- (NSString *)sha256 {
    return NSStringCCHashFunction(CC_SHA256, CC_SHA256_DIGEST_LENGTH, self);
}

- (NSString *)sha384 {
    return NSStringCCHashFunction(CC_SHA384, CC_SHA384_DIGEST_LENGTH, self);
}
- (NSString *)sha512 {
    return NSStringCCHashFunction(CC_SHA512, CC_SHA512_DIGEST_LENGTH, self);
}

@end
