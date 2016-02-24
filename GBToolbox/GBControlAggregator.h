//
//  GBControlAggregator.h
//  GBToolbox
//
//  Created by Luka Mirosevic on 20/02/2016.
//  Copyright © 2016 Goonbee e.U. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GBControlAggregator : UIControl

@property (strong, nonatomic, readonly) NSArray<__kindof UIControl *> *controls;

- (instancetype)initWithControls:(NSArray<UIControl *> *)controls axis:(UILayoutConstraintAxis)axis;

@end
