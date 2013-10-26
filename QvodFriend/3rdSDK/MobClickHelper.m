//
//  MobClickHelper.m
//  QShake
//
//  Created by douzifly on 13-10-26.
//  Copyright (c) 2013年 douzifly. All rights reserved.
//

#import "MobClickHelper.h"
#import "MobClick.h"

@implementation MobClickHelper
+ (void)logShake
{
    [MobClick event:@"shake"];
}

@end
