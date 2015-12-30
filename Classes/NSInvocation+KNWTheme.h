//
//  NSInvocation+KNWTheme.h
//  KNWTheme
//
//  Created by William on 12/29/15.
//  Copyright © 2015 coppercash. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSInvocation (KNWTheme)

- (instancetype)knw_methodArgumentsCopy;
- (void)knw_invokeWithTarget:(id)target theme:(id<NSCopying>)theme;

@end
