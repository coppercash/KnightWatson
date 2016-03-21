//
//  NSLayoutConstraint+Convenient.h
//  KNWThemeDemo
//
//  Created by William on 3/19/16.
//  Copyright © 2016 coppercash. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSLayoutConstraint (Convenient)

+ (NSArray<__kindof NSLayoutConstraint *> *)constraintsByAligningCenterOfView:(UIView *)view
                                                                    otherView:(UIView *)otherView;

+ (NSArray<__kindof NSLayoutConstraint *> *)constraintsByZoomingView:(UIView *)view
                                                           otherView:(UIView *)otherView
                                                             byScale:(float)scale;

@end
