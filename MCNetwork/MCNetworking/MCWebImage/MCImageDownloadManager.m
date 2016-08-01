//
//  MCImageDownloadManager.m
//  MCNetwork
//
//  Created by MingleChang on 16/8/1.
//  Copyright © 2016年 Mingle. All rights reserved.
//

#import "MCWebImage.h"

@interface MCImageDownloadManager ()

@property(nonatomic,strong)MCURLSession *session;

@property(nonatomic,copy)NSString *localPath;

@property(nonatomic,strong)NSCache *imageCache;
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
-(NSString *)localPath{
    if (_localPath) {
        return _localPath;
    }
    _localPath=NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    _localPath=[_localPath stringByAppendingPathComponent:ImageLocalDirName];
    return _localPath;
}
-(NSCache *)imageCache{
    if (_imageCache) {
        return _imageCache;
    }
    _imageCache=[[NSCache alloc]init];
    return _imageCache;
}
#pragma mark - Image Path

#pragma mark - Cache

@end
