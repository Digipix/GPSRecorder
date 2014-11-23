//
//  MapViewController.h
//  GPSRecorder
//
//  Created by zhangchao on 14/11/14.
//  Copyright (c) 2014年 zhangchao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MapViewController : UIViewController <MKMapViewDelegate>
@property (strong, nonatomic) IBOutlet MKMapView *mTrackMapView;

/** show gpx file's track OR show user's track in real time.
*   default is true. */
@property (nonatomic, assign) bool isRealTimeMode;
@property (strong, nonatomic) MKPolyline *routeLine;
@property (strong, nonatomic) MKPolylineView * routeLineView;

@end
