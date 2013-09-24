//
//  UITextFiled+Padding.m
//  QShake
//
//  Created by douzifly on 13-9-25.
//  Copyright (c) 2013年 douzifly. All rights reserved.
//

#import "UITextField+Padding.h"

@implementation UITextField(Padding)
- (CGRect)textRectForBounds:(CGRect)bounds
{
     return CGRectInset(bounds, 10.0f, 0);
}

- (CGRect)editingRectForBounds:(CGRect)bounds
{
    return CGRectInset(bounds, 10.0f, 0);
}
@end
