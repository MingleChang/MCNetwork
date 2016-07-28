//
//  NSData+MCImageType.m
//  MCNetwork
//
//  Created by MingleChang on 16/7/28.
//  Copyright © 2016年 Mingle. All rights reserved.
//

#import "NSData+MCContentType.h"

@implementation NSData (MCContentType)

-(MCContentType)mc_contentType{
    if ([self mc_isImagePNG]) {
        return MCContentTypePNG;
    }
    if ([self mc_isImageJPEG]) {
        return MCContentTypeJPEG;
    }
    if ([self mc_isImageGIF]) {
        return MCContentTypeGIF;
    }
    if ([self mc_isImageTIFF]) {
        return MCContentTypeTIFF;
    }
    return MCContentTypeUnknown;
}
-(BOOL)mc_isImagePNG{
    uint8_t c;
    [self getBytes:&c length:1];
    if (c == 0x89) {
        return YES;
    }else{
        return NO;
    }
}
-(BOOL)mc_isImageJPEG{
    uint8_t c;
    [self getBytes:&c length:1];
    if (c == 0xFF) {
        return YES;
    }else{
        return NO;
    }
}
-(BOOL)mc_isImageGIF{
    uint8_t c;
    [self getBytes:&c length:1];
    if (c == 0x47) {
        return YES;
    }else{
        return NO;
    }
}
-(BOOL)mc_isImageTIFF{
    uint8_t c;
    [self getBytes:&c length:1];
    if (c == 0x49 || c == 0x4D) {
        return YES;
    }else{
        return NO;
    }
}
@end
