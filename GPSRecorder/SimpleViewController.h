//
//  SimpleViewController.h
//  GPSRecorder
//
//  Created by zhangchao on 14/11/17.
//  Copyright (c) 2014年 zhangchao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface SimpleViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *mLatitudeTextField;
@property (weak, nonatomic) IBOutlet UITextField *mLongitudeTextField;
@property (weak, nonatomic) IBOutlet UITextField *mAltitudeTextField;

- (void)didUpdateToLocation:(CLLocation *)newLocation
               fromLocation:(CLLocation *)oldLocation;
@end
