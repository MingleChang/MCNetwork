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
    NSURL *lURL=[NSURL URLWithString:@"https://www.baidu.com"];
    NSMutableURLRequest *lRequest=[NSMutableURLRequest requestWithURL:lURL];
    [lRequest setHTTPMethod:@"POST"];
    [lRequest setHTTPBody:[@"a=1" dataUsingEncoding:NSUTF8StringEncoding]];
    NSURLSessionTask *task=[session.session dataTaskWithRequest:lRequest];
    
    [task resume];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
