//
//  NSMutableDictionary+GBToolbox.h
//  GBToolbox
//
//  Created by Luka Mirosevic on 06/06/2013.
//  Copyright (c) 2013 Luka Mirosevic. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary<KeyType, ObjectType> (GBToolbox)

#pragma mark - Pruning

/**
 Removes all intances of NSNull from this dictionary (shallow search only).
 */
- (void)pruneNulls;

@end
