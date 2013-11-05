//
//  IntruducePageController.h
//  QShake
//
//  Created by douzifly on 13-11-4.
//  Copyright (c) 2013年 douzifly. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IntruducePageController;
@protocol IntruducePageControllerDelegate <NSObject>
@optional
- (void) intruducePageControllerViewDidload:(IntruducePageController *) controller;
- (void) intruducePageControllerButtonClicked:(IntruducePageController *) controller;
@end

@interface IntruducePageController : UIViewController

@property (nonatomic) NSArray* controllers;
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic) NSUInteger index;
- (IBAction)touchUpInside:(id)sender;
@property id<IntruducePageControllerDelegate> delegate;
@end
