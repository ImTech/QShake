//
//  QBroswerBar.m
//  QShake
//
//  Created by douzifly on 13-9-23.
//  Copyright (c) 2013年 douzifly. All rights reserved.
//

#import "QBroswerBar.h"
#import "UIColor+Hex.h"
#import "UITextField+Padding.h"

@implementation QBroswerBar
{
    UIImageView *_backgroundImageView;
    UITextField *_textFieldUrl;
    UIButton    *_btnBack;
    UIButton    *_btnHome;
}

- (id) initWithCoder:(NSCoder *)aDecoder
{
    NSLog(@"initWithCoder");
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initViews:self.frame];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    NSLog(@"frame:%f, %f", frame.size.width, frame.size.height);
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initViews:frame];
    }
    return self;
}

- (void) initViews:(CGRect) frame
{
    // backgournd
    _backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    [self addSubview:_backgroundImageView];
    
    // button back
    _btnBack = [UIButton buttonWithType:UIButtonTypeCustom];
    _btnBack.frame = CGRectMake(0, 0, 40, 40);
    _btnBack.center = CGPointMake(21, 22);
    [_btnBack imageView].contentMode = UIViewContentModeScaleAspectFit;
    [_btnBack setImage:[UIImage imageNamed:@"bg_back"] forState:UIControlStateNormal];
    [self addSubview:_btnBack];
    [_btnBack addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    // text url
    _textFieldUrl = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 232, 29)];
    _textFieldUrl.center = CGPointMake(160, 22);
    _textFieldUrl.background = [UIImage imageNamed:@"bgTxtUrl"];
    _textFieldUrl.text = @"douzifly";
    _textFieldUrl.textColor = [UIColor colorWithHex:@"#6F6F6f"];
    _textFieldUrl.returnKeyType = UIReturnKeyGo;
    _textFieldUrl.keyboardType = UIKeyboardTypeURL;
    _textFieldUrl.delegate = self;
//    [_textFieldUrl becomeFirstResponder];
    
    [self addSubview:_textFieldUrl];
    
    // button home
    _btnHome = [UIButton buttonWithType:UIButtonTypeCustom];
    [_btnHome imageView].contentMode = UIViewContentModeScaleAspectFit;
    [_btnHome setImage:[UIImage imageNamed:@"bg_home"] forState:UIControlStateNormal];
    _btnHome.frame = CGRectMake(0, 0, 40, 40);
    _btnHome.center = CGPointMake(300, 22);
    [_btnHome addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_btnHome];
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

- (void)setUrl:(NSString *)url
{
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
