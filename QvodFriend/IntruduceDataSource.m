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
    NSMutableArray *_pages;
}

- (id)init
{
    self = [super init];
    if (self != nil) {
        _pages = [[NSMutableArray alloc] init];
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
        IntruducePageController *page = [sb instantiateViewControllerWithIdentifier:@"intruduce_page"];
        [_pages addObject:page];
    }
    return self;
}

- (NSArray *)controllers
{
    return [NSArray arrayWithArray:_pages];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    return  [_pages objectAtIndex:0];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    return [_pages objectAtIndex:0];
}

@end
