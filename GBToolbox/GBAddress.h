//
//  GBAddress.h
//  GBToolbox
//
//  Created by Luka Mirosevic on 07/06/2014.
//  Copyright (c) 2014 Luka Mirosevic. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GBAddress : NSObject

@property (copy, nonatomic) NSString *street;
@property (copy, nonatomic) NSString *city;
@property (copy, nonatomic) NSString *zip;
@property (copy, nonatomic) NSString *country;
@property (copy, nonatomic) NSString *countryCode;
@property (copy, nonatomic) NSString *state;

@end
