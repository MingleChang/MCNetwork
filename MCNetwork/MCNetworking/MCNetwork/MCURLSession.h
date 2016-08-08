//
//  MCURLSession.h
//  MingleChang
//
//  Created by 常峻玮 on 16/5/17.
//  Copyright © 2016年 MingleChang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MCNetwork.h"

@protocol MCNetworkFormData;
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
@property(nonatomic,copy)MCNetworkDidReceiveAuthenticationChallengeBlock didReceiveAuthenticationChallengeBlock;
@property(nonatomic,copy)MCNetworkTaskDidReceiveAuthenticationChallengeBlock taskDidReceiveAuthenticationChallengeBlock;
@property(nonatomic,copy)MCNetworkTaskNeedNewBodyStreamBlock taskNeedNewBodyStreamBlock;
@property(nonatomic,copy)MCNetworkDataTaskDidReceiveResponseBlock dataTaskDidReceiveResponseBlock;
@property(nonatomic,copy)MCNetworkDataTaskDidBecomeDownloadTaskBlock dataTaskDidBecomeDownloadTaskBlock;
@property(nonatomic,copy)MCNetworkDataTaskWillCacheResponseBlock dataTaskWillCacheResponseBlock;

@property(nonatomic,strong)id<MCRequestSerialization> requestSerialization;
@property(nonatomic,strong)id<MCResponseSerialization> responseSerialization;

-(MCURLSessionTask *)mc_taskWithRequest:(NSURLRequest *)request
                         uploadProgress:(MCNetworkProgressBlock __nullable)uploadProgress
                        downloadProgress:(MCNetworkProgressBlock __nullable)downloadProgress
                               complete:(MCNetworkCompleteBlock __nullable)complete;

-(MCURLSessionTask *)mc_GET:(NSString *)urlString
                   complete:(MCNetworkCompleteBlock __nullable)complete;

-(MCURLSessionTask *)mc_GET:(NSString *)urlString
                   andParam:(NSDictionary * __nullable)param
                   complete:(MCNetworkCompleteBlock __nullable)complete;

-(MCURLSessionTask *)mc_GET:(NSString *)urlString andParam:(NSDictionary * __nullable)param
           downloadProgress:(MCNetworkProgressBlock __nullable)downloadProgress
                   complete:(MCNetworkCompleteBlock __nullable)complete;

-(MCURLSessionTask *)mc_POST:(NSString *)urlString
                    andParam:(NSDictionary * __nullable)param
                    complete:(MCNetworkCompleteBlock __nullable)complete;

-(MCURLSessionTask *)mc_POST:(NSString *)urlString
                    andParam:(NSDictionary * __nullable)param
              uploadProgress:(MCNetworkProgressBlock __nullable)uploadProgress
                    complete:(MCNetworkCompleteBlock __nullable)complete;

-(MCURLSessionTask *)mc_POST:(NSString *)urlString
                    andParam:(NSDictionary * __nullable)param
            downloadProgress:(MCNetworkProgressBlock __nullable)downloadProgress
                    complete:(MCNetworkCompleteBlock __nullable)complete;

-(MCURLSessionTask *)mc_POST:(NSString *)urlString
                    andParam:(NSDictionary * __nullable)param
              uploadProgress:(MCNetworkProgressBlock __nullable)uploadProgress
            downloadProgress:(MCNetworkProgressBlock __nullable)downloadProgress
                    complete:(MCNetworkCompleteBlock __nullable)complete;

-(MCURLSessionTask *)mc_POST:(NSString *)urlString
                    andParam:(NSDictionary * __nullable)param
                 andFormData:(id<MCNetworkFormData> __nullable)formData
              uploadProgress:(MCNetworkProgressBlock __nullable)uploadProgress
            downloadProgress:(MCNetworkProgressBlock __nullable)downloadProgress
                    complete:(MCNetworkCompleteBlock __nullable)complete;

@end

NS_ASSUME_NONNULL_END
