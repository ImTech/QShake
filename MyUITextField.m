//
//  MyUITextField.m
//  QShake
//
//  Created by douzifly on 13-10-27.
//  Copyright (c) 2013年 douzifly. All rights reserved.
//

#import "MyUITextField.h"

@implementation MyUITextField
{
    NSInteger _setupClearButtonMode;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _setupClearButtonMode = UITextFieldViewModeWhileEditing;
    }
    return self;
}

- (CGRect)textRectForBounds:(CGRect)bounds
{
    return CGRectInset(bounds, 10.0f, 0);
}

- (CGRect)editingRectForBounds:(CGRect)bounds
{
    return CGRectInset(bounds, 10.0f, 0);
}

- (void)setRightViewMode:(UITextFieldViewMode)rightViewMode
{
    [super setRightViewMode:rightViewMode];
}

- (BOOL)becomeFirstResponder
{
    BOOL ret = YES ;
    
    ret = [super becomeFirstResponder] ;
    
    if( ret && ( _setupClearButtonMode == UITextFieldViewModeWhileEditing ) )
        self.rightViewMode = UITextFieldViewModeAlways ;
    
    return ret ;
}

- (BOOL)resignFirstResponder
{
    BOOL ret = YES ;
    
    ret = [super resignFirstResponder] ;
    
    if( ret && ( _setupClearButtonMode == UITextFieldViewModeWhileEditing ) )
        self.rightViewMode = UITextFieldViewModeWhileEditing ;
    
    return ret ;
}

@end
