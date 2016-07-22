//
//  MCRequestSerialization.m
//  MCNetwork
//
//  Created by MingleChang on 16/7/18.
//  Copyright © 2016年 Mingle. All rights reserved.
//

#import "MCNetwork.h"

@interface MCNetworkDisposition : NSObject

@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *fileName;
@property(nonatomic,copy)NSString *mimeType;
@property(nonatomic,copy)NSData *data;

@end
@implementation MCNetworkDisposition

-(NSData *)dispositionData{
    NSMutableData *lData=[NSMutableData data];
    if (self.fileName.length==0) {
        [lData appendData:[StartBoundary dataUsingEncoding:NSUTF8StringEncoding]];
        [lData appendData:[StringDisposition(self.name) dataUsingEncoding:NSUTF8StringEncoding]];
        [lData appendData:self.data];
    }else{
        [lData appendData:[StartBoundary dataUsingEncoding:NSUTF8StringEncoding]];
        [lData appendData:[DataDisposition(self.name,self.fileName) dataUsingEncoding:NSUTF8StringEncoding]];
        [lData appendData:[ContentType(self.mimeType) dataUsingEncoding:NSUTF8StringEncoding]];
        [lData appendData:self.data];
    }
    return lData;
}

@end

@interface MCNetworkMultipartFormData : NSObject <MCNetworkFormData>

@property(nonatomic,strong)NSMutableArray *multipartDisposition;

@end

@implementation MCNetworkMultipartFormData

-(instancetype)init{
    self=[super init];
    if (self) {
        self.multipartDisposition=[NSMutableArray array];
    }
    return self;
}
-(void)appendWithName:(NSString *)name data:(NSData *)data{
    [self appendWithName:name fileName:nil mimeType:nil data:data];
}
-(void)appendWithName:(NSString *)name fileName:(NSString * __nullable)fileName mimeType:(NSString * __nullable)mimeType data:(NSData *)data{
    MCNetworkDisposition *lDisposition=[[MCNetworkDisposition alloc]init];
    lDisposition.name=name;
    lDisposition.fileName=fileName;
    lDisposition.mimeType=mimeType;
    lDisposition.data=data;
    [self.multipartDisposition addObject:lDisposition];
}
-(NSData *)bodyData{
    if (self.multipartDisposition.count==0) {
        return nil;
    }
    NSMutableData *lData=[NSMutableData data];
    for (MCNetworkDisposition *lDisposition in self.multipartDisposition) {
        [lData appendData:[lDisposition dispositionData]];
    }
    [lData appendData:[EndBoundary dataUsingEncoding:NSUTF8StringEncoding]];
    return lData;
}

@end

@interface MCNetworkRequestSerialization ()

@end

@implementation MCNetworkRequestSerialization

-(NSURLRequest *)GETRequestwithURLString:(NSString *)urlString andParam:(NSDictionary * __nullable)param{
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
-(NSURLRequest *)POSTRequestwithURLString:(NSString *)urlString andParam:(NSDictionary * __nullable)param andFormData:(MCNetworkMultipartFormData * __nullable)formData{
    NSAssert(urlString.length>0, @"urlString不能为空");
    MCNetworkMultipartFormData *lFormData=formData?formData:[[MCNetworkMultipartFormData alloc]init];
    for (NSString *key in param.keyEnumerator) {
        id object=[param objectForKey:key];
        if ([object isKindOfClass:[NSString class]]) {
            NSString *lString=(NSString *)object;
            [lFormData appendWithName:key data:[lString dataUsingEncoding:NSUTF8StringEncoding]];
        }else if ([object isKindOfClass:[NSData class]]){
            NSData *lData=(NSData *)object;
            [lFormData appendWithName:key data:lData];
        }else if ([object isKindOfClass:[NSNumber class]]){
            NSNumber *lNumber=(NSNumber *)object;
            [lFormData appendWithName:key data:[lNumber.stringValue dataUsingEncoding:NSUTF8StringEncoding]];
        }else{
            NSString *lString=[NSString stringWithFormat:@"%@",object];
            [lFormData appendWithName:key data:[lString dataUsingEncoding:NSUTF8StringEncoding]];
        }
    }
    NSData *lBodyData=[lFormData bodyData];
    NSURL *lURL=[NSURL URLWithString:urlString];
    NSMutableURLRequest *lRequest=[NSMutableURLRequest requestWithURL:lURL];
    [lRequest setHTTPMethod:POST_METHOD];
    [lRequest setHTTPBody:lBodyData];
    ;
    [lRequest setValue:HeaderContentType forHTTPHeaderField:CONTENT_TYPE];
    [lRequest setValue:[NSString stringWithFormat:@"%li", (unsigned long)[lBodyData length]] forHTTPHeaderField:CONTENT_LENGTH];
    return lRequest;
}
#pragma mark - MCRequestSerialization
-(NSURLRequest *)requestMethod:(NSString *)method withURLString:(NSString *)urlString andParam:(NSDictionary * __nullable)param andFormData:(id<MCNetworkFormData> __nullable)formData{
    if ([method isEqualToString:GET_METHOD]) {
        return [self GETRequestwithURLString:urlString andParam:param];
    }
    if ([method isEqualToString:POST_METHOD]) {
        return [self POSTRequestwithURLString:urlString andParam:param andFormData:formData];
    }
    return nil;
}

@end