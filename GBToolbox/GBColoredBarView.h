//
//  GBColoredBarView.h
//  Russia
//
//  Created by Luka Mirosevic on 27/06/2013.
//  Copyright (c) 2013 Goonbee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GBColoredBarView : UIView

@property (strong, nonatomic) NSArray           *colors;
@property (strong, nonatomic) NSArray           *fractions;
@property (strong, nonatomic) UIColor           *backgroundColorWhenEmpty;
@property (strong, nonatomic) UIColor           *backgroundColorWhenFull;
@property (strong, nonatomic) UIColor           *borderColor;
@property (assign, nonatomic) CGFloat           borderThickness;
@property (assign, nonatomic) BOOL              showBorderWhenFull;
@property (assign, nonatomic) BOOL              showBorderWhenEmpty;

@end
