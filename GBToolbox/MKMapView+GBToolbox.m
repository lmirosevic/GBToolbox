//
//  MKMapView+GBToolbox.m
//  GBToolbox
//
//  Created by Luka Mirosevic on 10/07/2013.
//  Copyright (c) 2013 Luka Mirosevic. All rights reserved.
//

#import "MKMapView+GBToolbox.h"

@implementation MKMapView (GBToolbox)

-(void)moveToRegionIncludingLocations:(NSArray *)locationsArray animated:(BOOL)animated {
    MKMapRect zoomRect = MKMapRectNull;
    for (CLLocation *location in locationsArray) {
        MKMapPoint annotationPoint = MKMapPointForCoordinate(location.coordinate);
        MKMapRect pointRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 0.1, 0.1);
        zoomRect = MKMapRectUnion(zoomRect, pointRect);
    }
    
    [self setVisibleMapRect:zoomRect animated:animated];
}

@end
