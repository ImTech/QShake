//
//  YoumiHelper.m
//  QShake
//
//  Created by douzifly on 13-12-3.
//  Copyright (c) 2013年 douzifly. All rights reserved.
//

#import "YoumiHelper.h"
#import "YouMiView.h"

@implementation YoumiHelper

+ (UIView *)createAdView
{
    // 创建广告条
    YouMiView* adView = [[YouMiView alloc] initWithContentSizeIdentifier:YouMiBannerContentSizeIdentifier320x50 delegate:nil];
    
    //可以设置委托[可选]
    //    adView.delegate = self;
    //设置文字广告的属性[可选]
    adView.indicateTranslucency = YES;
    adView.indicateRounded = NO;
    //添加对应的关键词 [可选]
    //    [adView addKeyword:@"女性"];
    
    // 开始请求广告
    [adView start];
    return adView;
}

@end
