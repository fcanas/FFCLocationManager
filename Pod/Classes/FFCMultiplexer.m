//
//  FFCMultiplexer.m
//  FFCLocationManager
//
//  Created by Fabian Canas on 10/21/14.
//  Copyright (c) 2014 Fabian Canas. All rights reserved.
//

#import "FFCMultiplexer.h"

#import <objc/runtime.h>

@interface FFCMultiplexer ()
@property (nonatomic, strong) NSHashTable *targets;
@property(nonatomic, weak) id owner;
@end

@implementation FFCMultiplexer

- (instancetype)init
{
    self = [super init];
    _targets = [NSHashTable weakObjectsHashTable];
    return self;
}

- (void)addTarget:(id)target
{
    [self.targets addObject:target];
}

- (void)removeTarget:(id)target
{
    [self.targets removeObject:target];
}

- (NSUInteger)count
{
    return [self.targets count];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel
{
    NSMethodSignature *signature = [super methodSignatureForSelector:sel];
    if (!signature) {
        for (id obj in self.targets) {
            if ((signature = [obj methodSignatureForSelector:sel])) {
                break;
            }
        }
    }
    return signature;
}

- (BOOL)respondsToSelector:(SEL)aSelector
{
    BOOL base = [super respondsToSelector:aSelector];
    if (base) {
        return base;
    }
    
    BOOL  anyTargetsRespond = NO;
    for (id obj in self.targets) {
        if ([obj respondsToSelector:aSelector]) {
            anyTargetsRespond = YES;
            break;
        }
    }
    
    return anyTargetsRespond;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    for (id obj in self.targets) {
        if ([obj respondsToSelector:anInvocation.selector]) {
            [anInvocation invokeWithTarget:obj];
        }
    }
}

#pragma mark - Behavior

- (void)setOwner:(id)owner
{
    if (_owner != owner) {
        [self releaseLifetimeFromObject:_owner];
        _owner = owner;
        [self bindLifetimeToObject:_owner];
    }
}

- (void)bindLifetimeToObject:(id)object
{
    objc_setAssociatedObject(object, (__bridge void *)self, self, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)releaseLifetimeFromObject:(id)object
{
    objc_setAssociatedObject(object, (__bridge void *)self, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
