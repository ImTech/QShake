//
//  FirstViewController.m
//  QvodFriend
//
//  Created by douzifly on 13-8-15.
//  Copyright (c) 2013年 douzifly. All rights reserved.
//

#import "FirstViewController.h"
#import "Download/ResouceApi.h"
#import "SBJson.h"
#import "DataTableContrller.h"
#import "SoundUtil.h"

#define ANIM_SHAKE_COUNT 5
#define ANIM_SHAKE_KEY  @"ICON_SHAKE"

typedef NSUInteger DiaplayType;

enum {
    DisplayTypeShake,
    DisplayTypeDataList
};

@interface FirstViewController ()
{
    BOOL _isLodingData;
}
@property(strong, nonatomic) DataTableContrller *dataTableController;
@end
@implementation FirstViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.dataTableController = [[DataTableContrller alloc] init];
    self.dataTableController.tableView = self.dataTable;
    [self.imgShake setImage:[UIImage imageNamed:@"shake.png"]];
    self.imgShake.delegate = self;
    [self shakeImage:_imgShake withRepeatCount:ANIM_SHAKE_COUNT];
    [self setDisplayType:DisplayTypeShake];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.imgShake becomeFirstResponder];
    [super viewWillAppear:animated];
}

-(void) shakeImageViewShaked:(ShakeImageView *)imageView
{
    if(_isLodingData) {
        NSLog(@"loading");
        return;
    }
    [self setDisplayType:DisplayTypeShake];
    [self shakeImage:imageView withRepeatCount:NSUIntegerMax];
    [SoundUtil playShakeSound:ShakeSoundStyleBegin];
    [self beginLoadData];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.imgShake resignFirstResponder];
    [super viewWillDisappear:animated];
}

- (void) shakeImage:(UIImageView *) img withRepeatCount:(NSUInteger) count
{
    NSLog(@"shake anim count:%d", count);
    CABasicAnimation* anim = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    [anim setToValue:[NSNumber numberWithFloat:0.0f]];
    [anim setFromValue:[NSNumber numberWithFloat:M_PI/ 16]];
    [anim setDuration:0.1];
    [anim setRepeatCount:count];
    [anim setAutoreverses:YES];
    [[img layer] addAnimation:anim forKey:ANIM_SHAKE_KEY];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) setDisplayType: (DiaplayType) type
{
    if (type == DisplayTypeShake) {
        _imgShake.hidden = NO;
        _dataTable.hidden = YES;
    } else if (type == DisplayTypeDataList) {
        _imgShake.hidden = YES;
        _dataTable.hidden = NO;
    }
}

- (void) beginLoadData
{
    _isLodingData = YES;
    [ResouceApi RequestJson:@"http://dzsvr.sinaapp.com/" Path:@"rand_land" result:^(id JSON) {
        _isLodingData = NO;
        [[_imgShake layer] removeAnimationForKey:ANIM_SHAKE_KEY];
        if(JSON == nil) {
            // failed
            [self setDisplayType:DisplayTypeShake];
            [SoundUtil playShakeSound:ShakeSoundStyleFailed];
            return;
        }
        // play sucess music
        [self setDisplayType:DisplayTypeDataList];
        [SoundUtil playShakeSound:ShakeSoundStyleEnd];
        SBJsonParser *parser = [[SBJsonParser alloc] init];
        NSMutableArray *array = [parser objectWithString:JSON];
        for(NSMutableDictionary *dict in array) {
            NSLog(@"item:%@", [dict valueForKey:@"title"]);
        }
        self.dataTableController.datas = array;
        NSLog(@"reload Data");
        [self.dataTableController.tableView reloadData];
    }];
 
}

- (IBAction)Click:(id)sender {
     [ResouceApi RequestJson:@"http://dzsvr.sinaapp.com/" Path:@"rand_land" result:^(id JSON) {
         SBJsonParser *parser = [[SBJsonParser alloc] init];
         NSMutableArray *array = [parser objectWithString:JSON];
         for(NSMutableDictionary *dict in array) {
             NSLog(@"item:%@", [dict valueForKey:@"title"]);
         }
         self.dataTableController.datas = array;
         NSLog(@"reload Data");
         [self.dataTableController.tableView reloadData];
     }];
}
@end
