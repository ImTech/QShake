//
//  IntruduceDataSource.h
//  QShake
//
//  Created by douzifly on 13-11-4.
//  Copyright (c) 2013年 douzifly. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IntruducePageController.h"

@interface IntruduceDataSource : NSObject <UIPageViewControllerDataSource, UIPageViewControllerDelegate,
                                    IntruducePageControllerDelegate>

- (NSArray *) fisrtController;

@end
