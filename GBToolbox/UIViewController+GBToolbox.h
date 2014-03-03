//
//  UIViewController+GBToolbox.h
//  GBToolbox
//
//  Created by Luka Mirosevic on 05/02/2013.
//  Copyright (c) 2013 Luka Mirosevic. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (GBToolbox)

//returns YES when the view controller is visible (in between viewWillAppear: and viewDidDisappear:)
@property (assign, nonatomic) BOOL isVisible;

//returns YES when the view controller is visible (in between viewWillAppear: and viewWillDisappear:)
@property (assign, nonatomic) BOOL isVisibleCurrently;

//makes sure the view is loaded
-(void)ensureViewIsLoaded;

@end