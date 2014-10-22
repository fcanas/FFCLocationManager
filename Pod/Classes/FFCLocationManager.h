//
//  FFCLocationManager.h
//  FFCLocationManager
//
//  Created by Fabian Canas on 10/21/14.
//  Copyright (c) 2014 Fabian Canas. All rights reserved.
//

@import CoreLocation;

@interface FFCLocationManager : NSObject

- (void)addTarget:(id<CLLocationManagerDelegate>)target;

- (void)removeTarget:(id<CLLocationManagerDelegate>)target;

@end
