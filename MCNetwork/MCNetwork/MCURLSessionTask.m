//
//  MCURLSessionTask.m
//  MingleChang
//
//  Created by MingleChang on 16/5/18.
//  Copyright © 2016年 MingleChang. All rights reserved.
//

#import "MCNetwork.h"

@interface MCURLSessionTask ()

@property(nonatomic,strong,readwrite)NSURLSessionTask *sessionTask;

@end

@implementation MCURLSessionTask
#pragma mark - Init
-(instancetype)initWithSessionTask:(NSURLSessionTask *)sessionTask{
    self=[super init];
    if (self) {
        self.sessionTask=sessionTask;
    }
    return self;
}

#pragma mark - Create
+(MCURLSessionTask *)mc_taskWithSessionTask:(NSURLSessionTask *)sessionTask{
    MCURLSessionTask *lTask=[[MCURLSessionTask alloc]initWithSessionTask:sessionTask];
    return lTask;
}

#pragma mark - Getter And Setter
-(NSUInteger)taskIdentifier{
    return self.sessionTask.taskIdentifier;
}
-(MCURLSessionTaskType)taskType{
    if ([self.sessionTask isKindOfClass:[NSURLSessionDataTask class]]) {
        return MCURLSessionTaskTypeData;
    }else if ([self.sessionTask isKindOfClass:[NSURLSessionUploadTask class]]){
        return MCURLSessionTaskTypeUpload;
    }else if ([self.sessionTask isKindOfClass:[NSURLSessionDownloadTask class]]){
        return MCURLSessionTaskTypeDownload;
    }else if ([self.sessionTask isKindOfClass:[NSURLSessionStreamTask class]]){
        return MCURLSessionTaskTypeStream;
    }else{
        return MCURLSessionTaskTypeUnknown;
    }
}
@end
