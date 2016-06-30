//
//  ViewController.m
//  iOSWithJsInteraction
//
//  Created by vstyle on 16/6/15.
//  Copyright © 2016年 cn.vstyle. All rights reserved.
//

#import "ViewController.h"
#import "JavaScriptObject.h"

@interface ViewController ()<UIWebViewDelegate>
@property (nonatomic, strong)UIWebView *myWebView;
@property (nonatomic, strong)JavaScriptObject *javaScriptObj;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _myWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    _myWebView.delegate = self;
    [self.view addSubview:_myWebView];
    //测试网址（本地HTML文件）
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *resPath = [bundle resourcePath];
    NSString *filePath = [resPath stringByAppendingPathComponent:@"test.html"];
    [_myWebView loadHTMLString:[NSString stringWithContentsOfFile:filePath] baseURL:[NSURL fileURLWithPath:[bundle bundlePath]]];
}
- (void)webViewDidStartLoad:(UIWebView *)webView {
    
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    JSContext *context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    _javaScriptObj = [[JavaScriptObject alloc] init];
    context[@"iOS"] = _javaScriptObj;

    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
