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
#import "MyUserManager.h"

@interface DataTableContrller ()
@end
@implementation DataTableContrller
{
    NSString* currentHash;
}

@synthesize datas = _datas;


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
    [[MyUserManager sharedInstance] resetRandomMarker];
    for (int i = 0; i < _datas.count; i++) {
        NSMutableDictionary *dictionary = [_datas objectAtIndex:i];
        if (i >= [[MyUserManager sharedInstance] count]) {
            break;
        }
        User* u = [[MyUserManager sharedInstance] random];
        [dictionary setObject:u.avataPath forKey:@"head"];
        [dictionary setObject:u.name forKey:@"from"];
    }
    [self.tableView reloadData];
    [self.tableView setContentOffset:CGPointZero animated:NO];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil) {
//        NSLog(@"new cell for index path:%d", indexPath.row);
        cell = [[MyUITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.detailTextLabel.font = [cell.detailTextLabel.font fontWithSize:10];
        cell.textLabel.font = [cell.textLabel.font fontWithSize:16];
    }
    // Configure the cell...
    
    if(cell == nil) {
        NSLog(@"cell is nil at row:%d", indexPath.row);
        return nil;
    }
    NSString *imageurl = [[_datas objectAtIndex:indexPath.row] valueForKey:@"head"];
    if (imageurl != nil) {
        cell.imageView.image = [UIImage imageNamed:imageurl];
    }
    cell.textLabel.text = [[_datas objectAtIndex:indexPath.row] valueForKey:@"title"];
    cell.backgroundColor = indexPath.row % 2 == 0 ? [UIColor colorWithHex:@"#EBEFF0"] : [UIColor colorWithHex:@"#F2F2F2"];
    
    NSString *from = [[_datas objectAtIndex:indexPath.row] valueForKey:@"from"];
    if (from != nil) {
        cell.detailTextLabel.text = from;
    }
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
