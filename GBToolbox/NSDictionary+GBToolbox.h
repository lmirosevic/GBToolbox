//
//  NSDictionary+GBToolbox.h
//  GBToolbox
//
//  Created by Luka Mirosevic on 06/06/2013.
//  Copyright (c) 2013 Luka Mirosevic. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (GBToolbox)

#pragma mark - pruning

+(NSDictionary *)dictionaryByPruningNullsInDictionary:(NSDictionary *)dictionary;

@end
