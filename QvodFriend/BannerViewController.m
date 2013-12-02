//
//  BannerViewController.m
//  QShake
//
//  Created by douzifly on 13-11-19.
//  Copyright (c) 2013年 douzifly. All rights reserved.
//

#import "BannerViewController.h"
#import "Setting.h"

@interface BannerViewController ()

@end

@implementation BannerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) chooseFirstViewController
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    NSString *storyid = nil;
    if ([Setting showIntruduce]) {
        storyid = @"intro"; // @"tabmain"
        [Setting setShowIntruduce:NO];
    } else {
        storyid = @"tabmain";
    }
    // for debug
//    storyid = @"intro";
    UIViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:storyid];
    self.view.window.rootViewController = viewController;
    [self.view.window makeKeyAndVisible];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self performSelector:@selector(timeup) withObject:nil afterDelay:2];
}

- (void)timeup
{
    NSLog(@"choose");
    [self chooseFirstViewController];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
