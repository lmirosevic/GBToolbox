//
//  UITableView+GBToolbox.h
//  GBToolbox
//
//  Created by Luka Mirosevic on 05/02/2013.
//  Copyright (c) 2013 Luka Mirosevic. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (GBToolbox)

//detecting when the tableview is scrolled fully down
@property (nonatomic, readonly) BOOL isScrolledToBottom;
-(BOOL)isScrolledToBottomWithTolerance:(CGFloat)tolerance;

@end
