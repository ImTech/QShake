//
//  QBroswerBar.h
//  QShake
//
//  Created by douzifly on 13-9-23.
//  Copyright (c) 2013年 douzifly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QBroswerBar : UIView
@property(strong, nonatomic, setter = setBackgroundImage:) UIImage *backgroundImage;
- (void) setBackgroundImage:(UIImage *)backgroundImage;
@end
