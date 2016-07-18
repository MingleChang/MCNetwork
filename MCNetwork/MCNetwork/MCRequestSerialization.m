//
//  MCRequestSerialization.m
//  MCNetwork
//
//  Created by MingleChang on 16/7/18.
//  Copyright © 2016年 Mingle. All rights reserved.
//

#import "MCNetwork.h"

@interface MCNetworkRequestSerialization ()

@end

@implementation MCNetworkRequestSerialization

-(NSURLRequest *)GETRequestwithURLString:(NSString *)urlString andParam:(NSDictionary *)param{
    NSAssert(urlString.length>0, @"urlString不能为空");
    NSString *lURLString=urlString;
    NSMutableArray *lParamArray=[NSMutableArray arrayWithCapacity:param.count];
    [param enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSString *lString=[NSString stringWithFormat:@"%@=%@",key,obj];
        [lParamArray addObject:lString];
    }];
    NSString *lParamString=[lParamArray componentsJoinedByString:@"&"];
    if (lParamString.length>0) {
        lURLString=[lURLString stringByAppendingFormat:@"?%@",lParamString];
    }
    NSURL *lURL=[NSURL URLWithString:lURLString];
    NSURLRequest *lRequest=[NSURLRequest requestWithURL:lURL];
    return lRequest;
}
-(NSURLRequest *)POSTRequestwithURLString:(NSString *)urlString andParam:(NSDictionary *)param{
    NSAssert(urlString.length>0, @"urlString不能为空");
    NSString *lURLString=urlString;
    NSMutableArray *lParamArray=[NSMutableArray arrayWithCapacity:param.count];
    [param enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSString *lString=[NSString stringWithFormat:@"%@=%@",key,obj];
        [lParamArray addObject:lString];
    }];
    NSString *lParamString=[lParamArray componentsJoinedByString:@"&"];
    NSURL *lURL=[NSURL URLWithString:lURLString];
    NSMutableURLRequest *lRequest=[NSMutableURLRequest requestWithURL:lURL];
    [lRequest setHTTPMethod:@"POST"];
    [lRequest setHTTPBody:[lParamString dataUsingEncoding:NSUTF8StringEncoding]];
    return lRequest;
}
#pragma mark - MCRequestSerialization
-(NSURLRequest *)requestMethod:(NSString *)method withURLString:(NSString *)urlString andParam:(NSDictionary *)param{
    if ([method isEqualToString:GET_METHOD]) {
        return [self GETRequestwithURLString:urlString andParam:param];
    }
    if ([method isEqualToString:POST_METHOD]) {
        return [self POSTRequestwithURLString:urlString andParam:param];
    }
    return nil;
}

@end