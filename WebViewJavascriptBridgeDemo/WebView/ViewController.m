//
//  ViewController.m
//  WebView
//
//  Created by chni on 15/12/30.
//  Copyright © 2015年 孟家豪. All rights reserved.
//

#import "ViewController.h"
#import "WebViewJavascriptBridge.h"
#import "QRCScannerViewController.h"
@interface ViewController ()<QRCodeScannerViewControllerDelegate>

@property (nonatomic,strong) WebViewJavascriptBridge* bridge;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"WebViewJavascriptBridge" ofType:@"html"];
    NSString *htmlString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    [_webView loadHTMLString:htmlString baseURL:nil];
    
    //设置能够进行桥接
    [WebViewJavascriptBridge enableLogging];
    // 初始化WebViewJavascriptBridge,进行桥接
    _bridge = [WebViewJavascriptBridge bridgeForWebView:_webView];
    
    // registerHandler 要注册的事件名称,这个事件要和后台商定好名字一样
    [self.bridge registerHandler:@"openCamera" handler:^(id data, WVJBResponseCallback responseCallback) {
        [self showQRReader:nil];
    }];
    
    
}


 

#pragma mark  扫描二维码
- (void)showQRReader:(id)sender {
    QRCScannerViewController *VC = [[QRCScannerViewController alloc] init];
    VC.delegate = self;
    self.title=@"扫码";
    [self.navigationController pushViewController:VC animated:YES];
}
#pragma mark - 扫描二维码完成后的代理方法
- (void)didFinshedScanning:(NSString *)result{
    
    
    /*不需要传参数,不需要后台返回执行结果
     [_bridge callHandler:@"paste_text"];
     */
    
    //callHandler 商定的事件名称,用来调用网页里面相应的事件实现,data id类型,传回去的参数
    [self.bridge callHandler:@"paste_text" data:result];
    
    /*需要传参数,带返回结果
     
     [_bridge callHandler:@"paste_text" data:result responseCallback:^(id responseData) {
     NSLog(@"后台执行完成后返回的数据");
     }];
     */
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
