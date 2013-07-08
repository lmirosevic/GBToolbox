//
//  UITableViewCell+AdditionalViews.h
//  Russia
//
//  Created by Luka Mirosevic on 27/06/2013.
//  Copyright (c) 2013 Goonbee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableViewCell (AdditionalViews)

@property (strong, nonatomic) UIView        *leftView;
@property (assign, nonatomic) CGRect        leftViewFrame;
@property (strong, nonatomic) UIView        *rightView;
@property (assign, nonatomic) CGRect        rightViewFrame;

@end
