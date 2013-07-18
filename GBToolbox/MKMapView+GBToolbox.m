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
    [self moveToRegionIncludingLocations:locationsArray withPaddingPercent:1.0 animated:animated];
}

-(void)moveToRegionIncludingLocations:(NSArray *)locationsArray withPaddingPercent:(CGFloat)paddingPercent animated:(BOOL)animated {
    MKMapRect zoomRect = MKMapRectNull;
    for (CLLocation *location in locationsArray) {
        MKMapPoint annotationPoint = MKMapPointForCoordinate(location.coordinate);
        MKMapRect pointRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 0.1, 0.1);
        zoomRect = MKMapRectUnion(zoomRect, pointRect);
    }
    
    MKMapRect paddedMapRect = MKMapRectMake(zoomRect.origin.x,
                                            zoomRect.origin.y,
                                            zoomRect.size.width*paddingPercent,
                                            zoomRect.size.height*paddingPercent);
    
    [self setVisibleMapRect:paddedMapRect animated:animated];
}

@end
