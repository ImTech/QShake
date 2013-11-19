//
//  TabViewController.m
//  QShake
//
//  Created by douzifly on 13-9-21.
//  Copyright (c) 2013年 douzifly. All rights reserved.
//

#import "TabViewController.h"
#import "UIColor+Hex.h"
#import "AppDelegate.h"

@interface TabViewController ()

@end

@implementation TabViewController
{
    BOOL _hackedStatusbar;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) statusBarHack
{
    if (_hackedStatusbar) return;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        UIView *addStatusBar = [[UIView alloc] init];
        addStatusBar.frame = CGRectMake(0, 0, self.view.window.frame.size.width, 20);
        addStatusBar.bounds = CGRectMake(0, 0, self.view.window.frame.size.width, 20);
        addStatusBar.backgroundColor = [UIColor blackColor]; //change this to match your navigation bar
        [self.view addSubview:addStatusBar];
        [self.view setNeedsLayout];
        [self.view updateConstraints];
        _hackedStatusbar = YES;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    // image height 49px
    self.tabBar.backgroundImage = [UIImage imageNamed:@"bg_tabbar"];
    self.tabBar.selectionIndicatorImage = [UIImage imageNamed:@"bg_tabbar_indi"];
//    [self statusBarHack];
}


- (void) viewDidAppear:(BOOL)animated {
//    [self statusBarHack];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotate {
    return NO;
}



@end
