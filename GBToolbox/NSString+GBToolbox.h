//
//  NSString+GBToolbox.h
//  GBToolbox
//
//  Created by Luka Mirosevic on 05/02/2013.
//  Copyright (c) 2013 Luka Mirosevic. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (GBToolbox)

#define GBStringUtilsLocalDNSSuffixes @{@"local", @"lan", @"group"}

/**
 Checks if string is an integer.
 */
- (BOOL)isInteger;

/**
 Checks if the receiver contains a substring.
 
 This check is case sensitive.
 */
- (BOOL)containsSubstring:(nullable NSString *)substring;

/**
 Checks if the receiver contains a substring.
 */
- (BOOL)containsSubstring:(nullable NSString *)substring caseSensitive:(BOOL)isCaseSensitive;

/**
 Returns YES if the receiver equals any of the strings in the strings array.
 */
- (BOOL)isEqualToOneOf:(nonnull NSArray<NSString *> *)strings;

/**
 Returns a new string with the DNS suffix removed from the receiver.
 
 Requires 10.7+
 */
- (nonnull NSString *)stringByDeletingDNSSuffix;

/**
 Checks to see if the receiver looks like an IPv4 IP address. 
 
 Requires 10.7+
 */
- (BOOL)isIP;

/**
 Attempt to get int out of string.
 */
- (int)attemptConversionToInt;

/**
 Attempt to get float out of a string.
 */
- (float)attemptConversionToFloat;

/**
 Attempt to get double out of a string.
 */
- (double)attemptConversionToDouble;

/**
 Return a new string with the leading and trailing whitespace trimmed.
 */
-(nonnull NSString *)stringByTrimmingLeadingAndTrailingWhitespace;

/**
 Return a new string with the leading and trailing whitespace trimmed, and multiple whitespaces coalesced into a single space.
 */
- (nonnull NSString *)stringByCleaningWhitespace;

/**
 Returns a string with all the characters in the set removed from receiver.
 */
- (nonnull NSString *)stringByRemovingCharactersInSet:(nonnull NSCharacterSet *)characterSet;

/**
 Returns a string consisting only of the characters in the characterSet.
 */
- (nonnull NSString *)stringByRemovingCharactersNotInSet:(nonnull NSCharacterSet *)characterSet;

/**
 Converts "Mirosevic" -> "M." and "sloppy" -> "S."
 */
- (nonnull NSString *)stringByAbbreviating;

/**
 Converts "Luka Mirosevic" -> "Luka M." and "Vincent Van Gogh" -> "Vincent V. G."
 */
- (nonnull NSString *)abbreviatedName;

/**
 Return a string with the trailing slash removed from the receiver if there was one.
 */
- (nonnull NSString *)stringByRemovingTrailingSlash;

/**
 Returns a new string with the prefix from the receiver removed if found, otherwise returns the receiver.
 */
- (nonnull NSString *)stringByRemovingPrefix:(nonnull NSString *)prefix;

/**
 Removes a new string with the suffix from the receiver removed if found, otherwise returns the receiver.
 */
- (nonnull NSString *)stringByRemovingSuffix:(nonnull NSString *)suffix;

/**
 Returns an attributed string initialized with self, with the attributes from `attributes`.
 */
- (nonnull NSAttributedString *)attributedStringWithAttributes:(nullable NSDictionary<NSString *, id> *)attributes;

/**
 Returns a copy of the receiver sanitized by removing all characters which could be unsafe inside a filename. Not just for OS X but across other systems as well.
 */
- (nonnull NSString *)filenameSanitizedString;

//Hashes
@property (nonatomic, readonly, nonnull) NSString *md5;
@property (nonatomic, readonly, nonnull) NSString *sha1;
@property (nonatomic, readonly, nonnull) NSString *sha224;
@property (nonatomic, readonly, nonnull) NSString *sha256;
@property (nonatomic, readonly, nonnull) NSString *sha384;
@property (nonatomic, readonly, nonnull) NSString *sha512;

@end
