//
//  KNWThemedObjectProxy.h
//  KNWTheme
//
//  Created by William on 12/29/15.
//  Copyright © 2015 coppercash. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KNWThemedObjectProxy : NSProxy {
    NSObject __unsafe_unretained
    *_target;
}

- (instancetype)initWithTarget:(NSObject *)target;

@end
