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

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"a_09"] withFinishedUnselectedImage:[UIImage imageNamed:@"a_09"]];
    [self.tabBarItem setImage:[UIImage imageNamed:@"a_09"]];
    [self.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithHex:@"#929292"], UITextAttributeTextColor, nil] forState:UIControlStateNormal];
    
    [self.view setBackgroundColor:[UIColor colorWithHex:@"#E4E7EB"]];
    
    [self.navigationBar setBarTintColor:[UIColor colorWithHex:@"#19759c"]];
    self.navigationBar.translucent = NO;
    [self loadHomePage];
}

-(void) loadHomePage {
    NSString *urlStr = @"http://m.tv.sohu.com/";
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:req];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
