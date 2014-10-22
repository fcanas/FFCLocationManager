//
//  FFCMultiplexingLocationManager.m
//  FFCLocationManager
//
//  Created by Fabian Canas on 10/22/14.
//
//

#import "FFCMultiplexingLocationManager.h"
#import "FFCMultiplexer.h"

@interface FFCMultiplexingLocationManager ()

@property (nonatomic, strong) CLLocationManager *locationManager;

@property (nonatomic, strong) FFCMultiplexer *multiplexer;
@property (nonatomic, strong) NSMutableSet *pendingInvocations;

@property (assign, getter=isUpdating) BOOL updating;

@end

@implementation FFCMultiplexingLocationManager

- (instancetype)init
{
    self = [super init];
    if (self == nil) {
        return nil;
    }
    
    _multiplexer = [FFCMultiplexer new];
    _pendingInvocations = [NSMutableSet set];
    _locationManager = [CLLocationManager new];
    [_locationManager setDelegate:(id<CLLocationManagerDelegate>)_multiplexer];
    [_multiplexer addTarget:self];
    
    return self;
}

- (void)addTarget:(id<CLLocationManagerDelegate>)target
{
    [self.multiplexer addTarget:target];
    if (![self isUpdating]) {
        [self startUpdating];
    }
}

- (void)removeTarget:(id<CLLocationManagerDelegate>)target
{
    [self.multiplexer removeTarget:target];
    if ([self isUpdating]) {
        [self stopUpdating];
    }
}

- (void)startUpdating
{
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[NSMethodSignature methodSignatureForSelector:self.startSelector]];
    [invocation setTarget:self.locationManager];
    
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    switch (status) {
        case kCLAuthorizationStatusAuthorizedAlways:
        case kCLAuthorizationStatusAuthorizedWhenInUse:
            [invocation invoke];
            [self setUpdating:YES];
            break;
        case kCLAuthorizationStatusNotDetermined:
            [self.pendingInvocations addObject:invocation];
            [self.locationManager requestWhenInUseAuthorization];
        case kCLAuthorizationStatusRestricted:
        case kCLAuthorizationStatusDenied:
        default:
            break;
    }
}

- (void)stopUpdating
{
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[NSMethodSignature methodSignatureForSelector:self.stopSelector]];
    [invocation setTarget:self.locationManager];
    [self setUpdating:NO];
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    switch (status) {
        case kCLAuthorizationStatusAuthorizedAlways:
        case kCLAuthorizationStatusAuthorizedWhenInUse:
            for (NSInvocation *inv in self.pendingInvocations) {
                [inv invoke];
                [self startUpdating];
            }
            [self.pendingInvocations removeAllObjects];
            break;
        case kCLAuthorizationStatusNotDetermined:
        case kCLAuthorizationStatusRestricted:
        case kCLAuthorizationStatusDenied:
        default:
            break;
    }
}

@end
