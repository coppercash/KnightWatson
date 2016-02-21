//
//  NSObject+KNWTheme.h
//  KNWTheme
//
//  Created by William on 12/29/15.
//  Copyright © 2015 coppercash. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (KNWThemable)

- (instancetype)knw_themable;

@end

@protocol KNWThemablyInvoking <NSObject>

- (instancetype)substituteArgumentsByIndex:(NSDictionary *)argsByIndex;
- (instancetype(^)(NSDictionary<NSNumber *, id> *))argsByIndex;

- (instancetype)substituteArgument:(id)argument atIndex:(NSUInteger)index;
- (instancetype(^)(NSUInteger, id))argAtIndex;

- (instancetype)setKeepThemable:(BOOL)keep;
- (instancetype(^)(BOOL keep))keepThemable;

@end

@interface NSObject (KNWThemablyInvoking) <KNWThemablyInvoking>
@end

@interface NSObject (KNWConvenientlyThemable)

- (instancetype)knw_themed;

@end
