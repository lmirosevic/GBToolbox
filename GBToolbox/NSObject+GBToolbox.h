//
//  NSObject+GBToolbox.h
//  GBToolbox
//
//  Created by Luka Mirosevic on 05/02/2013.
//  Copyright (c) 2013 Luka Mirosevic. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (GBToolbox)

//user identifier for tracking objects
@property (copy, nonatomic) NSString *gbDescription;

//pointer address
@property (copy, nonatomic, readonly) NSString *pointerAddress;

@end
