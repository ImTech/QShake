//
//  FirstViewController.m
//  QvodFriend
//
//  Created by douzifly on 13-8-15.
//  Copyright (c) 2013年 douzifly. All rights reserved.
//

#import "ShakeViewController.h"
#import "Download/ResouceApi.h"
#import "SBJson.h"
#import "DataTableContrller.h"
#import "SoundUtil.h"
#import "UIColor+Hex.h"
#import "QVODHelper.h"
#import "UIUtil.h"
#import "Setting.h"
#import "MobClickHelper.h"
#import "IntruduceViewController.h"

#define ANIM_SHAKE_COUNT 5
#define ANIM_SHAKE_KEY  @"ICON_SHAKE"

@interface ShakeViewController ()
{
    BOOL _isLodingData;
    UIImageView *_handleView;
    BOOL _isShowTable;
    CGPoint _movePoint;
}
@property(strong, nonatomic) DataTableContrller *dataTableController;
@end
@implementation ShakeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.dataTableController = [[DataTableContrller alloc] init];
    self.dataTableController.tableView = self.dataTable.tableView;
    self.dataTable.delegate = self;
    _dataTable.tableView.backgroundColor = [UIColor whiteColor];
    _dataTable.backgroundColor = [UIColor clearColor];
    
    [self.imgShake setImage:[UIImage imageNamed:@"a_05"]];
    self.imgShake.delegate = self;
    [self.view setBackgroundColor:[UIColor colorWithHex:@"#E4E7EB"]];
//    [self.navigationBar setBackgroundImage:[[UIImage imageNamed:@"a_02"] stretchableImageWithLeftCapWidth:10 topCapHeight:10] forBarMetrics:UIBarMetricsDefault];
    
    // ios solid background color
    [[UINavigationBar appearance] setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setBackgroundColor:[UIColor colorWithHex:@"1578a1"]];
    // ----
    @try {
        self.navigationBar.barTintColor = [UIColor colorWithHex:@"1578a1"];
    }
    @catch (NSException *exception) {
    }
    @finally {
    }
    
    [self.tabBarItem setImage:[UIImage imageNamed:@"a_11"]];
   
    NSLog(@"tableView height:%@", self.dataTable.tableView);
    
    [self calcTableHeight];
    [self calcImagePos];
    _searchBar.delegate = self;
    _searchBar.searchTextPositionAdjustment = UIOffsetMake(14.f, 0);
    _searchBar.hidden = YES;

    [self initNaviBar];
    [self loadDataWithSound:NO];
    
    // tap shake
    UITapGestureRecognizer *imagetapper = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleImageTap:)];
    self.imgShake.userInteractionEnabled = YES;
    [self.imgShake addGestureRecognizer:imagetapper];
}

- (void) handleImageTap:(id) sender
{
    NSLog(@"tap image");
    [self loadDataWithSound:YES];
}

- (void) checkShowIntruduce
{
    if (![Setting showIntruduce]) {
        NSLog(@"do not show intruduce");
        return;
    }
    NSLog(@"show intruduce");
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    if (sb == nil) {
        NSLog(@"sb nil");
    }
    IntruduceViewController *intruduce = [sb instantiateViewControllerWithIdentifier:@"Intruduce"];
    [self presentModalViewController:intruduce animated:YES];
}

