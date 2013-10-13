//
//  HanldeTableView.m
//  QShake
//
//  Created by douzifly on 13-10-13.
//  Copyright (c) 2013年 douzifly. All rights reserved.
//

#import "HandleTableView.h"

@implementation HandleTableView
{
    NSUInteger _direction;
    UIImageView *_imageHandler;
    UIImageView *_imageHandlerArrow;
}

- (id) initWithCoder:(NSCoder *)aDecoder
{
    NSLog(@"----HandleTableViewinit------");
    self = [super initWithCoder:aDecoder];
    if(self) {
        [self initView];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initView];
    }
    return self;
}

- (void)initView
{
    _imageHandler = [[UIImageView alloc] init];
    _imageHandler.image = [UIImage imageNamed:@"handle_body"];
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleButtonClicked:)];
    recognizer.numberOfTapsRequired = 1;
    recognizer.numberOfTouchesRequired = 1;
    [_imageHandler addGestureRecognizer:recognizer];
    _imageHandler.userInteractionEnabled = YES;
    
    _imageHandlerArrow = [[UIImageView alloc] init];
    _imageHandlerArrow.image = [UIImage imageNamed:@"handle_arrow_down"];
    
    _tableView = [[UITableView alloc] init];
    
    [self addSubview:_imageHandler];
    [self addSubview:_tableView];
    [self addSubview:_imageHandlerArrow];
}

- (NSUInteger)getDirection
{
    return _direction;
}

- (void)setDirection:(NSUInteger)handleDriction
{
    _direction = handleDriction;
}

- (CGFloat)getHandleHeight
{
    return 22;
}

- (void)layoutSubviews {
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    NSLog(@"HandleTableView layoutSubviews w:%f, h:%f", width, height);
    _tableView.frame = CGRectMake(0, 0, width, height - 27);
    _imageHandler.frame = CGRectMake(0, height - 27, width, 27);
    _imageHandlerArrow.frame = CGRectMake(0, 0, 13, 7);
    _imageHandlerArrow.center = CGPointMake(_imageHandler.center.x, _imageHandler.center.y + 2);
}
- (void) handleButtonClicked:(UIImageView*) imageView
{
    NSLog(@"handle clicked");
    if([self.delegate respondsToSelector:@selector(handleClicked)]) {
        [self.delegate handleClicked];
    }
}

- (void) setHandleBackgourndColor:(UIColor *)color
{
    _imageHandler.backgroundColor = color;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
