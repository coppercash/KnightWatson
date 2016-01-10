//
//  KNWThemableObjectProxy.h
//  KNWTheme
//
//  Created by William on 12/29/15.
//  Copyright © 2015 coppercash. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KNWThemableObjectProxy : NSProxy {
    NSObject __unsafe_unretained
    *_target;
    BOOL
    _takeNonObjectArgs;
}

- (instancetype)initWithTarget:(NSObject *)target;

@end
