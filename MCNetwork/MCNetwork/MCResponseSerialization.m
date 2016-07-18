//
//  MCResponseSerialization.m
//  MCNetwork
//
//  Created by MingleChang on 16/7/18.
//  Copyright © 2016年 Mingle. All rights reserved.
//

#import "MCNetwork.h"

@interface MCNetworkResponseSerialization ()

@end

@implementation MCNetworkResponseSerialization

#pragma mark -
-(id)responseWithData:(NSData *)data error:(NSError *__autoreleasing *)error{
    return data;
}

@end