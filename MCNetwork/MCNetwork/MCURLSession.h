//
//  MCURLSession.h
//  MingleChang
//
//  Created by 常峻玮 on 16/5/17.
//  Copyright © 2016年 MingleChang. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MCURLSessionTask;

@interface MCURLSession : NSObject

@property(nonatomic,strong,readonly)NSURLSession *session;

@property(nonatomic,strong,readonly)NSOperationQueue *operationQueue;

//@property(nonatomic,strong,readonly)NSArray *tasks;
//
//@property(nonatomic,strong,readonly)NSArray *dataTasks;
//
//@property(nonatomic,strong,readonly)NSArray *uploadTasks;
//
//@property(nonatomic,strong,readonly)NSArray *downloadTasks;

-(MCURLSessionTask *)mc_taskWithRequest:(NSURLRequest *)request;

@end
