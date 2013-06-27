//
//  UIScrollView+GBToolbox.h
//  GBToolbox
//
//  Created by Luka Mirosevic on 27/06/2013.
//  Copyright (c) 2013 Luka Mirosevic. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (GBToolbox)

//Scrolling
-(void)scrollToOriginAnimated:(BOOL)animated;
-(void)scrollToTopAnimated:(BOOL)animated;
-(void)scrollToBottomAnimated:(BOOL)animated;
-(void)scrollToLeftAnimated:(BOOL)animated;
-(void)scrollToRightAnimated:(BOOL)animated;


@end
