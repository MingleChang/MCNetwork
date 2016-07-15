//
//  ViewController.m
//  MCNetwork
//
//  Created by 常峻玮 on 16/6/26.
//  Copyright © 2016年 Mingle. All rights reserved.
//

#import "ViewController.h"
#import "MCNetwork/MCNetwork.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    MCURLSession *session=[[MCURLSession alloc]init];
    NSURL *lURL=[NSURL URLWithString:@"http://appapi.unknowntech.cn:7140/"];
    NSMutableURLRequest *lRequest=[NSMutableURLRequest requestWithURL:lURL];
    [lRequest setHTTPMethod:@"POST"];
    
//    [lRequest setHTTPBody:[@"dsasdd" dataUsingEncoding:NSUTF8StringEncoding]];
    MCURLSessionTask *task=[session mc_taskWithRequest:lRequest uploadProgress:^(int64_t bytes, int64_t totalBytes, int64_t totalBytesExpected) {
        NSLog(@"UPLOAD %lli,%lli,%lli",bytes,totalBytes,totalBytesExpected);
    } downloadProgress:^(int64_t bytes, int64_t totalBytes, int64_t totalBytesExpected) {
        NSLog(@"DOWNLOAD %lli,%lli,%lli",bytes,totalBytes,totalBytesExpected);
    } complete:^(NSData *data, NSError *error) {
        if (error) {
            NSLog(@"%@",error);
        }else{
            NSString *lString=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"%@",lString);
        }
    }];
    
//    task.uploadProgressBlock=^(int64_t bytes, int64_t totalBytes, int64_t totalBytesExpected){
//        NSLog(@"%lli,%lli,%lli",bytes,totalBytes,totalBytesExpected);
//    };
//    task.downloadProgressBlock=^(int64_t bytes, int64_t totalBytes, int64_t totalBytesExpected){
//        NSLog(@"%lli,%lli,%lli",bytes,totalBytes,totalBytesExpected);
//    };
//    task.completeBlock=^(NSData *data,NSError *error){
//        if (error) {
//            NSLog(@"%@",error);
//        }else{
//            NSString *lString=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
//            NSLog(@"%@",lString);
//        }
//    };
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
