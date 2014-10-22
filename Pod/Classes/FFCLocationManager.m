//
//  FFCLocationManager.m
//  FFCLocationManager
//
//  Created by Fabian Canas on 10/21/14.
//  Copyright (c) 2014 Fabian Canas. All rights reserved.
//

#import "FFCLocationManager.h"
#import "FFCMutiplexer.h"

#import <CoreLocation/CoreLocation.h>

@interface FFCLocationManager ()<CLLocationManagerDelegate>
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) FFCMutiplexer *multiplexer;
@end

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincomplete-implementation"
@implementation FFCLocationManager
#pragma GCC diagnostic pop

- (instancetype)init
{
    self = [super init];
    if (self == nil) {
        return nil;
    }
    
    _multiplexer = [FFCMutiplexer new];
    [_multiplexer addTarget:self];
    
    return self;
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    switch (status) {
        case kCLAuthorizationStatusAuthorizedAlways:
        case kCLAuthorizationStatusAuthorizedWhenInUse:
            [manager startUpdatingLocation];
            break;
        case kCLAuthorizationStatusNotDetermined:
        case kCLAuthorizationStatusRestricted:
        case kCLAuthorizationStatusDenied:
        default:
            break;
    }
}

- (CLLocationManager *)locationManager
{
    if (_locationManager) {
        _locationManager = [CLLocationManager new];
        [_locationManager setDelegate:(id<CLLocationManagerDelegate>)self.multiplexer];
    }
    return _locationManager;
}

@end
