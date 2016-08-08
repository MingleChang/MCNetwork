//
//  MCURLSession.m
//  MingleChang
//
//  Created by 常峻玮 on 16/5/17.
//  Copyright © 2016年 MingleChang. All rights reserved.
//

#import "MCNetwork.h"
#import "MCRequestSerialization.h"

#pragma mark - MCURLSessionTask
@interface MCURLSessionTask ()

@property(nonatomic,strong,readwrite)NSURLSessionTask *sessionTask;
@property(nonatomic,strong)NSMutableData *data;

+(MCURLSessionTask *)mc_taskWithSessionTask:(NSURLSessionTask *)sessionTask;

@end

@implementation MCURLSessionTask
#pragma mark - Init
-(instancetype)initWithSessionTask:(NSURLSessionTask *)sessionTask{
    self=[super init];
    if (self) {
        self.sessionTask=sessionTask;
        self.data=[NSMutableData data];
    }
    return self;
}

#pragma mark - Create
+(MCURLSessionTask *)mc_taskWithSessionTask:(NSURLSessionTask *)sessionTask{
    MCURLSessionTask *lTask=[[MCURLSessionTask alloc]initWithSessionTask:sessionTask];
    return lTask;
}

#pragma mark - Control
-(void)mc_resume{
    [self.sessionTask resume];
}
-(void)mc_suspend{
    [self.sessionTask suspend];
}
-(void)mc_cancel{
    [self.sessionTask cancel];
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


#pragma mark - MCURLSession
@interface MCURLSession ()<NSURLSessionDelegate,NSURLSessionTaskDelegate>
@property(nonatomic,strong,readwrite)NSURLSessionConfiguration *sessionConfiguration;
@property(nonatomic,strong,readwrite)NSOperationQueue *operationQueue;
@property(nonatomic,strong,readwrite)NSURLSession *session;

@property(nonatomic,strong)NSMutableDictionary *taskInfoByIdentifier;

@property(nonatomic,strong)dispatch_semaphore_t taskInfoSemaphore;

@end

@implementation MCURLSession
#pragma mark - Init
-(instancetype)init{
    return [self initWithSessionConfiguration:nil];
}
-(instancetype)initWithSessionConfiguration:(NSURLSessionConfiguration *)configuration{
    self=[super init];
    if (!self) {
        return nil;
    }
    self.taskInfoSemaphore=dispatch_semaphore_create(1);
    self.taskInfoByIdentifier=[NSMutableDictionary dictionary];
    
    self.sessionConfiguration=configuration ? configuration:[NSURLSessionConfiguration defaultSessionConfiguration];
    self.operationQueue=[[NSOperationQueue alloc]init];
    self.operationQueue.maxConcurrentOperationCount=1;
    self.session=[NSURLSession sessionWithConfiguration:self.sessionConfiguration delegate:self delegateQueue:self.operationQueue];
    [self.session getTasksWithCompletionHandler:^(NSArray<NSURLSessionDataTask *> * _Nonnull dataTasks, NSArray<NSURLSessionUploadTask *> * _Nonnull uploadTasks, NSArray<NSURLSessionDownloadTask *> * _Nonnull downloadTasks) {
        for (NSURLSessionDataTask *dataTask in dataTasks) {
            MCURLSessionTask *task=[MCURLSessionTask mc_taskWithSessionTask:dataTask];
            [self addTask:task];
        }
        
        for (NSURLSessionUploadTask *uploadTask in uploadTasks) {
            MCURLSessionTask *task=[MCURLSessionTask mc_taskWithSessionTask:uploadTask];
            [self addTask:task];
        }
        
        for (NSURLSessionDownloadTask *downloadTask in downloadTasks) {
            MCURLSessionTask *task=[MCURLSessionTask mc_taskWithSessionTask:downloadTask];
            [self addTask:task];
        }
    }];
    
    return self;
}

#pragma mark - Setter And Getter
-(id<MCRequestSerialization>)requestSerialization{
    if (_requestSerialization) {
        return _requestSerialization;
    }
    _requestSerialization=[[MCNetworkRequestSerialization alloc]init];
    return _requestSerialization;
}
-(id<MCResponseSerialization>)responseSerialization{
    if (_responseSerialization) {
        return _responseSerialization;
    }
    _responseSerialization=[[MCNetworkResponseSerialization alloc]init];
    return _responseSerialization;
}

#pragma mark - Session Task Manager
-(MCURLSessionTask *)findTaskByTaskIdentifier:(NSUInteger )taskIdentifier{
    MCURLSessionTask *task=[self.taskInfoByIdentifier objectForKey:@(taskIdentifier)];
    return task;
}
-(MCURLSessionTask *)findTaskBySessionTask:(NSURLSessionTask *)sessionTask{
    MCURLSessionTask *task=[self findTaskByTaskIdentifier:sessionTask.taskIdentifier];
    return task;
}
-(void)addTask:(MCURLSessionTask *)task{
    dispatch_semaphore_wait(self.taskInfoSemaphore, DISPATCH_TIME_FOREVER);
    [self.taskInfoByIdentifier setObject:task forKey:@(task.taskIdentifier)];
    dispatch_semaphore_signal(self.taskInfoSemaphore);
}
-(void)addTaskBySessionTask:(NSURLSessionTask *)sessionTask{
    MCURLSessionTask *task=[MCURLSessionTask mc_taskWithSessionTask:sessionTask];
    [self addTask:task];
}
-(void)removeTask:(MCURLSessionTask *)task{
    [self removeTaskByTaskIdentifier:task.taskIdentifier];
}
-(void)removeTaskBySessionTask:(NSURLSessionTask *)sessionTask{
    [self removeTaskByTaskIdentifier:sessionTask.taskIdentifier];
}
-(void)removeTaskByTaskIdentifier:(NSUInteger )taskIdentifier{
    dispatch_semaphore_wait(self.taskInfoSemaphore, DISPATCH_TIME_FOREVER);
    [self.taskInfoByIdentifier removeObjectForKey:@(taskIdentifier)];
    dispatch_semaphore_signal(self.taskInfoSemaphore);
}
-(void)removeAllTask{
    dispatch_semaphore_wait(self.taskInfoSemaphore, DISPATCH_TIME_FOREVER);
    [self.taskInfoByIdentifier removeAllObjects];
    dispatch_semaphore_signal(self.taskInfoSemaphore);
}
#pragma mark - Create Session Task
-(MCURLSessionTask *)mc_taskWithRequest:(NSURLRequest *)request{
    NSURLSessionTask *sessionTask=[self.session dataTaskWithRequest:request];
    MCURLSessionTask *task=[MCURLSessionTask mc_taskWithSessionTask:sessionTask];
    [self addTask:task];
    [task mc_resume];
    return task;
}
-(MCURLSessionTask *)mc_taskWithRequest:(NSURLRequest *)request
                         uploadProgress:(MCNetworkProgressBlock __nullable)uploadProgress
                       downloadProgress:(MCNetworkProgressBlock __nullable)downloadProgress
                               complete:(MCNetworkCompleteBlock __nullable)complete{
    MCURLSessionTask *task=[self mc_taskWithRequest:request];
    task.uploadProgressBlock=uploadProgress;
    task.downloadProgressBlock=downloadProgress;
    task.completeBlock=complete;
    return task;
}
-(MCURLSessionTask *)mc_GET:(NSString *)urlString
                   complete:(MCNetworkCompleteBlock __nullable)complete{
    return [self mc_GET:urlString andParam:nil complete:complete];
}
-(MCURLSessionTask *)mc_GET:(NSString *)urlString
                   andParam:(NSDictionary * __nullable)param
                   complete:(MCNetworkCompleteBlock __nullable)complete{
    return [self mc_GET:urlString andParam:param downloadProgress:nil complete:complete];
}
-(MCURLSessionTask *)mc_GET:(NSString *)urlString
                   andParam:(NSDictionary * __nullable)param
           downloadProgress:(MCNetworkProgressBlock __nullable)downloadProgress
                   complete:(MCNetworkCompleteBlock __nullable)complete{
    NSURLRequest *lRequest=[self.requestSerialization requestMethod:GET_METHOD withURLString:urlString andParam:param andFormData:nil];
    return [self mc_taskWithRequest:lRequest uploadProgress:nil downloadProgress:downloadProgress complete:complete];
}

-(MCURLSessionTask *)mc_POST:(NSString *)urlString
                    andParam:(NSDictionary * __nullable)param
                    complete:(MCNetworkCompleteBlock __nullable)complete{
    return [self mc_POST:urlString andParam:param uploadProgress:nil downloadProgress:nil complete:complete];
}
-(MCURLSessionTask *)mc_POST:(NSString *)urlString
                    andParam:(NSDictionary * __nullable)param
              uploadProgress:(MCNetworkProgressBlock __nullable)uploadProgress
                    complete:(MCNetworkCompleteBlock __nullable)complete{
    return [self mc_POST:urlString andParam:param uploadProgress:uploadProgress downloadProgress:nil complete:complete];
}
-(MCURLSessionTask *)mc_POST:(NSString *)urlString
                    andParam:(NSDictionary * __nullable)param
            downloadProgress:(MCNetworkProgressBlock __nullable)downloadProgress
                    complete:(MCNetworkCompleteBlock __nullable)complete{
    return [self mc_POST:urlString andParam:param uploadProgress:nil downloadProgress:downloadProgress complete:complete];
}
-(MCURLSessionTask *)mc_POST:(NSString *)urlString
                    andParam:(NSDictionary * __nullable)param
              uploadProgress:(MCNetworkProgressBlock __nullable)uploadProgress
            downloadProgress:(MCNetworkProgressBlock __nullable)downloadProgress
                    complete:(MCNetworkCompleteBlock __nullable)complete{
    return [self mc_POST:urlString andParam:param andFormData:nil uploadProgress:uploadProgress downloadProgress:downloadProgress complete:complete];
}
-(MCURLSessionTask *)mc_POST:(NSString *)urlString
                    andParam:(NSDictionary * __nullable)param
                 andFormData:(id<MCNetworkFormData> __nullable)formData
              uploadProgress:(MCNetworkProgressBlock __nullable)uploadProgress
            downloadProgress:(MCNetworkProgressBlock __nullable)downloadProgress
                    complete:(MCNetworkCompleteBlock __nullable)complete{
    NSURLRequest *lRequest=[self.requestSerialization requestMethod:POST_METHOD withURLString:urlString andParam:param andFormData:formData];
    return [self mc_taskWithRequest:lRequest uploadProgress:uploadProgress downloadProgress:downloadProgress complete:complete];
}

#pragma mark - Delegate
#pragma mark - NSURLSession Delegate
// 当不再需要连接时，调用Session的invalidateAndCancel直接关闭，或者调用finishTasksAndInvalidate等待当前Task结束后关闭。这时Delegate会收到URLSession:didBecomeInvalidWithError:这个事件。
-(void)URLSession:(NSURLSession *)session didBecomeInvalidWithError:(NSError *)error{
    if (self.didBecomeInvalidBlock) {
        self.didBecomeInvalidBlock(error);
    }
}
// 处理用户验证
-(void)URLSession:(NSURLSession *)session didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential * _Nullable))completionHandler{
    NSURLSessionAuthChallengeDisposition disposition = NSURLSessionAuthChallengePerformDefaultHandling;
    __block NSURLCredential *credential = nil;
    if (self.didReceiveAuthenticationChallengeBlock) {
        disposition=self.didReceiveAuthenticationChallengeBlock(challenge,&credential);
    }else{
//        disposition=NSURLSessionAuthChallengeUseCredential;
    }
    if (completionHandler) {
        completionHandler(disposition,credential);
    }
}
// 如果用户启用后台下载，当应用在后台下载完所有的task之后将会调用该方法
-(void)URLSessionDidFinishEventsForBackgroundURLSession:(NSURLSession *)session{
    
}
//请求相关代理
#pragma mark - NSURLSessionTask Delegate
//目前测试情况，GET不会进入该方法，POST会进入该方法
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task willPerformHTTPRedirection:(NSHTTPURLResponse *)response newRequest:(NSURLRequest *)request completionHandler:(void (^)(NSURLRequest * __nullable))completionHandler{
    completionHandler(request);
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * __nullable credential))completionHandler{
    MCURLSessionTask *sessionTask=[self findTaskBySessionTask:task];
    NSURLSessionAuthChallengeDisposition disposition = NSURLSessionAuthChallengePerformDefaultHandling;
    __block NSURLCredential *credential = nil;
    if (self.taskDidReceiveAuthenticationChallengeBlock && sessionTask) {
        disposition=self.taskDidReceiveAuthenticationChallengeBlock(sessionTask,challenge,&credential);
    }else{
//        disposition=NSURLSessionAuthChallengeUseCredential;
    }
    if (completionHandler) {
        completionHandler(disposition,credential);
    }
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task needNewBodyStream:(void (^)(NSInputStream * __nullable bodyStream))completionHandler{
    NSInputStream *inputStream = nil;
    MCURLSessionTask *sessionTask=[self findTaskBySessionTask:task];
    if (self.taskNeedNewBodyStreamBlock && sessionTask) {
        inputStream = self.taskNeedNewBodyStreamBlock(sessionTask);
    } else if (task.originalRequest.HTTPBodyStream && [task.originalRequest.HTTPBodyStream conformsToProtocol:@protocol(NSCopying)]) {
        inputStream = [task.originalRequest.HTTPBodyStream copy];
    }
    
    if (completionHandler) {
        completionHandler(inputStream);
    }
}
//使用POST上传数据，如果request的httpBody有内容方会进入该方法
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didSendBodyData:(int64_t)bytesSent totalBytesSent:(int64_t)totalBytesSent totalBytesExpectedToSend:(int64_t)totalBytesExpectedToSend{
    MCURLSessionTask *sessionTask=[self findTaskBySessionTask:task];
    if (sessionTask.uploadProgressBlock) {
        sessionTask.uploadProgressBlock(bytesSent,totalBytesSent,totalBytesExpectedToSend);
    }
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(nullable NSError *)error{
    MCURLSessionTask *sessionTask=[self findTaskBySessionTask:task];
    [self removeTask:sessionTask];
    NSError *lError=error;
    id responseObject=[self.responseSerialization responseWithData:[sessionTask.data copy] error:&lError];
    if (sessionTask.completeBlock) {
        sessionTask.completeBlock((lError?nil:responseObject),lError);
    }
}

#pragma mark - NSURLSessionData Delegate
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition disposition))completionHandler{
    NSURLSessionResponseDisposition disposition = NSURLSessionResponseAllow;
    MCURLSessionTask *sessionTask=[self findTaskBySessionTask:dataTask];
    if (self.dataTaskDidReceiveResponseBlock && sessionTask) {
        disposition = self.dataTaskDidReceiveResponseBlock(sessionTask, response);
    }
    
    if (completionHandler) {
        completionHandler(disposition);
    }
}
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didBecomeDownloadTask:(NSURLSessionDownloadTask *)downloadTask{
    MCURLSessionTask *dataSessionTask=[self findTaskBySessionTask:dataTask];
    MCURLSessionTask *downloadSessionTask=[MCURLSessionTask mc_taskWithSessionTask:downloadTask];
    if (dataSessionTask) {
        [self removeTask:dataSessionTask];
    }else{
        dataSessionTask=[MCURLSessionTask mc_taskWithSessionTask:dataTask];
    }
    [self addTask:downloadSessionTask];
    
    if (self.dataTaskDidBecomeDownloadTaskBlock && dataSessionTask && downloadSessionTask) {
        self.dataTaskDidBecomeDownloadTaskBlock(dataSessionTask,downloadSessionTask);
    }
}
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didBecomeStreamTask:(NSURLSessionStreamTask *)streamTask{
    
}
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data{
    MCURLSessionTask *sessionTask=[self findTaskBySessionTask:dataTask];
    [sessionTask.data appendData:data];
    if (sessionTask.downloadProgressBlock) {
        sessionTask.downloadProgressBlock(data.length,dataTask.countOfBytesReceived,dataTask.countOfBytesExpectedToReceive);
    }
}
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask willCacheResponse:(NSCachedURLResponse *)proposedResponse completionHandler:(void (^)(NSCachedURLResponse * __nullable cachedResponse))completionHandler{
    completionHandler(proposedResponse);
    NSCachedURLResponse *cachedResponse = proposedResponse;
    MCURLSessionTask *sessionTask=[self findTaskBySessionTask:dataTask];
    if (self.dataTaskWillCacheResponseBlock) {
        cachedResponse = self.dataTaskWillCacheResponseBlock(sessionTask, proposedResponse);
    }
    
    if (completionHandler) {
        completionHandler(cachedResponse);
    }
}

