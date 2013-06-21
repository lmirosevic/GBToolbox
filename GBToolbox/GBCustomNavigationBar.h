//
//  GBCustomNavigationBar.h
//  Xmas List
//
//  Created by Luka Mirosevic on 29/11/2012.
//  Copyright (c) 2012 Goonbee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GBCustomNavigationBar : UINavigationBar

+(Class)navigationBarClassWithHeight:(CGFloat)height;
-(id)initWithNavBarHeight:(CGFloat)height;

@end
