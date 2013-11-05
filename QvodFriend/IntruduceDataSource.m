//
//  IntruduceDataSource.m
//  QShake
//
//  Created by douzifly on 13-11-4.
//  Copyright (c) 2013年 douzifly. All rights reserved.
//

#import "IntruduceDataSource.h"
#import "IntruducePageController.h"

@implementation IntruduceDataSource
{
    NSMutableArray *_childs;
}

- (id)init
{
    self = [super init];
    if (self != nil) {
        _childs = [[NSMutableArray alloc] init];
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
        IntruducePageController *page = [sb instantiateViewControllerWithIdentifier:@"intruduce_page"];
        page.index = 0;
        [_childs addObject:page];
        page = [sb instantiateViewControllerWithIdentifier:@"intruduce_page"];
        page.index = 1;
        [_childs addObject:page];
//        page = [sb instantiateViewControllerWithIdentifier:@"intruduce_page"];
//        [_pages addObject:page];
    }
    return self;
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
    NSLog(@"current:%@, prev:%@", viewController, prev);
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

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return [_childs count];
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    return 0;
}

@end
