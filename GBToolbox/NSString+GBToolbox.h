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

//check if string is integer
-(BOOL)isInteger;

//check if it contains a substring
-(BOOL)containsSubstring:(NSString *)substring; //this is case sensitive
-(BOOL)containsSubstring:(NSString *)substring caseSensitive:(BOOL)isCaseSensitive;

//returns yes if the receiver equals any of the strings in the strings array
-(BOOL)isEqualToOneOf:(NSArray *)strings;

//deletes DNS suffix in a string. requires 10.7+
-(NSString *)stringByDeletingDNSSuffix;

//checks to see if a string is an IP. requires 10.7+
-(BOOL)isIp;

//best attempt to get int out of string
-(int)attemptConversionToInt;

//best attempt to get float out of a string
-(CGFloat)attemptConversionToFloat;

//Trims leading and trailing whitespace
-(NSString *)stringByTrimmingLeadingAndTrailingWhitespace;

//Trims leading and trailing whitespace and flattens multtiple whitespaces into a single space
-(NSString *)stringByCleaningWhitespace;

//Returns a string with all the characters in the set removed
-(NSString *)stringByRemovingCharactersInSet:(NSCharacterSet *)characterSet;

//Returns a string consisting only of the characters in the characterSet
-(NSString *)stringByRemovingCharactersNotInSet:(NSCharacterSet *)characterSet;

//Converts "Mirosevic" -> "M." and "sloppy" -> "S."
-(NSString *)stringByAbbreviating;

//Converts "Luka Mirosevic" -> "Luka M." and "Vincent Van Gogh" -> "Vincent V. G."
-(NSString *)abbreviatedName;

//Hashes
@property (nonatomic, readonly) NSString *md5;
@property (nonatomic, readonly) NSString *sha1;
@property (nonatomic, readonly) NSString *sha224;
@property (nonatomic, readonly) NSString *sha256;
@property (nonatomic, readonly) NSString *sha384;
@property (nonatomic, readonly) NSString *sha512;

@end
