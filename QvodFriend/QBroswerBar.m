//
//  QBroswerBar.m
//  QShake
//
//  Created by douzifly on 13-9-23.
//  Copyright (c) 2013年 douzifly. All rights reserved.
//

#import "QBroswerBar.h"
#import "UIColor+Hex.h"

@implementation QBroswerBar
{
    UIImageView *_backgroundImageView;
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
    _backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    [self addSubview:_backgroundImageView];
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
