//
//  IntruduceDataSource.m
//  QShake
//
//  Created by douzifly on 13-11-4.
//  Copyright (c) 2013年 douzifly. All rights reserved.
//

#import "IntruduceDataSource.h"
#import "IntruducePageController.h"
#import "TabViewController.h"

@implementation IntruduceDataSource
{
    NSMutableArray *_childs;
}

- (id)init
{
    self = [super init];
    if (self != nil) {
        [self initPages];
    }
    return self;
}

- (void) initPages
{
    _childs = [[NSMutableArray alloc] init];
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    IntruducePageController *page = [sb instantiateViewControllerWithIdentifier:@"intruduce_page"];
    page.index = 0;
    page.delegate = self;
    [_childs addObject:page];
    page = [sb instantiateViewControllerWithIdentifier:@"intruduce_page"];
    page.index = 1;
    page.delegate = self;
    [_childs addObject:page];
    page = [sb instantiateViewControllerWithIdentifier:@"intruduce_page"];
    page.index = 2;
    page.delegate = self;
    [_childs addObject:page];
    // place holder
    page = [sb instantiateViewControllerWithIdentifier:@"intruduce_page"];
    page.index = 3;
    page.delegate = self;
    [_childs addObject:page];
}

- (void)intruducePageControllerButtonClicked:(IntruducePageController *)controller
{
//    [self.intruduceViewController dismissModalViewControllerAnimated:YES];
    
    [self showMainView];
}

- (void) showMainView
{
//    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
//    TabViewController *main = [sb instantiateViewControllerWithIdentifier:@"tabcontroller"];
//    [self.intruduceViewController performSegueWithIdentifier:@"tabsegue" sender:self.intruduceViewController];
    if ([self.intruduceViewController respondsToSelector:@selector(performSegueWithIdentifier:sender:)]) {
        [self.intruduceViewController performSegueWithIdentifier:@"main" sender:self];
    } else {
        NSLog(@"not support!!");
    }
    
}

- (void) intruducePageControllerViewDidload:(IntruducePageController *)controller
{
    NSString* imageName = [NSString stringWithFormat:@"intro%d", controller.index + 1];
//    if (controller.index != [_childs count] -1) {
//        controller.button.hidden = YES;
//    } else {
//        [controller.button setTitle:@"开始吧" forState:UIControlStateNormal];
//    }
    if (controller.index == 3) {
        // placeholder
        controller.button.hidden = YES;
        controller.imageView.hidden = YES;
        return;
    }
    
    controller.button.hidden = YES;
    controller.imageView.image = [UIImage imageNamed:imageName];
}

- (NSArray *)fisrtController
{
    return [NSArray arrayWithObjects:[_childs objectAtIndex:0], nil];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSLog(@"beofre");
    NSInteger _index = ((IntruducePageController *)viewController).index;
    if (_index == 0) {
        return nil;
    }
    _index --;
    
    UIViewController *prev = [_childs objectAtIndex:_index];
    return prev;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSLog(@"after");
    NSInteger _index = ((IntruducePageController *)viewController).index;
    if (_index == [_childs count] - 1) {
        return nil;
    }
    _index ++;
    UIViewController* next = [_childs objectAtIndex:_index];
    NSLog(@"current:%@, next:%@", viewController, next);
    return next;
}

// for indicator
//- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
//{
//    return [_childs count];
//}
//
//- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
//{
//    return 0;
//}

@end
