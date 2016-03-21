//
//  NSLayoutConstraint+Convenient.m
//  KNWThemeDemo
//
//  Created by William on 3/19/16.
//  Copyright © 2016 coppercash. All rights reserved.
//

#import "NSLayoutConstraint+Convenient.h"

@implementation NSLayoutConstraint (Convenient)

+ (NSArray<__kindof NSLayoutConstraint *> *)constraintsByAligningCenterOfView:(UIView *)view
                                                                    otherView:(UIView *)otherView
{
    return
    @[
      [self constraintWithItem:view attribute:NSLayoutAttributeCenterX
                     relatedBy:NSLayoutRelationEqual
                        toItem:otherView attribute:NSLayoutAttributeCenterY
                    multiplier:1. constant:0.],
      [self constraintWithItem:view attribute:NSLayoutAttributeCenterY
                     relatedBy:NSLayoutRelationEqual
                        toItem:otherView attribute:NSLayoutAttributeCenterY
                    multiplier:1. constant:0.],
      ];
}

+ (NSArray<__kindof NSLayoutConstraint *> *)constraintsByZoomingView:(UIView *)view
                                                           otherView:(UIView *)otherView
                                                             byScale:(float)scale
{
    return
    @[
      [self constraintWithItem:view attribute:NSLayoutAttributeWidth
                     relatedBy:NSLayoutRelationEqual
                        toItem:otherView attribute:NSLayoutAttributeWidth
                    multiplier:scale constant:0.],
      [self constraintWithItem:view attribute:NSLayoutAttributeHeight
                     relatedBy:NSLayoutRelationEqual
                        toItem:otherView attribute:NSLayoutAttributeHeight
                    multiplier:scale constant:0.],
      ];
}

@end
