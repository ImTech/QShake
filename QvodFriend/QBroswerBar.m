//
//  QBroswerBar.m
//  QShake
//
//  Created by douzifly on 13-9-23.
//  Copyright (c) 2013年 douzifly. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "QBroswerBar.h"
#import "UIColor+Hex.h"
#import "MyUITextField.h"

@implementation QBroswerBar
{
    UIImageView *_backgroundImageView;
    UITextField *_textFieldUrl;
    UIButton    *_btnBack;
    UIButton    *_btnHome;
    UIButton    *_btnRefresh;
    UIButton    *_btnClearText;
}

- (id) initWithCoder:(NSCoder *)aDecoder
{
    NSLog(@"initWithCoder");
    self = [super initWithCoder:aDecoder];
    if (self) {
        CGRect f = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.frame.size.height );
        [self initViews:f];
    }
    return self;
}


- (void) initViews:(CGRect) frame
{
    // backgournd
    NSLog(@"initView frame:%f, %f", frame.size.width, frame.size.height);
    _backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 44)];
    [self addSubview:_backgroundImageView];
    
    // button back
    _btnBack = [UIButton buttonWithType:UIButtonTypeCustom];
    _btnBack.frame = CGRectMake(0, 0, 40, 40);
    _btnBack.center = CGPointMake(21, 22);
    [_btnBack imageView].contentMode = UIViewContentModeScaleAspectFit;
    [_btnBack setImage:[UIImage imageNamed:@"bg_back"] forState:UIControlStateNormal];
    [self addSubview:_btnBack];
    [_btnBack addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    // button refresh
    _btnRefresh = [UIButton buttonWithType:UIButtonTypeCustom];
    [_btnRefresh imageView].contentMode = UIViewContentModeScaleAspectFit;
    [_btnRefresh setImage:[UIImage imageNamed:@"frs"] forState:UIControlStateNormal];
    _btnRefresh.frame = CGRectMake(0, 0, 40, 40);
    _btnRefresh.center = CGPointMake(frame.size.width - 50 , 22);
    [_btnRefresh addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_btnRefresh];
    
    // button home
    _btnHome = [UIButton buttonWithType:UIButtonTypeCustom];
    [_btnHome imageView].contentMode = UIViewContentModeScaleAspectFit;
    [_btnHome setImage:[UIImage imageNamed:@"bg_home"] forState:UIControlStateNormal];
    _btnHome.frame = CGRectMake(0, 0, 40, 40);
    _btnHome.center = CGPointMake(frame.size.width - 20, 22);
    [_btnHome addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_btnHome];
    
    // text url
    _textFieldUrl = [[MyUITextField alloc] initWithFrame:CGRectMake(0, 0, frame.size.width - 106, 29)];
    _textFieldUrl.center = CGPointMake(frame.size.width / 2 - 14, 22);
//    _textFieldUrl.background = [UIImage imageNamed:@"bgTxtUrl"];
//    _textFieldUrl.backgroundColor = [UIColor whiteColor];
    _textFieldUrl.borderStyle = UITextBorderStyleNone;
    _textFieldUrl.layer.cornerRadius = 2.0f;
//    _textFieldUrl.layer.borderColor = [[UIColor grayColor] CGColor];
//    _textFieldUrl.layer.borderWidth = 0.6f;
    _textFieldUrl.layer.masksToBounds = YES;
    _textFieldUrl.backgroundColor = [UIColor whiteColor];
    _textFieldUrl.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _textFieldUrl.text = @"douzifly";
    _textFieldUrl.textColor = [UIColor colorWithHex:@"#6F6F6f"];
    _textFieldUrl.returnKeyType = UIReturnKeyGo;
    _textFieldUrl.keyboardType = UIKeyboardTypeURL;
    _textFieldUrl.delegate = self;
//    [_textFieldUrl becomeFirstResponder];
    
    [self addSubview:_textFieldUrl];
    
    
    // button clearText
    _btnClearText = [UIButton buttonWithType:UIButtonTypeCustom];
    [_btnClearText imageView].contentMode = UIViewContentModeScaleAspectFit;
    [_btnClearText setImage:[UIImage imageNamed:@"clear"] forState:UIControlStateNormal];
    _btnClearText.frame = CGRectMake(0, 0, 35, 35);
//      _btnRefresh.center = CGPointMake(frame.size.width - 65 , 22);
    [_btnClearText addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
//    [self addSubview:_btnClearText];
    _textFieldUrl.rightView = _btnClearText;
    _textFieldUrl.rightViewMode = UITextFieldViewModeWhileEditing;
}

- (void) buttonClicked:(UIButton *) button
{
    NSLog(@"buttonClicked %@", button);
    if(button == _btnBack) {
        if([self.delegate respondsToSelector:@selector(backClicked)]) {
            [self.delegate backClicked];
        }
    } else if(button == _btnHome) {
        if([self.delegate respondsToSelector:@selector(homeClicked)]) {
            [self.delegate homeClicked];
        }
    } else if(button == _btnRefresh) {
        if([self.delegate respondsToSelector:@selector(refreshClicked)]) {
            [self.delegate refreshClicked];
        }
    } else if(button == _btnClearText) {
        _textFieldUrl.text = @"";
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"text return");
    if([self.delegate respondsToSelector:@selector(textFieldShouldReturn:)]) {
        [self.delegate textFieldShouldReturn:textField];
        return YES;
    }
    return NO;
}

- (void)setBackgroundImage:(UIImage *)image
{
    NSLog(@"QBroswerBar setBackgroundImage:%@", image);
    if(image != nil) {
        _backgroundImageView.image = image;
        CGRect rect = _backgroundImageView.frame;
        NSLog(@"QBroswerBar frame:%f, %f", rect.size.width, rect.size.height);
    }
}

- (UIImage *)getBackgroundImage
{
    return _backgroundImageView.image;
}

- (void)setUrl:(NSString *)url
{
    NSLog(@"url:%@, home:%@", url, self.homeUrl);
    if ([url rangeOfString:self.homeUrl].location != NSNotFound) {
        url = @"加载中...";
    }
    _textFieldUrl.text = url;
}

- (NSString *) getUrl
{
    return  _textFieldUrl.text;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
//    NSLog(@"draw rect");
    [super drawRect:rect];
//    CGRect rectangle = CGRectMake(0, 0, 320, 44);
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextSetRGBFillColor(context, 1.0, 0.0, 0.0, 1.0);
//    CGContextSetRGBStrokeColor(context, 1.0, 0.0, 0.0, 1.0);
//    CGContextFillRect(context, rectangle);
}


@end
