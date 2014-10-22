//
//  FFCLocationManager.m
//  FFCLocationManager
//
//  Created by Fabian Canas on 10/21/14.
//  Copyright (c) 2014 Fabian Canas. All rights reserved.
//

#import "FFCLocationManager.h"
#import "FFCMultiplexingLocationManager.h"

@interface FFCLocationManager ()<CLLocationManagerDelegate>
@property (nonatomic, strong) FFCMultiplexingLocationManager *locationManager;
@property (nonatomic, strong) FFCMultiplexingLocationManager *headingManager;
@end

@implementation FFCLocationManager

- (void)registerForLocationUpdates:(id<CLLocationManagerDelegate>)delegate
{
    [self.locationManager addTarget:delegate];
}

- (void)unregisterForLocationUpdates:(id<CLLocationManagerDelegate>)delegate
{
    [self.locationManager addTarget:delegate];
}

- (void)registerForHeadingUpdates:(id<CLLocationManagerDelegate>)delegate
{
    [self.headingManager addTarget:delegate];
}

- (void)unregisterForHeadingUpdates:(id<CLLocationManagerDelegate>)delegate
{
    [self.headingManager addTarget:delegate];
}

- (FFCMultiplexingLocationManager *)locationManager
{
    if (_locationManager) {
        _locationManager = [FFCMultiplexingLocationManager new];
        _headingManager.startSelector = @selector(startUpdatingLocation);
        _headingManager.stopSelector = @selector(stopUpdatingLocation);
    }
    return _locationManager;
}

- (FFCMultiplexingLocationManager *)headingManager
{
    if (_headingManager) {
        _headingManager = [FFCMultiplexingLocationManager new];
        _headingManager.startSelector = @selector(startUpdatingHeading);
        _headingManager.stopSelector = @selector(stopUpdatingHeading);
    }
    return _headingManager;
}

@end
