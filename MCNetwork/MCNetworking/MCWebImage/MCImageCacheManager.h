//
//  MCImageCacheManager.h
//  MCNetwork
//
//  Created by MingleChang on 16/8/2.
//  Copyright © 2016年 Mingle. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCImageCacheManager : NSObject
+(MCImageCacheManager *)manager;
-(void)cacheImage:(UIImage *)image imageData:(NSData *)data withKey:(NSString *)key toDisk:(BOOL)toDisk;
-(UIImage *)imageCacheWith:(NSString *)key;
@end
