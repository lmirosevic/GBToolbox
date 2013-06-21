//
//  NSDate+GBToolbox.m
//  GBToolbox
//
//  Created by Luka Mirosevic on 21/06/2013.
//  Copyright (c) 2013 Luka Mirosevic. All rights reserved.
//

#import "NSDate+GBToolbox.h"

@implementation NSDate (GBToolbox)

+(NSDate *)dateWithISO8601String:(NSString *)dateString {
    if (!dateString) return nil;
    if ([dateString hasSuffix:@"Z"]) dateString = [[dateString substringToIndex:(dateString.length-1)] stringByAppendingString:@"+0000"];
    
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ssZZ";
    return [dateFormatter dateFromString:dateString];
}

-(NSString *)iso8601String {
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ssZZ";
    dateFormatter.timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    return [dateFormatter stringFromDate:self];
}

@end
