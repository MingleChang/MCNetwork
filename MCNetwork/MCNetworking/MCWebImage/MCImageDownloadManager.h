//
//  MCImageDownloadManager.h
//  MCNetwork
//
//  Created by MingleChang on 16/8/1.
//  Copyright © 2016年 Mingle. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
@interface MCImageDownloadManager : NSObject

@property(nonatomic,strong,readonly)MCURLSession *session;
+(MCImageDownloadManager *)manager;
-(MCURLSessionTask *)downloadURL:(NSURL *)url progress:(MCWebImageProgressBlock __nullable)progress complete:(MCWebImageCompleteBlock)complete;
-(MCURLSessionTask *)downloadRequest:(NSURLRequest *)request progress:(MCWebImageProgressBlock __nullable)progress complete:(MCWebImageCompleteBlock)complete;
@end
NS_ASSUME_NONNULL_END
