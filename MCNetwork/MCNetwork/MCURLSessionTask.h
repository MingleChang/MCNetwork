//
//  MCURLSessionTask.h
//  MingleChang
//
//  Created by MingleChang on 16/5/18.
//  Copyright © 2016年 MingleChang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger,MCURLSessionTaskType){
    MCURLSessionTaskTypeData=1,
    MCURLSessionTaskTypeUpload,
    MCURLSessionTaskTypeDownload,
    MCURLSessionTaskTypeStream,
};

@interface MCURLSessionTask : NSObject

@property(nonatomic,strong)NSURLSessionTask *task;

@property(nonatomic,assign)MCURLSessionTaskType taskType;

#pragma mark - Data

#pragma mark - Upload

#pragma mark - Download

#pragma mark - Stream

@end
