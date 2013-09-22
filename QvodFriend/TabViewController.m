//
//  TabViewController.m
//  QShake
//
//  Created by douzifly on 13-9-21.
//  Copyright (c) 2013年 douzifly. All rights reserved.
//

#import "TabViewController.h"

@interface TabViewController ()

@end

@implementation TabViewController

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
    // image height 49px
    self.tabBar.backgroundImage = [UIImage imageNamed:@"bg_tabbar"];
    self.tabBar.selectionIndicatorImage = [UIImage imageNamed:@"bg_tabbar_indi"];
//    self.tabBar.barTintColor = [UIColor greenColor];
//    NSLog(@"tabBar height:%f, scale:%f", self.tabBar.frame.size.height, [[UIScreen mainScreen] scale]);
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
