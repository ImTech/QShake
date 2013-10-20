//
//  ShakeImageView.m
//  QvodFriend
//
//  Created by douzifly on 13-9-8.
//  Copyright (c) 2013年 douzifly. All rights reserved.
//

#import "ShakeImageView.h"

@implementation ShakeImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if(event.subtype == UIEventSubtypeMotionShake) {
        NSLog(@"shaked");
        if([self.delegate respondsToSelector:@selector(shakeImageViewShaked:)]) {
            [self.delegate shakeImageViewShaked:self];
        }
    }
//
    if ([super respondsToSelector:@selector(motionEnded:withEvent:)]) {
        [super motionEnded:motion withEvent:event];
    }
}

-(BOOL)canBecomeFirstResponder {
    return YES;
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
