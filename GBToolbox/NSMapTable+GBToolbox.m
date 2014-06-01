//
//  NSMapTable+GBToolbox.m
//  GBToolbox
//
//  Created by Luka Mirosevic on 01/06/2014.
//  Copyright (c) 2014 Luka Mirosevic. All rights reserved.
//

#import "NSMapTable+GBToolbox.h"

@implementation NSMapTable (GBToolbox)

-(id)objectForKeyedSubscript:(id)key {
    return [self objectForKey:key];
}

-(void)setObject:(id)object forKeyedSubscript:(id)key {
    [self setObject:object forKey:key];
}

@end
