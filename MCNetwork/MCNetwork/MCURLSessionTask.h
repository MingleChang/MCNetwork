//
//  MCURLSessionTask.h
//  MingleChang
//
//  Created by MingleChang on 16/5/18.
//  Copyright © 2016年 MingleChang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MCNetwork.h"

typedef NS_ENUM(NSUInteger,MCURLSessionTaskType){
    MCURLSessionTaskTypeUnknown=0,
    MCURLSessionTaskTypeData=1,
    MCURLSessionTaskTypeUpload,
    MCURLSessionTaskTypeDownload,
    MCURLSessionTaskTypeStream,
};

@interface MCURLSessionTask : NSObject

@property(nonatomic,strong,readonly)NSURLSessionTask *sessionTask;
@property (nonatomic,assign,readonly)NSUInteger taskIdentifier;
@property(nonatomic,assign,readonly)MCURLSessionTaskType taskType;

@property(nonatomic,strong)NSMutableData *data;

@property(nonatomic,copy)MCNetworkProgressBlock uploadProgressBlock;
@property(nonatomic,copy)MCNetworkProgressBlock downloadProgressBlock;
@property(nonatomic,copy)MCNetworkCompleteBlock completeBlock;

+(MCURLSessionTask *)mc_taskWithSessionTask:(NSURLSessionTask *)sessionTask;

-(void)resume;
-(void)suspend;
-(void)cancel;

#pragma mark - Data

#pragma mark - Upload

#pragma mark - Download

#pragma mark - Stream

@end
