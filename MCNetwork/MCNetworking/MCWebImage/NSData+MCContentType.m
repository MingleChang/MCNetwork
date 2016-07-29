//
//  NSData+MCImageType.m
//  MCNetwork
//
//  Created by MingleChang on 16/7/28.
//  Copyright © 2016年 Mingle. All rights reserved.
//

#import "MCWebImage.h"

@implementation NSData (MCContentType)

-(MCContentType)mc_contentType{
    return [self mc_imageType];
}

#pragma mark - Image Type
-(MCContentType)mc_imageType{
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
    if ([self mc_isImageWEBP]) {
        return MCContentTypeWEBP;
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
-(BOOL)mc_isImageWEBP{
    if ([self length] < 12) {
        return NO;
    }
    
    NSString *testString = [[NSString alloc] initWithData:[self subdataWithRange:NSMakeRange(0, 12)] encoding:NSASCIIStringEncoding];
    if ([testString hasPrefix:@"RIFF"] && [testString hasSuffix:@"WEBP"]) {
        return YES;
    }else{
        return NO;
    }
}
@end
