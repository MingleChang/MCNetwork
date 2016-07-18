//
//  MCNetworkConfigure.h
//  MCNetwork
//
//  Created by 常峻玮 on 16/6/26.
//  Copyright © 2016年 Mingle. All rights reserved.
//

#ifndef MCNetworkConfigure_h
#define MCNetworkConfigure_h

#import <UIKit/UIKit.h>

typedef void (^MCNetworkProgressBlock)(int64_t bytes, int64_t totalBytes, int64_t totalBytesExpected);
typedef void (^MCNetworkCompleteBlock)(id responseObject, NSError *error);
typedef void (^MCNetworkDidBecomeInvalidBlock)(NSError *error);


UIKIT_EXTERN NSString* const GET_METHOD;
UIKIT_EXTERN NSString* const POST_METHOD;

#endif /* MCNetworkConfigure_h */