- (void) initNaviBar {
    BOOL isMute = [Setting isMute];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 40, 40);
    [button addTarget:self action:@selector(naviItemClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *btn = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = btn;
    [self setMuteButton:isMute];
}

- (void) setMuteButton:(BOOL) isMute
{
    NSString *icon = isMute ? @"nobell" : @"bell";
    UIBarButtonItem *btnItem = self.navigationItem.rightBarButtonItem;
    UIButton *btn = (UIButton *)btnItem.customView;
    [btn setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [Setting setMute:isMute];
}

- (void) naviItemClick:(UIBarButtonItem*) sender
{
    // toggle
    BOOL isMute = ![Setting isMute];
    [self setMuteButton:isMute];
}

- (void)viewDidAppear:(BOOL)animated {
    [_imgShake becomeFirstResponder];
}


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSLog(@"search:%@", searchBar.text);
    [self beginSearchData:searchBar.text];
}


-(void) calcImagePos{
    BOOL ios7 = [[UIDevice currentDevice].systemVersion floatValue] >= 7.0;
    if (ios7) {
        _imgShake.center = self.view.center;
    } else {
        _imgShake.center = CGPointMake(self.view.center.x, self.view.center.y - 26);
    }
}

-(void) calcTableHeight {
    //    float screenHeight = [[UIScreen mainScreen] bounds].size.height;
    BOOL ios7 = [[UIDevice currentDevice].systemVersion floatValue] >= 7.0;
    CGRect naviFrame = self.navigationBar.frame;
    CGRect tabFrame = self.tabBarController.tabBar.frame;
    CGFloat height = 0;
    if (ios7) {
        height = tabFrame.origin.y - naviFrame.origin.y - naviFrame.size.height;
    } else {
        height = tabFrame.origin.y - naviFrame.origin.y - naviFrame.size.height - 22;
    }
//    NSLog(@"calcTableHeight height:%f", height);
    _dataTable.frame = CGRectMake(0, naviFrame.origin.y + naviFrame.size.height + 1, naviFrame.size.width, height - 16);
    // make hide
    _isShowTable = NO;
    CGRect rect = _dataTable.frame;
   _dataTable.frame = CGRectMake(rect.origin.x, rect.origin.y - rect.size.height + [_dataTable getHandleHeight] - 4, rect.size.width, rect.size.height);
}

- (void) hideTable
{
//    if(YES) return;
    _isShowTable = NO;
    CGFloat maxDuration = 0.6f;
    CGFloat duration = _dataTable.transform.ty / _dataTable.frame.size.height * maxDuration;
    if (duration == 0) duration = 0.6f;
    NSLog(@"hideTable duration:%f", duration);
    [UIView animateWithDuration: duration
                              delay:0.0
                            options: UIViewAnimationOptionCurveLinear
                         animations:^{
                             _dataTable.transform = CGAffineTransformMakeTranslation(0, 0);
                         }
                        completion: ^(BOOL finished){
                            if(finished) {
                                _dataTable.handleDriction = HandleArrowDirectionDown;
                            }
                        }
     ];
    
}

- (void) showTable
{
//    if(YES) return;
    NSLog(@"showTable");
    _isShowTable = YES;
    CGFloat maxDuration = 0.6f;
    CGFloat duration = (_dataTable.frame.size.height - _dataTable.transform.ty) / _dataTable.frame.size.height * maxDuration;
    NSLog(@"showTable duration:%f", duration);
    [UIView animateWithDuration: duration
                          delay:0.0
                        options: UIViewAnimationOptionCurveLinear
                     animations:^{
                         _dataTable.transform = CGAffineTransformMakeTranslation(0, _dataTable.frame.size.height - [_dataTable getHandleHeight]);
                     }
                     completion:^(BOOL fininshed){
                         if(fininshed) {
                             _dataTable.handleDriction = HandleArrowDirectionUp;
                         }
                     }
     
     ];
}

- (void) toggleShowTable
{
    if (_isShowTable) {
        [self hideTable];
    } else {
        [self showTable];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.imgShake becomeFirstResponder];
    [super viewWillAppear:animated];
}

- (void) loadDataWithSound:(BOOL) sound
{
    if(_isLodingData) {
        NSLog(@"loading");
        return;
    }
    [self shakeImage:self.imgShake withRepeatCount:NSUIntegerMax];
    if (sound) {
        [SoundUtil playShakeSound:ShakeSoundStyleBegin];
    }
    [self beginLoadData:sound];
    [MobClickHelper logShake];
}

-(void) shakeImageViewShaked:(ShakeImageView *)imageView
{
    [self loadDataWithSound:YES];
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

- (void) beginSearchData:(NSString *) text
{
    [self shakeImage:_imgShake withRepeatCount:NSUIntegerMax];
    _isLodingData = YES;
    [self hideTable];
    NSString *path = [NSString stringWithFormat:@"search?kw=%@", [QVODHelper urlEncoded:text]];
    NSLog(@"path:%@", path);
    [ResouceApi RequestJson:@"http://dzsvr.sinaapp.com/" Path:path result:^(id JSON) {
        [NSThread sleepForTimeInterval:1];
        _isLodingData = NO;
        [_searchBar resignFirstResponder];
        [[_imgShake layer] removeAnimationForKey:ANIM_SHAKE_KEY];
        if(JSON == nil) {
            // failed
            return;
        }
        // play sucess music
        [self showTable];
        SBJsonParser *parser = [[SBJsonParser alloc] init];
        NSMutableArray *array = [parser objectWithString:JSON];
        for(NSMutableDictionary *dict in array) {
            NSLog(@"item:%@", [dict valueForKey:@"title"]);
        }
        self.dataTableController.datas = array;
        NSLog(@"reload Data");
        //        [self.dataTableController.tableView reloadData];
    }];
    
}


- (void) beginLoadData:(BOOL) useSound
{
    _isLodingData = YES;
    [self hideTable];
    [ResouceApi RequestJson:@"http://dzsvr.sinaapp.com/" Path:@"rand_ios" result:^(id JSON) {
        [NSThread sleepForTimeInterval:1];
        _isLodingData = NO;
        [[_imgShake layer] removeAnimationForKey:ANIM_SHAKE_KEY];
        if(JSON == nil && useSound) {
            // failed
            [SoundUtil playShakeSound:ShakeSoundStyleFailed];
            return;
        }
        // play sucess music
        [self showTable];
        if (useSound) {
            [SoundUtil playShakeSound:ShakeSoundStyleEnd];
        }
        SBJsonParser *parser = [[SBJsonParser alloc] init];
        NSMutableArray *array = [parser objectWithString:JSON];
        for(NSMutableDictionary *dict in array) {
            NSLog(@"item:%@", [dict valueForKey:@"title"]);
        }
        self.dataTableController.datas = array;
        NSLog(@"reload Data");
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

-(BOOL)shouldAutorotate {
    return NO;
}

- (void)handleClicked
{
    [self toggleShowTable];
}

- (void) handleBeginMove {
    NSLog(@"move begin");
}

- (void) handleMoving:(CGPoint)point
{
    NSLog(@"moving y:%f", point.y);
    _movePoint = point;
    CGFloat y = _isShowTable ? point.y + _dataTable.tableView.frame.size.height : point.y;
    if (y > _dataTable.tableView.frame.size.height) {
        y = _dataTable.tableView.frame.size.height;
    } else if (y < 0) {
        y = 0;
    }
    [UIView animateWithDuration:0.0
                          delay:0.0
                        options: UIViewAnimationOptionCurveLinear
                     animations:^{
                         _dataTable.transform = CGAffineTransformMakeTranslation(0, y);
                     }
                     completion: ^(BOOL finished){
                         if(finished) {
                             _dataTable.handleDriction = HandleArrowDirectionDown;
                         }
                     }
     ];
    
}

- (void) handleEndMove
{
    NSLog(@"move end");
    if (_movePoint.y > 0) {
        [self showTable];
    } else {
        [self hideTable];
    }
    
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end
