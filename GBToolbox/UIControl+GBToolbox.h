//
//  UIControl+GBToolbox.h
//  GBToolbox
//
//  Created by Luka Mirosevic on 20/02/2016.
//  Copyright © 2016 Luka Mirosevic. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^GBActionBlock)(id sender, UIEvent *event);

@interface UIControl (GBToolbox)

- (void)addTargetActionForControlEvents:(UIControlEvents)controlEvents withBlock:(GBActionBlock)block;

@end
