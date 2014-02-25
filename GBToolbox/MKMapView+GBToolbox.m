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
    [self moveToRegionIncludingLocations:locationsArray withPaddingFactor:1.0 animated:animated];
}

-(void)moveToRegionIncludingLocations:(NSArray *)locationsArray withPaddingFactor:(CGFloat)paddingFactor animated:(BOOL)animated {
    MKMapRect zoomRect = MKMapRectNull;
    for (CLLocation *location in locationsArray) {
        MKMapPoint annotationPoint = MKMapPointForCoordinate(location.coordinate);
        MKMapRect pointRect = MKMapRectMake(annotationPoint.x-5, annotationPoint.y-5, 10, 10);
        zoomRect = MKMapRectUnion(zoomRect, pointRect);
    }
    
    CGSize sizeDelta = CGSizeMake(zoomRect.size.width*(paddingFactor - 1.0),
                              zoomRect.size.height*(paddingFactor - 1.0));
    
    MKMapRect paddedMapRect = MKMapRectMake(zoomRect.origin.x - (sizeDelta.width / 2.),
                                            zoomRect.origin.y - (sizeDelta.height / 2.),
                                            zoomRect.size.width + sizeDelta.width,
                                            zoomRect.size.height + sizeDelta.height);
    
    [self setVisibleMapRect:paddedMapRect animated:animated];
}

-(void)moveToLocation:(CLLocation *)location showingRadius:(CGFloat)radius animated:(BOOL)animated {
    //111111m = 1deg lat
    //111111m * cos(lat) = 1deg lng
    CGFloat dlat = radius / 111111.;
    CGFloat dlng = radius*cos(dlat) / 111111.;

    MKCoordinateSpan span = MKCoordinateSpanMake(dlat, dlng);
    MKCoordinateRegion region = MKCoordinateRegionMake(location.coordinate, span);
    
    [self setRegion:region animated:animated];
}

@end
