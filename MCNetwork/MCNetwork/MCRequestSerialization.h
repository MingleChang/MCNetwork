//
//  MCRequestSerialization.h
//  MCNetwork
//
//  Created by MingleChang on 16/7/18.
//  Copyright © 2016年 Mingle. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@protocol MCRequestSerialization <NSObject>

-(NSURLRequest *)requestMethod:(NSString *)method withURLString:(NSString *)urlString andParam:(NSDictionary  * __nullable)param andFormData:(MCNetworkMultipartFormData * __nullable)formData;

@end

@interface MCNetworkMultipartFormData : NSObject

-(void)appendWithName:(NSString *)name data:(NSData *)data;
-(void)appendWithName:(NSString *)name fileName:(NSString * __nullable)fileName mimeType:(NSString * __nullable)mimeType data:(NSData *)data;

@end

@interface MCNetworkRequestSerialization : NSObject <MCRequestSerialization>

@end
NS_ASSUME_NONNULL_END