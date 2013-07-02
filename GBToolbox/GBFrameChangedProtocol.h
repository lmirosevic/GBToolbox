//
//  FrameChangedProtocol.h
//  Russia
//
//  Created by Luka Mirosevic on 02/07/2013.
//  Copyright (c) 2013 Goonbee. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GBFrameChangedProtocol <NSObject>
@required

-(void)viewController:(id)viewController didChangeFrameTo:(CGRect)frame;

@end
