//
//  FFCMultiplexer.h
//  FFCLocationManager
//
//  Created by Fabian Canas on 10/21/14.
//  Copyright (c) 2014 Fabian Canas. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FFCMultiplexer : NSObject

- (void)setOwner:(id)owner;

- (void)addTarget:(id)target;

- (void)removeTarget:(id)target;

- (NSUInteger)count;

@end
