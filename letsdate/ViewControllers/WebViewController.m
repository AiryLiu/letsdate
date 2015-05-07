//
//  WebViewController.m
//  LiCaiShi
//
//  Created by LCL on 14-3-17.
//  Copyright (c) 2014年 9888. All rights reserved.
//

#import "WebViewController.h"

#import "AppDelegate.h"

@interface WebViewController () <UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;

@end

@implementation WebViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _webView = [[UIWebView alloc] init];
        _webView.delegate = self;
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    
    CGRect frame = self.view.bounds;
//    frame.size.height -= NAVIGATIONBAR_HEIGHT+(IOS7_OR_LATER?STATUSBAR_HEIGHT:0);
    
    _webView.frame = frame;
    [self.view addSubview:_webView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self reloadRequest];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onBecomeActive) name:UIApplicationDidBecomeActiveNotification object:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];

}

- (void)onBecomeActive
{
    if ([self.title isEqualToString:@"红包详情"]) {
        // 红包详情页每次出现时刷新页面
        [self reloadRequest];
    }
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)reloadRequest
{
    if(self.url){
#if FP_DEBUG
        NSLog(@"webview get url %@", self.url);
#endif
        NSURL* loadingURL =[NSURL URLWithString:self.url];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:loadingURL];

        if (self.method) {
            [request setHTTPMethod:self.method];
        }
        else {
            [request setHTTPMethod:@"GET"];
        }
        
        if ([self.method isEqualToString:@"POST"] && self.postBody) {
            [request setHTTPBody:[self.postBody dataUsingEncoding:NSUTF8StringEncoding]];
        }
        
        request.cachePolicy = NSURLRequestReloadIgnoringCacheData;
        
        [request addValue:@"iOS" forHTTPHeaderField:@"OS"];
        [request addValue:@"1.0.0" forHTTPHeaderField:@"VERSION"];
        NSString *channel = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"Channel"];
        [request addValue:channel forHTTPHeaderField:@"CHANNEL"];
        
        [_webView loadRequest:request];
    }
}

- (void)setDataDetectorTypes:(UIDataDetectorTypes)type
{
    _webView.dataDetectorTypes = type;
}

- (UIDataDetectorTypes)getDataDetectorTypes
{
    return _webView.dataDetectorTypes;
}

- (void)goBack:(id)sender
{
    if (self.navigationController.topViewController == self) {
        if (self.navigationController.viewControllers.count>1) {
            [self.navigationController popViewControllerAnimated:YES];
        }else{

        }
    }
}

#pragma mark - WebViewDelegate

- (void)webViewDidStartLoad:(UIWebView *)webView
{

}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{

}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{


//    if ([HandleNetError isConnectionFailureError:error.code]) {
//        [[HandleNetError getInstance] handleErrorCode:ASIConnectionFailureErrorType];
//    }
//    else if (error.code == NSURLErrorTimedOut) {
//        [[HandleNetError getInstance] handleErrorCode:ASIRequestTimedOutErrorType];
//    }
//    else if (error.code == NSURLErrorCancelled) {
//        // 页面未被完全加载之前收到下一个请求 不提示
//    }
//    else {
//        [[HandleNetError getInstance] handleErrorCode:kFPUnknownErrorCode];
//    }
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    if (navigationType == UIWebViewNavigationTypeLinkClicked) {
        NSString *url = request.URL.absoluteString;
        if([url hasPrefix:@"bonus"]){
            return NO;
        }
        else{
            return YES;
        }        
    }else{
        return YES;
    }
}

@end
