//
//  BrowserViewController.m
//  QShake
//
//  Created by douzifly on 13-9-21.
//  Copyright (c) 2013年 douzifly. All rights reserved.
//

#import "BrowserViewController.h"
#import "UIColor+Hex.h"

@interface BrowserViewController ()

@end

@implementation BrowserViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"a_09"] withFinishedUnselectedImage:[UIImage imageNamed:@"a_09"]];
    [self.tabBarItem setImage:[UIImage imageNamed:@"a_09"]];
    [self.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithHex:@"#929292"], UITextAttributeTextColor, nil] forState:UIControlStateNormal];
    
    [self.view setBackgroundColor:[UIColor colorWithHex:@"#E4E7EB"]];
//    self.view.backgroundColor = [UIColor colorWithHex:@"#19759c"];
//    [self.toolBar setBackgroundColor:[UIColor colorWithHex:@"#19759c"]];
    self.toolBar.backgroundImage = [[UIImage imageNamed:@"a_02"] stretchableImageWithLeftCapWidth:10 topCapHeight:10];
    _toolBar.backgroundColor = [UIColor blackColor];
    self.toolBar.delegate = self;
    self.webView.delegate = self;
    
    self.progressBar.hidden = YES;
    
    [self calcWebViewHeight];
    [self loadHomePage];
}

-(void) calcWebViewHeight {
    float screenHeight = [[UIScreen mainScreen] bounds].size.height;
    float tableHeight = screenHeight - 20 - 44 - 49;
    NSLog(@"webViewHeight:%f screenHeight:%f", tableHeight, screenHeight);
    CGRect rect = self.webView.frame;
    self.webView.frame = CGRectMake(rect.origin.x, rect.origin.y, [[UIScreen mainScreen] bounds].size.width, tableHeight);
    [self.webView layoutIfNeeded];
}

-(void) loadHomePage {
//    NSString *urlStr = @"http://m.tv.sohu.com/";
    NSString *urlStr = @"http://dzvideo1.sinaapp.com";
    [self loadUrl:urlStr];
}

- (void) loadUrl:(NSString *) urlStr
{
    if(![urlStr hasPrefix:@"http://"]) {
        urlStr = [NSString stringWithFormat:@"http://%@", urlStr];
    }
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:req];
    self.toolBar.url = urlStr;
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    self.toolBar.url = [request.URL absoluteString];
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    self.progressBar.hidden = NO;
    self.progressBar.progress = 0;
}


- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.progressBar.hidden = YES;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    self.progressBar.hidden = YES;
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    NSString *url = self.toolBar.url;
    NSLog(@"Controller textReturn url:%@", url);
    [self loadUrl:url];
    // hide keyboard
    [self.view endEditing:YES];
    [self.webView resignFirstResponder];
    return YES;
}

- (void) backClicked {
    NSLog(@"Controller backClicked");
    [self.webView goBack];
}

- (void) homeClicked
{
    NSLog(@"Contrller homeClicked");
    [self loadHomePage];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)prefersStatusBarHidden {
    return NO;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end
