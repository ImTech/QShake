//
//  IntruducePageController.m
//  QShake
//
//  Created by douzifly on 13-11-4.
//  Copyright (c) 2013年 douzifly. All rights reserved.
//

#import "IntruducePageController.h"

@interface IntruducePageController ()

@end

@implementation IntruducePageController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    if ([self.delegate respondsToSelector:@selector(intruducePageControllerViewDidload:)]) {
        [self.delegate intruducePageControllerViewDidload:self];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)touchUpInside:(id)sender {
    if ([self.delegate respondsToSelector:@selector(intruducePageControllerButtonClicked:)]) {
        [self.delegate intruducePageControllerButtonClicked:self];
    }
}
@end
