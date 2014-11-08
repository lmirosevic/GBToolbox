//
//  GBRemoteDebugMessages.h
//  GBToolbox
//
//  Created by Luka Mirosevic on 08/11/2014.
//  Copyright (c) 2014 Luka Mirosevic. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GBRemoteDebugMessages : NSObject

@property (assign, nonatomic) BOOL shouldLogLocallyAsWell;// default: NO

+ (instancetype)sharedMessages;
- (id)init;

/**
 Sends a debug message via the network for remote debugging. To listen for messages run `nc -l -k 10000` on the target host, where 10000 is the default port to which messages are sent if you don't specify a custom route. If you specify a port using `RouteRemoteDebugMessagesToServerOnPort` then you should listen on that port.
 */
- (void)sendRemoteDebugMessage:(NSString *)message;

/**
 Determines where to remote debug messages will be sent.
 */
- (void)routeRemoteDebugMessagesToServer:(NSString *)server onPort:(UInt32)port;

@end

static inline void SendRemoteDebugMessage(NSString *message) {
    [[GBRemoteDebugMessages sharedMessages] sendRemoteDebugMessage:message];
}

static inline void RouteRemoteDebugMessagesToServerOnPort(NSString *server, UInt32 port) {
    [[GBRemoteDebugMessages sharedMessages] routeRemoteDebugMessagesToServer:server onPort:port];
}
