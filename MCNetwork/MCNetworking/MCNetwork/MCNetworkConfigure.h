//
//  MCNetworkConfigure.h
//  MCNetwork
//
//  Created by 常峻玮 on 16/6/26.
//  Copyright © 2016年 Mingle. All rights reserved.
//

#ifndef MCNetworkConfigure_h
#define MCNetworkConfigure_h

@class MCURLSessionTask;

#import <UIKit/UIKit.h>
#import "MCMimeType.h"

typedef void (^MCNetworkProgressBlock)(int64_t bytes, int64_t totalBytes, int64_t totalBytesExpected);
typedef void (^MCNetworkCompleteBlock)(id responseObject, NSError *error);
typedef void (^MCNetworkDidBecomeInvalidBlock)(NSError *error);
typedef NSURLSessionAuthChallengeDisposition (^MCNetworkDidReceiveAuthenticationChallengeBlock)(NSURLAuthenticationChallenge *challenge, NSURLCredential * __autoreleasing *credential);
typedef NSURLSessionAuthChallengeDisposition (^MCNetworkTaskDidReceiveAuthenticationChallengeBlock)(MCURLSessionTask *task, NSURLAuthenticationChallenge *challenge, NSURLCredential * __autoreleasing *credential);
typedef NSInputStream * (^MCNetworkTaskNeedNewBodyStreamBlock)(MCURLSessionTask *task);
typedef NSURLSessionResponseDisposition (^MCNetworkDataTaskDidReceiveResponseBlock)(MCURLSessionTask *dataTask, NSURLResponse *response);
typedef void (^MCNetworkDataTaskDidBecomeDownloadTaskBlock)(MCURLSessionTask *dataTask, MCURLSessionTask *downloadTask);
typedef NSCachedURLResponse * (^MCNetworkDataTaskWillCacheResponseBlock)(MCURLSessionTask *dataTask, NSCachedURLResponse *proposedResponse);

//HTTP_METHOD
UIKIT_EXTERN NSString* const GET_METHOD;
UIKIT_EXTERN NSString* const POST_METHOD;

//HTTP_HEADER_FIELD
UIKIT_EXTERN NSString* const HTTP_HEADER_ACCEPT;

//HTTP_KEY
UIKIT_EXTERN NSString* const CONTENT_DISPOSITION;
UIKIT_EXTERN NSString* const CONTENT_TYPE;
UIKIT_EXTERN NSString* const CONTENT_LENGTH;

UIKIT_EXTERN NSString* const HTTP_BODY_BOUNDARY;

#define HeaderContentType [NSString stringWithFormat:@"multipart/form-data;boundary=%@",HTTP_BODY_BOUNDARY]
#define StartBoundary   [NSString stringWithFormat:@"\r\n--%@\r\n",HTTP_BODY_BOUNDARY]
#define EndBoundary     [NSString stringWithFormat:@"\r\n--%@--",HTTP_BODY_BOUNDARY]
#define DataDisposition(name,filename) [NSString stringWithFormat:@"%@:form-data;name=\"%@\";filename=\"%@\"\r\n",CONTENT_DISPOSITION,name,filename]
#define StringDisposition(name) [NSString stringWithFormat:@"%@:form-data;name=\"%@\"\r\n\r\n",CONTENT_DISPOSITION,name]
#define ContentType(mimeType) [NSString stringWithFormat:@"%@:%@\r\n\r\n",CONTENT_TYPE,mimeType?mimeType:MIME_TYPE_BINARY]

#endif /* MCNetworkConfigure_h */