#pragma mark - NSURLSessionDownload Delegate
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location{
    MCURLSessionTask *sessionTask=[self findTaskBySessionTask:downloadTask];
    sessionTask.data=[NSMutableData dataWithContentsOfURL:location];
}
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite{
    MCURLSessionTask *sessionTask=[self findTaskBySessionTask:downloadTask];
    if (sessionTask.downloadProgressBlock) {
        sessionTask.downloadProgressBlock(bytesWritten,totalBytesWritten,totalBytesExpectedToWrite);
    }
}
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didResumeAtOffset:(int64_t)fileOffset expectedTotalBytes:(int64_t)expectedTotalBytes{
    
}

#pragma mark - NSURLSessionStreamDelegate
- (void)URLSession:(NSURLSession *)session readClosedForStreamTask:(NSURLSessionStreamTask *)streamTask{
    
}
- (void)URLSession:(NSURLSession *)session writeClosedForStreamTask:(NSURLSessionStreamTask *)streamTask{
    
}
- (void)URLSession:(NSURLSession *)session betterRouteDiscoveredForStreamTask:(NSURLSessionStreamTask *)streamTask{
    
}
- (void)URLSession:(NSURLSession *)session streamTask:(NSURLSessionStreamTask *)streamTask didBecomeInputStream:(NSInputStream *)inputStream outputStream:(NSOutputStream *)outputStream{
    
}
@end
