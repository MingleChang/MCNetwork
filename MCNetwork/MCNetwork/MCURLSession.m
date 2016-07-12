//
//  MCURLSession.m
//  MingleChang
//
//  Created by 常峻玮 on 16/5/17.
//  Copyright © 2016年 MingleChang. All rights reserved.
//

#import "MCNetwork.h"

@interface MCURLSession ()<NSURLSessionDelegate,NSURLSessionTaskDelegate>
@property(nonatomic,strong,readwrite)NSURLSessionConfiguration *sessionConfiguration;
@property(nonatomic,strong,readwrite)NSOperationQueue *operationQueue;
@property(nonatomic,strong,readwrite)NSURLSession *session;
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
    
    self.sessionConfiguration=configuration ? configuration:[NSURLSessionConfiguration defaultSessionConfiguration];
    self.operationQueue=[[NSOperationQueue alloc]init];
    self.operationQueue.maxConcurrentOperationCount=1;
    self.session=[NSURLSession sessionWithConfiguration:self.sessionConfiguration delegate:self delegateQueue:self.operationQueue];
    
    return self;
}

#pragma mark - Create Task
-(MCURLSessionTask *)mc_taskWithRequest:(NSURLRequest *)request{
    NSURLSessionTask *sessionTask=[self.session dataTaskWithRequest:request];
    MCURLSessionTask *task=[MCURLSessionTask mc_taskWithSessionTask:sessionTask];
    return task;
}

#pragma mark - Delegate
#pragma mark - NSURLSession Delegate
// 当不再需要连接时，调用Session的invalidateAndCancel直接关闭，或者调用finishTasksAndInvalidate等待当前Task结束后关闭。这时Delegate会收到URLSession:didBecomeInvalidWithError:这个事件。
-(void)URLSession:(NSURLSession *)session didBecomeInvalidWithError:(NSError *)error{
    
}
// 处理用户验证
-(void)URLSession:(NSURLSession *)session didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential * _Nullable))completionHandler{
//    completionHandler(NSURLSessionAuthChallengeUseCredential,nil);
}
// 如果用户启用后台下载，当应用在后台下载完所有的task之后将会调用该方法
-(void)URLSessionDidFinishEventsForBackgroundURLSession:(NSURLSession *)session{
    
}
//请求相关代理
#pragma mark - NSURLSessionTask Delegate
//目前测试情况，GET不会进入该方法，POST会进入该方法
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
willPerformHTTPRedirection:(NSHTTPURLResponse *)response
        newRequest:(NSURLRequest *)request
 completionHandler:(void (^)(NSURLRequest * __nullable))completionHandler{
    completionHandler(request);
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge
 completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * __nullable credential))completionHandler{
    
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
 needNewBodyStream:(void (^)(NSInputStream * __nullable bodyStream))completionHandler{
    
}
//使用POST上传数据，如果request的httpBody有内容方会进入该方法
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
   didSendBodyData:(int64_t)bytesSent
    totalBytesSent:(int64_t)totalBytesSent
totalBytesExpectedToSend:(int64_t)totalBytesExpectedToSend{
    
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
didCompleteWithError:(nullable NSError *)error{
    
}

#pragma mark - NSURLSessionData Delegate
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
didReceiveResponse:(NSURLResponse *)response
 completionHandler:(void (^)(NSURLSessionResponseDisposition disposition))completionHandler{
    completionHandler(NSURLSessionResponseAllow);
}
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
didBecomeDownloadTask:(NSURLSessionDownloadTask *)downloadTask{
    
}
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
didBecomeStreamTask:(NSURLSessionStreamTask *)streamTask{
    
}
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
    didReceiveData:(NSData *)data{
    
}
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
 willCacheResponse:(NSCachedURLResponse *)proposedResponse
 completionHandler:(void (^)(NSCachedURLResponse * __nullable cachedResponse))completionHandler{
    completionHandler(proposedResponse);
}

#pragma mark - NSURLSessionDownload Delegate
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
didFinishDownloadingToURL:(NSURL *)location{
    
}
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
      didWriteData:(int64_t)bytesWritten
 totalBytesWritten:(int64_t)totalBytesWritten
totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite{
    
}
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
 didResumeAtOffset:(int64_t)fileOffset
expectedTotalBytes:(int64_t)expectedTotalBytes{
    
}

#pragma mark - NSURLSessionStreamDelegate
- (void)URLSession:(NSURLSession *)session readClosedForStreamTask:(NSURLSessionStreamTask *)streamTask{
    
}
- (void)URLSession:(NSURLSession *)session writeClosedForStreamTask:(NSURLSessionStreamTask *)streamTask{
    
}
- (void)URLSession:(NSURLSession *)session betterRouteDiscoveredForStreamTask:(NSURLSessionStreamTask *)streamTask{
    
}
- (void)URLSession:(NSURLSession *)session streamTask:(NSURLSessionStreamTask *)streamTask
didBecomeInputStream:(NSInputStream *)inputStream
      outputStream:(NSOutputStream *)outputStream{
    
}
@end
