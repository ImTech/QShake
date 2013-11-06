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

//- (id)initWithCoder:(NSCoder *)aDecoder
//{
//    self = [super initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
//    if (self) {
//        self.view.backgroundColor = [UIColor whiteColor];
//    }
//    return self;
//}
//
//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
//    if (self) {
//        // Custom initialization
//         self.view.backgroundColor = [UIColor whiteColor];
//    }
//    return self;
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self initPages];
    [self setAppreance];
}

- (void) setAppreance
{
    @try {
        UIPageControl *pageControl = [UIPageControl appearanceWhenContainedIn:[IntruduceViewController class], nil];
        pageControl.pageIndicatorTintColor = [UIColor grayColor];
        pageControl.currentPageIndicatorTintColor = [UIColor redColor];
        pageControl.backgroundColor = [UIColor whiteColor];
        [self.view setBackgroundColor:[UIColor whiteColor]];    }
    @catch (NSException *exception) {
    }
    @finally {
    }
   
}

-(void) initPages
{
    NSLog(@"initPages");
    _ds = [[IntruduceDataSource alloc] init];
    _ds.intruduceViewController = self;
    [self setViewControllers:[_ds fisrtController] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    self.dataSource = _ds;
    self.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void) showMainView
{
    //    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    //    TabViewController *main = [sb instantiateViewControllerWithIdentifier:@"tabcontroller"];
    //    [self.intruduceViewController performSegueWithIdentifier:@"tabsegue" sender:self.intruduceViewController];
    if ([self respondsToSelector:@selector(performSegueWithIdentifier:sender:)]) {
        [self performSegueWithIdentifier:@"main" sender:self];
    } else {
        NSLog(@"not support!!");
    }
    
}

- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray *)pendingViewControllers
{
    IntruducePageController *page = (pendingViewControllers[0]);
    NSLog(@"------pendingController index:%d", page.index);
    if (page.index == 3) {
        // end
        [self showMainView];
    }
}

@end
