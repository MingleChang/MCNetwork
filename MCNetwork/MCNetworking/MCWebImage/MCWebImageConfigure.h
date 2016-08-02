//
//  MCWebImageConfigure.h
//  MCNetwork
//
//  Created by MingleChang on 16/8/1.
//  Copyright © 2016年 Mingle. All rights reserved.
//

#ifndef MCWebImageConfigure_h
#define MCWebImageConfigure_h

#import <UIKit/UIKit.h>
typedef void (^MCWebImageProgressBlock)(int64_t bytes, int64_t totalBytes, int64_t totalBytesExpected);
typedef void (^MCWebImageCompleteBlock)(UIImage *image, NSData *data, NSError *error);

UIKIT_EXTERN NSString* const ImageLocalDirName;

typedef NS_OPTIONS(NSUInteger, MCWebImageOptions) {
    MCWebImageOptionsUnknow=0,
};

#define mc_dispatch_main_sync_safe(block)\
if ([NSThread isMainThread]) {\
block();\
} else {\
dispatch_sync(dispatch_get_main_queue(), block);\
}

#define mc_dispatch_main_async_safe(block)\
if ([NSThread isMainThread]) {\
block();\
} else {\
dispatch_async(dispatch_get_main_queue(), block);\
}

#endif /* MCWebImageConfigure_h */
