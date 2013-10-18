//
//  DataTableContrllerViewController.m
//  QvodFriend
//
//  Created by douzifly on 13-9-6.
//  Copyright (c) 2013年 douzifly. All rights reserved.
//

#import "DataTableContrller.h"
#import "QVODHelper.h"
#import "UIUtil.h"
#import "UIColor+Hex.h"
#import "MyUITableViewCell.h"
#define numberCount 20
@interface DataTableContrller ()
@end
@implementation DataTableContrller
{
    NSString* currentHash;
    int numbers[numberCount];
    int numberIndex;
    NSMutableDictionary *video_data;
}

@synthesize datas = _datas;

- (void) clearNumber
{
    for (int i = 0; i < numberCount; i++) {
        numbers[i] = 0;
    }
    numberIndex = 0;
}

- (void) addNumber:(int) number
{
    numbers[numberIndex++] = number;
}

- (BOOL) checkExists:(int) number
{
    for (int i = 0; i < numberCount; i++) {
        if(numbers[i] == number) {
            return YES;
        }
    }
    return NO;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if(buttonIndex == 0) {
        //play
        [QVODHelper playWithHash:currentHash handleNoQvod:YES];
    }
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return _datas == nil ? 0 : [_datas count];
}

- (void)setDatas:(NSMutableArray *)d{
    _datas = d;
 
    if (video_data == nil) {
        NSString *pathlist = [[NSBundle mainBundle] pathForResource:@"video_data" ofType:@"plist"];
        video_data = [[NSMutableDictionary alloc] initWithContentsOfFile:pathlist];
//        NSLog(@"+++++%@", [[video_data objectForKey:@"froms"] objectForKey:[NSString stringWithFormat:@"%d", 1]]);
    }
    
//    for (int i = 0; i < _datas.count; i++) {
//        NSMutableDictionary *dictionary = [_datas objectAtIndex:i];
//        [dictionary setObject:[self randomHead] forKey:@"head"];
////        NSLog(@"++++,%d", i);
//        [dictionary setObject:[[video_data objectForKey:@"froms"] objectForKey:[NSString stringWithFormat:@"%d", i]] forKey:@"from"];
//    }
//    [self clearNumber];
    [self.tableView reloadData];
//    [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionBottom];
    [self.tableView setContentOffset:CGPointZero animated:NO];
}

- (NSString*) randomHead
{
    int max = 48;
    int min = 1;
    int randNum = rand() % (max - min) + min;
    if ([self checkExists:randNum]) {
        return [self randomHead];
    }
    [self addNumber:randNum];
    NSString *head = [NSString stringWithFormat:@"head_%d", randNum];
    NSLog(@"head:%@", head);
    return head;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
//    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil) {
//        NSLog(@"new cell for index path:%d", indexPath.row);
        cell = [[MyUITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        cell.detailTextLabel.tintColor = [UIColor lightGrayColor];
        cell.detailTextLabel.font = [cell.detailTextLabel.font fontWithSize:10];
        cell.textLabel.font = [cell.textLabel.font fontWithSize:16];
    }
    // Configure the cell...
    
    if(cell == nil) {
        NSLog(@"cell is nil at row:%d", indexPath.row);
        return nil;
    }
//    cell.imageView.image = [UIImage imageNamed:[[_datas objectAtIndex:indexPath.row] valueForKey:@"head"]];
    cell.textLabel.text = [[_datas objectAtIndex:indexPath.row] valueForKey:@"title"];
    cell.backgroundColor = indexPath.row % 2 == 0 ? [UIColor colorWithHex:@"#EBEFF0"] : [UIColor colorWithHex:@"#F2F2F2"];
//    cell.detailTextLabel.text = [[_datas objectAtIndex:indexPath.row] valueForKey:@"from"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* hash = [[_datas objectAtIndex:indexPath.row] valueForKey:@"hash"];
    currentHash = hash;
    [UIUtil showAlert:@"播放" withMessage:hash leftButton:@"播放" rightButton:@"取消" delegate:self];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
