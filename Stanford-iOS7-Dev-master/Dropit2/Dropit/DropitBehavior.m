//
//  DropitBehavior.m
//  Dropit
//
//  Created by Mark Lewis on 15-8-10.
//  Copyright (c) 2015年 TechLewis. All rights reserved.
//

#import "DropitBehavior.h"

@interface DropitBehavior ()

@property (strong ,nonatomic) UIGravityBehavior *gravity;
@property (strong ,nonatomic) UICollisionBehavior *collider;
@property (strong ,nonatomic) UIDynamicItemBehavior *animationOptions;
@end

@implementation DropitBehavior

- (void)addItem:(id<UIDynamicItem>)item
{
    [self.gravity addItem:item];
    [self.collider addItem:item];
    [self.animationOptions addItem:item];
}

- (void)removeItem:(id<UIDynamicItem>)item
{
    [self.gravity removeItem:item];
    [self.collider removeItem:item];
    [self.animationOptions removeItem:item];
}

- (instancetype)init
{
    self = [super init];
    // init code
    [self addChildBehavior:self.gravity];
    [self addChildBehavior:self.collider];
    [self addChildBehavior:self.animationOptions];
    return self;
}

#pragma mark - lazy loading
- (UIGravityBehavior *)gravity
{
    if(!_gravity)
    {
        _gravity = [[UIGravityBehavior alloc] init];
        _gravity.magnitude = 1.0;
    }
    return _gravity;
}

- (UICollisionBehavior *)collider
{
    if(!_collider)
    {
        _collider = [[UICollisionBehavior alloc] init];
        // 以ReferenceView为碰撞的范围bounds
        _collider.translatesReferenceBoundsIntoBoundary = YES;
    }
    
    return _collider;
}

- (UIDynamicItemBehavior *)animationOptions
{
    if (!_animationOptions)
    {
        _animationOptions = [[UIDynamicItemBehavior alloc] init];
        _animationOptions.allowsRotation = NO;
    }
    return _animationOptions;
}
@end
