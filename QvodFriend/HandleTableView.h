//
//  HanldeTableView.h
//  QShake
//
//  Created by douzifly on 13-10-13.
//  Copyright (c) 2013年 douzifly. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NSUInteger HandleArrowDirection;
enum {
    HandleArrowDirectionUp,
    HandleArrowDirectionDown
};

@protocol HandleTableViewDelgate <NSObject>

@optional
- (void) handleClicked;
- (void) handleBeginMove;
- (void) handleEndMove;
- (void) handleMoving:(CGPoint) point;

@end

@interface HandleTableView : UIControl
@property (readonly, strong, nonatomic) UITableView *tableView;
@property (nonatomic, getter = getDirection, setter = setDirection:) NSUInteger handleDriction;
@property (nonatomic) id<HandleTableViewDelgate> delegate;
@property (nonatomic, readonly, getter = getHandleHeight) CGFloat handleHeight;
- (void) setDirection:(NSUInteger) direction;
- (NSUInteger) getDirection;
- (CGFloat) getHandleHeight;
- (void) setHandleBackgourndColor:(UIColor*) color;
@end
