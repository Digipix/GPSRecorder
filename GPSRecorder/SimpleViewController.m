//
//  SimpleViewController.m
//  GPSRecorder
//
//  Created by zhangchao on 14/11/17.
//  Copyright (c) 2014年 zhangchao. All rights reserved.
//

#import "SimpleViewController.h"

@interface SimpleViewController ()

@end

@implementation SimpleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [_mLocationManagerButton setTitle:NSLocalizedString(@"LocationManager.Start", @"Start") forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)didUpdateToLocation:(CLLocation *)newLocation
               fromLocation:(CLLocation *)oldLocation {
    double lat = newLocation.coordinate.latitude;
    double lon = newLocation.coordinate.longitude;
    double alt = newLocation.altitude;
    double speed = newLocation.speed;
    [_mLatitudeTextField setText:[NSString stringWithFormat:@"%.6f", lat]];
    [_mLongitudeTextField setText:[NSString stringWithFormat:@"%.6f", lon]];
    [_mAltitudeTextField setText:[NSString stringWithFormat:@"%.6f m", alt]];
    [_mSpeedTextField setText:[NSString stringWithFormat:@"%.3f m/s", speed]];
}

- (IBAction)onLocationButtonClick:(UIButton *)sender {
    if (_delegate != nil) {
        NSLog(@"isLocationManagerRunning : %d", [_delegate locationManagerRunning]);
        bool isLocationManagerRunning = [_delegate locationManagerRunning];
        if (isLocationManagerRunning) {
            [_mTimeLabel pauseTimer];
            if ([_delegate stopLocation]) {
                [_mLocationManagerButton setTitle:NSLocalizedString(@"LocationManager.Start", @"Start") forState:UIControlStateNormal];
            }
        } else {
            [_mTimeLabel startTimer];
            if ([_delegate startLocation]) {
                [_mLocationManagerButton setTitle:NSLocalizedString(@"LocationManager.Stop", @"Stop") forState:UIControlStateNormal];
            }
        }
    }
}

- (void)didUpdatePlacemark:(CLPlacemark *)newPlacemark {
    NSString *name = newPlacemark.name;
    NSString *address = newPlacemark.addressDictionary[@"FormattedAddressLines"][0];

    [_mPlacemarkLabel setText:address];
}
@end
