//
//  GBDebuggableInstanceVendor.h
//  BindSafe
//
//  Created by Luka Mirosevic on 28/03/16.
//  Copyright © 2016 Goonbee e.U. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GBDebuggableInstanceVendor <NSObject>

@required

/**
 Convenience method for creating a new instance for debugging purposes.
 */
+ (instancetype)debuggingInstance;

@end
