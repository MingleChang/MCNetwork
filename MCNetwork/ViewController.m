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
@property(nonatomic,strong)MCURLSession *session;
- (IBAction)buttonClick:(UIButton *)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.session=[[MCURLSession alloc]init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonClick:(UIButton *)sender {
    NSString *lURLString=@"http://appapi.unknowntech.cn:7140/postForm";
    NSDictionary *lDic=@{@"dateStamp":@"1468828104",@"isFastLogin":@"2",@"isOwner":@"1",@"password":@"e10adc3949ba59abbe56e057f20f883e",@"uri":@"/user/login",@"username":@"18680752435"};
    [self.session mc_GET:lURLString andParam:lDic uploadProgress:^(int64_t bytes, int64_t totalBytes, int64_t totalBytesExpected) {
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
}
@end
