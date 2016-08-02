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

-(void)mc_setImageWith:(NSURL *)url placeholder:(UIImage * __nullable)placeholder options:(MCWebImageOptions)options progress:(MCWebImageProgressBlock __nullable)progressBlock completed:(MCWebImageCompleteBlock)completedBlock{
    [self mc_cancelImageRequest];
    UIImage *lCacheImage=[[MCImageCacheManager manager]imageCacheWith:[url.absoluteString md5]];
    if (lCacheImage) {
        mc_dispatch_main_sync_safe(^{
            self.image=lCacheImage;
        });
        return;
    }
    mc_dispatch_main_sync_safe(^{
        self.image=placeholder;
    });
    __weak __typeof(self)weakself = self;
    self.mc_imageTask=[[MCImageDownloadManager manager]downloadURL:url progress:progressBlock complete:^(UIImage *image, NSData *data, NSError *error) {
        mc_dispatch_main_sync_safe(^{
            if (error || image==nil) {
                weakself.image=placeholder;
            }else{
                weakself.image=image;
                [[MCImageCacheManager manager]cacheImage:image imageData:data withKey:[url.absoluteString md5] toDisk:YES];
            }
            if (completedBlock) {
                completedBlock(image,data,error);
            }
        });
    }];
}
@end
