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

- (BOOL)isInteger {
    NSCharacterSet *alphaNums = [NSCharacterSet decimalDigitCharacterSet];
    NSCharacterSet *stringSet = [NSCharacterSet characterSetWithCharactersInString:self];
    
    return [alphaNums isSupersetOfSet:stringSet];
}

- (BOOL)containsSubstring:(nullable NSString *)substring {
    return [self containsSubstring:substring caseSensitive:YES];
}

- (BOOL)containsSubstring:(nullable NSString *)substring caseSensitive:(BOOL)isCaseSensitive {
    if (substring ) {
        return [self rangeOfString:substring options:(isCaseSensitive ? 0 : NSCaseInsensitiveSearch)].location != NSNotFound;
    } else {
        return NO;
    }
}

- (BOOL)isEqualToOneOf:(nonnull NSArray<NSString *> *)strings {
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

- (int)attemptConversionToInt {
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

- (float)attemptConversionToFloat {
    return [self attemptConversionToDouble];
}

- (double)attemptConversionToDouble {
    NSString *decimalSeparator = [NSNumberFormatter new].decimalSeparator;
    NSCharacterSet *allowedCharacterSet = [NSCharacterSet characterSetWithCharactersInString:[@"0123456789" stringByAppendingString:decimalSeparator]];
    
    NSString *cleanedPriceString = [self stringByRemovingCharactersNotInSet:allowedCharacterSet];
    CGFloat rawAmount = [cleanedPriceString doubleValue];
    
    return rawAmount;
}

- (nonnull NSString *)stringByDeletingDNSSuffix {
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

- (BOOL)isIP {
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"^(([1-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])[.]([0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])[.]([0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])[.]([1-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5]))$" options:0 error:NULL];
    NSRange rangeOfFirstMatch = [regex rangeOfFirstMatchInString:self options:0 range:NSMakeRange(0, [self length])];
    if (!NSEqualRanges(rangeOfFirstMatch, NSMakeRange(NSNotFound, 0))) {
        return YES;
    }
    else {
        return NO;
    }
}

- (nonnull NSString *)stringByTrimmingLeadingAndTrailingWhitespace {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (nonnull NSString *)stringByCleaningWhitespace {
    NSString *unNewlined = [self stringByReplacingOccurrencesOfString:@"\n" withString:@"" options:0 range:NSMakeRange(0, self.length)];
    NSString *squashed = [unNewlined stringByReplacingOccurrencesOfString:@"[ ]+" withString:@" " options:NSRegularExpressionSearch range:NSMakeRange(0, unNewlined.length)];
    NSString *final = [squashed stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    return final;
}

- (nonnull NSString *)stringByRemovingCharactersInSet:(nonnull NSCharacterSet *)characterSet {
    NSScanner *scanner = [NSScanner scannerWithString:self];
    scanner.charactersToBeSkipped = characterSet;
    
    NSMutableString *aggregate = [NSMutableString new];
    while (!scanner.isAtEnd) {
        NSString *result;
        if ([scanner scanUpToCharactersFromSet:characterSet intoString:&result]) {
            [aggregate appendString:result];
        }
    }
    
    return aggregate;
}

- (nonnull NSString *)stringByRemovingCharactersNotInSet:(nonnull NSCharacterSet *)characterSet {
    return [self stringByRemovingCharactersInSet:[characterSet invertedSet]];
}

- (nonnull NSString *)stringByAbbreviating {
    //trim, capitalize, punctuate
    if (self.length >= 1) {
        return [[[self substringToIndex:1] capitalizedStringWithLocale:[NSLocale currentLocale]] stringByAppendingString:@"."];
    }
    //we can't abbreviate sth that's 0 char
    else {
        return self;
    }
}

- (nonnull NSString *)abbreviatedName {
    NSString *processedName = [self stringByCleaningWhitespace];
    NSArray *nameComponents = [processedName componentsSeparatedByString:@" "];
    NSMutableArray *processedNameComponents = [[NSMutableArray alloc] initWithCapacity:nameComponents.count];
    
    for (NSUInteger i=0; i<nameComponents.count; i++) {
        if (i==0) {
            processedNameComponents[i] = nameComponents[i];
        }
        else {
            processedNameComponents[i] = [nameComponents[i] stringByAbbreviating];
        }
    }
    
    NSString *shortName = [processedNameComponents componentsJoinedByString:@" "];

    return shortName;
}

- (nonnull NSString *)stringByRemovingTrailingSlash {
    if (self.length >= 1) {
        if ([[self substringFromIndex:self.length - 1] isEqualToString:@"/"]) {
            return [self substringToIndex:self.length - 1];
        }
        else {
            return self;
        }
    }
    else {
        return self;
    }
}

- (nonnull NSString *)stringByRemovingPrefix:(nonnull NSString *)prefix {
    if ([self hasPrefix:prefix]) {
        return [self substringFromIndex:prefix.length];
    } else {
        return self;
    }
}

- (nonnull NSString *)stringByRemovingSuffix:(nonnull NSString *)suffix {
    if ([self hasSuffix:suffix]) {
        return [self substringWithRange:NSMakeRange(0, self.length-suffix.length)];
    } else {
        return self;
    }
}

- (nonnull NSAttributedString *)attributedStringWithAttributes:(nullable NSDictionary<NSString *, id> *)attributes {
    return [[NSAttributedString alloc] initWithString:self attributes:attributes];
}

- (nonnull NSString *)filenameSanitizedString {
    NSCharacterSet *illegalFileNameCharacters = [NSCharacterSet characterSetWithCharactersInString:@"\"\\/?<>:%*|"];
    return [[self componentsSeparatedByCharactersInSet:illegalFileNameCharacters] componentsJoinedByString:@""];
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
