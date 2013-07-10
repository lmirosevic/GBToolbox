//
//  MKMapView+GBToolbox.h
//  GBToolbox
//
//  Created by Luka Mirosevic on 10/07/2013.
//  Copyright (c) 2013 Luka Mirosevic. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface MKMapView (GBToolbox)

//pans and zooms the map to include the points in the locationsArray, which should be CLLocation objects
-(void)moveToRegionIncludingLocations:(NSArray *)locationsArray animated:(BOOL)animated;

@end
