//
//  GBEnumWrapper.m
//  World Cup Survival Guide
//
//  Created by Luka Mirosevic on 06/06/2014.
//  Copyright (c) 2014 Goonbee. All rights reserved.
//

#import "GBEnumWrapper.h"

@interface GBEnumWrapper ()

@property (assign, nonatomic) int value;

@end

@implementation GBEnumWrapper

-(id)initWithInt:(int)value {
    if (self = [super init]) {
        self.value = value;
    }
    
    return self;
}

-(int)intValue {
    return self.value;
}

@end
