//
//  NSDate+GBToolbox.m
//  GBToolbox
//
//  Created by Luka Mirosevic on 21/06/2013.
//  Copyright (c) 2013 Luka Mirosevic. All rights reserved.
//

#import "NSDate+GBToolbox.h"

@implementation NSDate (GBToolbox)

static NSDateFormatter *outDateFormatter;
static NSArray<NSDateFormatter *> *inDateFormatters;

+(void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        outDateFormatter = [NSDateFormatter new];
        outDateFormatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ssZZ";
        outDateFormatter.timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
        
        NSDateFormatter *inDateFormatter1 = [NSDateFormatter new];
        inDateFormatter1.dateFormat = @"yyyy-MM-dd'T'HH:mm:ssZZ";
        NSDateFormatter *inDateFormatter2 = [NSDateFormatter new];
        inDateFormatter2.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss.SSSZZ";
        inDateFormatters = @[inDateFormatter1, inDateFormatter2];
    });
}

+(NSDate *)dateWithISO8601String:(NSString *)dateString {
    if (!dateString) return nil;
    if ([dateString hasSuffix:@"Z"]) dateString = [[dateString substringToIndex:(dateString.length-1)] stringByAppendingString:@"+0000"];
    
    NSDate *date;
    for (NSDateFormatter *dateFormatter in inDateFormatters) {
        date = [dateFormatter dateFromString:dateString];
        if (date) break;
    }
    
    return date;
}

-(NSString *)iso8601String {
    return [outDateFormatter stringFromDate:self];
}

-(BOOL)isInPast {
    return ([self timeIntervalSinceNow] < 0.);
}

-(BOOL)isDateBetweenStartDate:(NSDate*)beginDate andEndDate:(NSDate*)endDate {
    if ([self compare:beginDate] == NSOrderedAscending) {
    	return NO;
    }
    else if ([self compare:endDate] == NSOrderedDescending) {
        return NO;
    }
    else {
        return YES;
    }
}

@end
