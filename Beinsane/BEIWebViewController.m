//
//  BEIWebViewController.m
//  Beinsane
//
//  Created by Sarp Ogulcan Solakoglu on 07/03/15.
//  Copyright (c) 2015 nodious. All rights reserved.
//

#import "BEIWebViewController.h"

@interface BEIWebViewController ()
@property (nonatomic,strong) WKWebView *webView;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@end

@implementation BEIWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _progressView.progress = 0.0f;
    
    //Create request
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_urlString]];
    //Create WKWebView
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    self.webView = [[WKWebView alloc] initWithFrame:self.view.frame configuration:configuration];
    //Make initial request
    [self.webView loadRequest:request];
    //Add to view
    [self.view insertSubview:self.webView belowSubview:_progressView];
    //add observer
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:NULL];
}

- (void)dealloc {
    //remove observer
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
}

//KVO for estimatedProgress
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"estimatedProgress"] && object == self.webView) {
        //Change our progress view according to progress
        float progress = self.webView.estimatedProgress;
        if (progress == 1.0) {
            self.progressView.hidden = YES;
        } else {
            self.progressView.hidden = NO;
        }
        self.progressView.progress = progress;
    }
    else {
        //call superclass KVO
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

//go to prev page if available
- (IBAction)goBack:(id)sender {
    if ([_webView canGoBack]) {
        [_webView goBack];
    }
}

//go to next page if available
- (IBAction)goForward:(id)sender {
    if ([_webView canGoForward]) {
        [_webView goForward];
    }
}

@end
