//
//  GBCompletable.h
//  GBToolbox
//
//  Created by Luka Mirosevic on 15/07/2013.
//  Copyright (c) 2013 Luka Mirosevic. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GBToolbox.h"

typedef enum {
    GBCompletableStateUnresolved,
    GBCompletableStateSuccess,
    GBCompletableStateFailed,
} GBCompletableState;

@interface GBCompletable : NSObject

@property (assign, nonatomic, readonly) BOOL                    isResolved;
@property (assign, nonatomic, readonly) BOOL                    isCompleted;
@property (assign, nonatomic, readonly) BOOL                    isFailed;
@property (assign, nonatomic, readonly) GBCompletableState      state;

//provider uses the
+(GBCompletable *)completableWithSuccess:(VoidBlock)success fail:(VoidBlock)fail resolve:(VoidBlock)resolve;

//client uses this
-(void)success;
-(void)fail;

@end
