//
//  MCRequestSerialization.h
//  MCNetwork
//
//  Created by MingleChang on 16/7/18.
//  Copyright © 2016年 Mingle. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MCNetworkFormData  <NSObject>

-(void)appendWithName:(NSString *)name data:(NSData *)data;
-(void)appendWithName:(NSString *)name fileName:(NSString * __nullable)fileName mimeType:(NSString * __nullable)mimeType data:(NSData *)data;

@end

@interface MCNetworkMultipartFormData : NSObject <MCNetworkFormData>


@end

@protocol MCRequestSerialization <NSObject>

-(NSURLRequest *)requestMethod:(NSString *)method withURLString:(NSString *)urlString andParam:(NSDictionary  * __nullable)param andFormData:(id<MCNetworkFormData> __nullable)formData;

@end


@interface MCNetworkRequestSerialization : NSObject <MCRequestSerialization>

@end
NS_ASSUME_NONNULL_END