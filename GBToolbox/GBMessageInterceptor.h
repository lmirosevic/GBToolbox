//
//  GBMessageInterceptor.h
//  GBToolbox
//
//  Created by Luka Mirosevic on 21/06/2013.
//  Copyright (c) 2013 Luka Mirosevic. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GBMessageInterceptor : NSObject

@property (nonatomic, assign) id    receiver;
@property (nonatomic, assign) id    middleMan;

@end