//
//  MCURLSessionTask.h
//  MingleChang
//
//  Created by MingleChang on 16/5/18.
//  Copyright © 2016年 MingleChang. All rights reserved.
//

#import <Foundation/Foundation.h>

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

+(MCURLSessionTask *)mc_taskWithSessionTask:(NSURLSessionTask *)sessionTask;
#pragma mark - Data

#pragma mark - Upload

#pragma mark - Download

#pragma mark - Stream

@end
