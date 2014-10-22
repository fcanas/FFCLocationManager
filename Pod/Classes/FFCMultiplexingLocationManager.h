//
//  FFCMultiplexingLocationManager.h
//  FFCLocationManager
//
//  Created by Fabian Canas on 10/22/14.
//
//

@import CoreLocation;

@interface FFCMultiplexingLocationManager : NSObject

- (void)startUpdating;
- (void)stopUpdating;

@property (nonatomic, assign) SEL startSelector;
@property (nonatomic, assign) SEL stopSelector;

- (void)addTarget:(id<CLLocationManagerDelegate>)target;

- (void)removeTarget:(id<CLLocationManagerDelegate>)target;

@end
