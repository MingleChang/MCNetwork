//
//  ViewController.m
//  MCNetwork
//
//  Created by 常峻玮 on 16/6/26.
//  Copyright © 2016年 Mingle. All rights reserved.
//

#import "ViewController.h"
#import "MCNetworking.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
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
    [self.imageView mc_setImageWith:[NSURL URLWithString:@"http://images.unknowntech.cn/2016-07-19/d7fe6120-e8fe-4ef9-922d-de79d096c59c.jpg"] placeholder:[UIImage imageNamed:@"a.jpg"] options:0 progress:^(int64_t bytes, int64_t totalBytes, int64_t totalBytesExpected) {
        NSLog(@"DOWNLOAD %lli,%lli,%lli",bytes,totalBytes,totalBytesExpected);
    } completed:^(UIImage *image, NSData *data, NSError *error) {
        NSLog(@"image:%@\nerror:%@",image,error);
    }];
    
//    NSString *lString=[[NSBundle mainBundle]pathForResource:@"test0" ofType:@"webp"];
//    NSData *lData=[NSData dataWithContentsOfFile:lString];
//    UIImage *lImage=[UIImage mc_imageWithData:lData];
//    self.imageView.image=lImage;
    
//    NSString *lURLString=@"http://appapi.unknowntech.cn:7140/postForm";
//    NSDictionary *lDic=@{@"dateStamp":@"1468828104",@"isFastLogin":@"2",@"isOwner":@"1",@"password":@"e10adc3949ba59abbe56e057f20f883e",@"uri":@"/user/login",@"username":@"18680752435"};
//    [self.session mc_POST:lURLString andParam:lDic andFormData:nil uploadProgress:^(int64_t bytes, int64_t totalBytes, int64_t totalBytesExpected) {
//        NSLog(@"UPLOAD %lli,%lli,%lli",bytes,totalBytes,totalBytesExpected);
//    } downloadProgress:^(int64_t bytes, int64_t totalBytes, int64_t totalBytesExpected) {
//        NSLog(@"DOWNLOAD %lli,%lli,%lli",bytes,totalBytes,totalBytesExpected);
//    } complete:^(NSData *data, NSError *error) {
//        if (error) {
//            NSLog(@"%@",error);
//        }else{
//            NSString *lString=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
//            NSLog(@"%@",lString);
//        }
//    }];
    
    
//    NSString *lURLString=@"http://appapi.unknowntech.cn:7140/postFile";
//    NSDictionary *lDic=@{@"dateStamp":@"1469431315",@"loginUserId":@"f86f827060ee47738cf5ca578461acf0",@"uri":@"/web/file/uploadImage"};
//    MCNetworkMultipartFormData *lFormData=[[MCNetworkMultipartFormData alloc]init];
//    NSString *lPath=[[NSBundle mainBundle]pathForResource:@"a" ofType:@"jpg"];
//    [lFormData appendWithName:@"imageFile" fileName:@"image.jpg" mimeType:@"image/jpeg" data:[NSData dataWithContentsOfFile:lPath]];
//    
//    [self.session mc_POST:lURLString andParam:lDic andFormData:lFormData uploadProgress:^(int64_t bytes, int64_t totalBytes, int64_t totalBytesExpected) {
//        NSLog(@"UPLOAD %lli,%lli,%lli",bytes,totalBytes,totalBytesExpected);
//    } downloadProgress:^(int64_t bytes, int64_t totalBytes, int64_t totalBytesExpected) {
//        NSLog(@"DOWNLOAD %lli,%lli,%lli",bytes,totalBytes,totalBytesExpected);
//    } complete:^(NSData *data, NSError *error) {
//        if (error) {
//            NSLog(@"%@",error);
//        }else{
//            NSString *lString=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
//            NSLog(@"%@",lString);
//        }
//    }];
    
    
//    NSString *lURLString=@"http://images.unknowntech.cn/2016-07-19/d7fe6120-e8fe-4ef9-922d-de79d096c59c.jpg";    
//    [self.session mc_GET:lURLString andParam:nil uploadProgress:^(int64_t bytes, int64_t totalBytes, int64_t totalBytesExpected) {
//        NSLog(@"UPLOAD %lli,%lli,%lli",bytes,totalBytes,totalBytesExpected);
//    } downloadProgress:^(int64_t bytes, int64_t totalBytes, int64_t totalBytesExpected) {
//        NSLog(@"DOWNLOAD %lli,%lli,%lli",bytes,totalBytes,totalBytesExpected);
//    } complete:^(NSData *data, NSError *error) {
//        if (error) {
//            NSLog(@"%@",error);
//        }else{
//            NSString *lString=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
//            NSLog(@"%@",lString);
//        }
//    }];
}
@end
