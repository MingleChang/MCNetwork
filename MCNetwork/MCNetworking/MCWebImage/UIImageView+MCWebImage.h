//
//  UIImageView+MCWebImage.h
//  MCNetwork
//
//  Created by MingleChang on 16/8/2.
//  Copyright © 2016年 Mingle. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
@interface UIImageView (MCWebImage)
-(void)mc_setImageWith:(NSString *)urlString;
-(void)mc_setImageWith:(NSString *)urlString placeholder:(UIImage * __nullable)placeholder;
-(void)mc_setImageWith:(NSString *)urlString placeholder:(UIImage * __nullable)placeholder options:(MCWebImageOptions)options progress:(MCWebImageProgressBlock __nullable)progressBlock completed:(MCWebImageCompleteBlock __nullable)completedBlock;
@end
NS_ASSUME_NONNULL_END