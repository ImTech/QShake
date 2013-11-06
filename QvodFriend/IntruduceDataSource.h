//
//  IntruduceDataSource.h
//  QShake
//
//  Created by douzifly on 13-11-4.
//  Copyright (c) 2013年 douzifly. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IntruducePageController.h"
#import "IntruduceViewController.h"

@interface IntruduceDataSource : NSObject <UIPageViewControllerDataSource,
                                    IntruducePageControllerDelegate>

- (NSArray *) fisrtController;
@property (weak) IntruduceViewController* intruduceViewController;
@end
