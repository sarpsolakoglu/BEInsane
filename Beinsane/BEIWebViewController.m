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
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_urlString]];
    
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    
    _progressView.progress = 0.0f;
    
    self.webView = [[WKWebView alloc] initWithFrame:self.view.frame configuration:configuration];
    
    [self.webView loadRequest:request];
    [self.view insertSubview:self.webView belowSubview:_progressView];
    
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:NULL];
}

- (void)dealloc {
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"estimatedProgress"] && object == self.webView) {
        float progress = self.webView.estimatedProgress;
        if (progress == 1.0) {
            self.progressView.hidden = YES;
        } else {
            self.progressView.hidden = NO;
        }
        self.progressView.progress = progress;
    }
    else {
        // Make sure to call the superclass's implementation in the else block in case it is also implementing KVO
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}


- (IBAction)goBack:(id)sender {
    if ([_webView canGoBack]) {
        [_webView goBack];
    }
}
- (IBAction)goForward:(id)sender {
    if ([_webView canGoForward]) {
        [_webView goForward];
    }
}

@end
