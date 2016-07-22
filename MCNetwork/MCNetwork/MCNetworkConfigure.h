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

//HTTP_METHOD
UIKIT_EXTERN NSString* const GET_METHOD;
UIKIT_EXTERN NSString* const POST_METHOD;

//HTTP_KEY
UIKIT_EXTERN NSString* const CONTENT_DISPOSITION;
UIKIT_EXTERN NSString* const CONTENT_TYPE;
UIKIT_EXTERN NSString* const CONTENT_LENGTH;

//MIME_TYPE
UIKIT_EXTERN NSString* const MIME_TYPE_BINARY;

UIKIT_EXTERN NSString* const HTTP_BODY_BOUNDARY;

#define HeaderContentType [NSString stringWithFormat:@"multipart/form-data;boundary=%@",HTTP_BODY_BOUNDARY]
#define StartBoundary   [NSString stringWithFormat:@"\r\n--%@\r\n",HTTP_BODY_BOUNDARY]
#define EndBoundary     [NSString stringWithFormat:@"\r\n--%@--",HTTP_BODY_BOUNDARY]
#define DataDisposition(name,filename) [NSString stringWithFormat:@"%@:form-data;name=\"%@\";filename=\"%@\"\r\n",CONTENT_DISPOSITION,name,filename]
#define StringDisposition(name) [NSString stringWithFormat:@"%@:form-data;name=\"%@\"\r\n\r\n",CONTENT_DISPOSITION,name]
#define ContentType(mimeType) [NSString stringWithFormat:@"%@:%@\r\n\r\n",CONTENT_TYPE,mimeType?mimeType:MIME_TYPE_BINARY]

#endif /* MCNetworkConfigure_h */
