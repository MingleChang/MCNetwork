//
//  NSData+MCImageType.h
//  MCNetwork
//
//  Created by MingleChang on 16/7/28.
//  Copyright © 2016年 Mingle. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,MCContentType){
    MCContentTypeUnknown=0,
#pragma mark - Image
    MCContentTypePNG=100,
    MCContentTypeJPEG,
    MCContentTypeGIF,
    MCContentTypeTIFF,
    MCContentTypeWEBP,
};

@interface NSData (MCContentType)

-(MCContentType)mc_contentType;
-(MCContentType)mc_imageType;

@end
