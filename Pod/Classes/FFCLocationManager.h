//
//  FFCLocationManager.h
//  FFCLocationManager
//
//  Created by Fabian Canas on 10/21/14.
//  Copyright (c) 2014 Fabian Canas. All rights reserved.
//

@import CoreLocation;

@interface FFCLocationManager : NSObject

- (void)registerForLocationUpdates:(id<CLLocationManagerDelegate>)delegate;

- (void)unregisterForLocationUpdates:(id<CLLocationManagerDelegate>)delegate;

- (void)registerForHeadingUpdates:(id<CLLocationManagerDelegate>)delegate;

- (void)unregisterForHeadingUpdates:(id<CLLocationManagerDelegate>)delegate;

@end
