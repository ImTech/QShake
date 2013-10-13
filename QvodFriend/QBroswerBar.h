//
//  QBroswerBar.h
//  QShake
//
//  Created by douzifly on 13-9-23.
//  Copyright (c) 2013年 douzifly. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QBroswerBarDelegate.h"

@interface QBroswerBar : UIView <UITextFieldDelegate>
@property(strong, nonatomic, getter = getBackgroundImage, setter = setBackgroundImage:) UIImage *backgroundImage;
@property(strong, nonatomic, setter = setUrl:, getter = getUrl) NSString *url;
@property(strong, nonatomic) id<UITextFieldDelegate, QBroswerBarDelegate> delegate;
- (void) setBackgroundImage:(UIImage *)backgroundImage;
- (UIImage*) getBackgroundImage;
- (void) setUrl:(NSString *) url;
- (NSString*) getUrl;
@end
