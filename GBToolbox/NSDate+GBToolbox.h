//
//  NSDate+GBToolbox.h
//  GBToolbox
//
//  Created by Luka Mirosevic on 21/06/2013.
//  Copyright (c) 2013 Luka Mirosevic. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (GBToolbox)

+(NSDate *)dateWithISO8601String:(NSString *)dateString;
-(NSString *)iso8601String;

@end
