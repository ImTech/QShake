//
//  IntruduceViewController.m
//  QShake
//
//  Created by douzifly on 13-11-4.
//  Copyright (c) 2013年 douzifly. All rights reserved.
//

#import "IntruduceViewController.h"
#import "IntruduceDataSource.h"

@interface IntruduceViewController ()

@end

@implementation IntruduceViewController
{
    IntruduceDataSource *_ds;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    if (self) {
    }
    return self;
}

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
    [self initPages];
    [self setAppreance];
}

- (void) setAppreance
{
    UIPageControl *pageControl = [UIPageControl appearanceWhenContainedIn:[IntruduceViewController class], nil];
    pageControl.pageIndicatorTintColor = [UIColor grayColor];
    pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    pageControl.backgroundColor = [UIColor whiteColor];
}

-(void) initPages
{
    NSLog(@"initPages");
    _ds = [[IntruduceDataSource alloc] init];
    [self setViewControllers:[_ds fisrtController] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    self.dataSource = _ds;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
