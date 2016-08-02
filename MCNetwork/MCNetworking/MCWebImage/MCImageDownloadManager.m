//
//  MCImageDownloadManager.m
//  MCNetwork
//
//  Created by MingleChang on 16/8/1.
//  Copyright © 2016年 Mingle. All rights reserved.
//

#import "MCWebImage.h"

@interface MCImageDownloadManager ()

@property(nonatomic,strong,readwrite)MCURLSession *session;

@end

@implementation MCImageDownloadManager

+(MCImageDownloadManager *)manager{
    static MCImageDownloadManager *staticInstance=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        staticInstance=[[MCImageDownloadManager alloc]init];
    });
    return staticInstance;
}

-(instancetype)init{
    self=[super init];
    if (self) {
        
    }
    return self;
}
#pragma mark - Setter And Getter
-(MCURLSession *)session{
    if (_session) {
        return _session;
    }
    _session=[[MCURLSession alloc]init];
    return _session;
}

#pragma mark - Download
-(MCURLSessionTask *)downloadURL:(NSURL *)url progress:(MCWebImageProgressBlock __nullable)progress complete:(MCWebImageCompleteBlock)complete{
    NSMutableURLRequest *lRequest=[NSMutableURLRequest requestWithURL:url];
    [lRequest setValue:@"image/webp,image/*;q=0.8" forHTTPHeaderField:HTTP_HEADER_ACCEPT];
    return [self downloadRequest:lRequest progress:progress complete:complete];
}

-(MCURLSessionTask *)downloadRequest:(NSURLRequest *)request progress:(MCWebImageProgressBlock __nullable)progress complete:(MCWebImageCompleteBlock)complete{
    return [self.session mc_taskWithRequest:request uploadProgress:nil downloadProgress:^(int64_t bytes, int64_t totalBytes, int64_t totalBytesExpected) {
        if (progress) {
            progress(bytes,totalBytes,totalBytesExpected);
        }
    } complete:^(id responseObject, NSError *error) {
        if (error) {
            if (complete) {
                complete(nil,nil,error);
                return;
            }
        }
        NSData *data=(NSData *)responseObject;
        UIImage *image=[UIImage mc_imageWithData:data];
        if (complete) {
            complete(image,data,nil);
        }
    }];
}
@end
