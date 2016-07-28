//
//  MCResponseSerialization.h
//  MCNetwork
//
//  Created by MingleChang on 16/7/18.
//  Copyright © 2016年 Mingle. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
@protocol MCResponseSerialization <NSObject>

-(id)responseWithData:(NSData *)data error:(NSError *__autoreleasing *)error;

@end

@interface MCNetworkResponseSerialization : NSObject <MCResponseSerialization>

@end
NS_ASSUME_NONNULL_END