//
//  UIImageView+MCWebImage.m
//  MCNetwork
//
//  Created by MingleChang on 16/8/2.
//  Copyright © 2016年 Mingle. All rights reserved.
//

#import "MCWebImage.h"
#import <objc/runtime.h>

@interface UIImageView (_MCWebImage)

@property (readwrite, nonatomic, strong,setter = mc_setImageTask:) MCURLSessionTask *mc_imageTask;

@end

@implementation UIImageView (_MCWebImage)
-(MCURLSessionTask *)mc_imageTask{
    return (MCURLSessionTask *)objc_getAssociatedObject(self, @selector(mc_imageTask));
}
-(void)mc_setImageTask:(MCURLSessionTask *)imageTask{
    objc_setAssociatedObject(self, @selector(mc_imageTask), imageTask, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end

@implementation UIImageView (MCWebImage)
-(void)mc_cancelImageRequest{
    [self.mc_imageTask mc_cancel];
}
-(void)mc_setImageWith:(NSString *)urlString{
    [self mc_setImageWith:urlString placeholder:nil];
}
-(void)mc_setImageWith:(NSString *)urlString placeholder:(UIImage * __nullable)placeholder{
    [self mc_setImageWith:urlString placeholder:placeholder options:0 progress:nil completed:nil];
}
-(void)mc_setImageWith:(NSString *)urlString placeholder:(UIImage * __nullable)placeholder options:(MCWebImageOptions)options progress:(MCWebImageProgressBlock __nullable)progressBlock completed:(MCWebImageCompleteBlock __nullable)completedBlock{
    [self mc_cancelImageRequest];
    NSString *lCacheKey=[urlString md5];
    UIImage *lCacheImage=[[MCImageCacheManager manager]imageCacheWith:lCacheKey];
    if (lCacheImage) {
        mc_dispatch_main_sync_safe(^{
            self.image=lCacheImage;
            if (completedBlock) {
                completedBlock(lCacheImage,nil,nil);
            }
        });
        return;
    }
    mc_dispatch_main_sync_safe(^{
        self.image=placeholder;
    });
    __weak __typeof(self)weakself = self;
    self.mc_imageTask=[[MCImageDownloadManager manager]downloadURLString:urlString progress:progressBlock complete:^(UIImage *image, NSData *data, NSError *error) {
        mc_dispatch_main_sync_safe(^{
            if (error || image==nil) {
                weakself.image=placeholder;
            }else{
                weakself.image=image;
                [[MCImageCacheManager manager]cacheImage:image imageData:data withKey:lCacheKey toDisk:YES];
            }
            if (completedBlock) {
                completedBlock(image,data,error);
            }
        });
    }];
}
@end
