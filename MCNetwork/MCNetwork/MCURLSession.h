//
//  MCURLSession.h
//  MingleChang
//
//  Created by 常峻玮 on 16/5/17.
//  Copyright © 2016年 MingleChang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MCNetwork.h"

@class MCNetworkMultipartFormData;
@protocol MCRequestSerialization;
@protocol MCResponseSerialization;

typedef NS_ENUM(NSUInteger,MCURLSessionTaskType){
    MCURLSessionTaskTypeUnknown=0,
    MCURLSessionTaskTypeData=1,
    MCURLSessionTaskTypeUpload,
    MCURLSessionTaskTypeDownload,
    MCURLSessionTaskTypeStream,
};

NS_ASSUME_NONNULL_BEGIN

@interface MCURLSessionTask : NSObject

@property(nonatomic,strong,readonly)NSURLSessionTask *sessionTask;
@property (nonatomic,assign,readonly)NSUInteger taskIdentifier;
@property(nonatomic,assign,readonly)MCURLSessionTaskType taskType;


@property(nonatomic,copy)MCNetworkProgressBlock uploadProgressBlock;
@property(nonatomic,copy)MCNetworkProgressBlock downloadProgressBlock;
@property(nonatomic,copy)MCNetworkCompleteBlock completeBlock;

-(void)mc_resume;
-(void)mc_suspend;
-(void)mc_cancel;

#pragma mark - Data

#pragma mark - Upload

#pragma mark - Download

#pragma mark - Stream

@end


@interface MCURLSession : NSObject

@property(nonatomic,strong,readonly)NSURLSession *session;

@property(nonatomic,strong,readonly)NSOperationQueue *operationQueue;

@property(nonatomic,copy)MCNetworkDidBecomeInvalidBlock didBecomeInvalidBlock;


@property(nonatomic,strong)id<MCRequestSerialization> requestSerialization;
@property(nonatomic,strong)id<MCResponseSerialization> responseSerialization;


//-(MCURLSessionTask *)mc_taskWithRequest:(NSURLRequest *)request;
-(MCURLSessionTask *)mc_taskWithRequest:(NSURLRequest *)request uploadProgress:(MCNetworkProgressBlock)uploadProgress downloadProgress:(MCNetworkProgressBlock)downloadProgress complete:(MCNetworkCompleteBlock)complete;
-(MCURLSessionTask *)mc_GET:(NSString *)urlString andParam:(NSDictionary * __nullable)param uploadProgress:(MCNetworkProgressBlock)uploadProgress downloadProgress:(MCNetworkProgressBlock)downloadProgress complete:(MCNetworkCompleteBlock)complete;
-(MCURLSessionTask *)mc_POST:(NSString *)urlString andParam:(NSDictionary * __nullable)param andFormData:(MCNetworkMultipartFormData * __nullable)formData uploadProgress:(MCNetworkProgressBlock)uploadProgress downloadProgress:(MCNetworkProgressBlock)downloadProgress complete:(MCNetworkCompleteBlock)complete;

@end

NS_ASSUME_NONNULL_END
