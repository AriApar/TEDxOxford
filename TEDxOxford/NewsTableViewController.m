//
//  NewsTableViewController.m
//  TEDxOxford
//
//  Created by Ari Aparikyan on 26/09/2014.
//  Copyright (c) 2014 Ari Aparikyan. All rights reserved.
//

#import "NewsTableViewController.h"
#import "WPJSONDataManagerDelegate.h"
#import "WPJSONDataManager.h"
#import "NewsData.h"
#import "NewsCellTableViewCell.h"
#import "NewsDetailViewController.h"

@interface NewsTableViewController () <WPJSONDataManagerDelegate> {
    NSArray *_news;
    WPJSONDataManager *_manager;
    NSInteger _pageNo;
    dispatch_semaphore_t sema;
}

@end

@implementation NewsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    _manager = [[WPJSONDataManager alloc] init];
    _manager.delegate = self;
    _pageNo = 1;
    sema = dispatch_semaphore_create(0);
    
    [_manager getRecentNewsByPage:_pageNo];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - WPJSONDataManagerDelegate

-(void) didReceiveNewsData:(NSArray *)news
{
    _news = news;
    dispatch_semaphore_signal(sema);
    [self.tableView reloadData];
}

- (void) fetchingNewsDataFailedWithError:(NSError *)error
{
    //TODO show message to user
    NSLog(@"Error %@; %@", error, [error localizedDescription]);
}

- (void) prepareImageFailedWithError:(NSError *)error forItemAtIndex:(NSUInteger)index
{
    //TODO show message to user
    NSLog(@"Error %@; %@", error, [error localizedDescription]);
}

- (void) updateImageForItemAtIndex:(NSUInteger)index withImage:(UIImage *)image
{
    dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    NewsData *item = _news[index];
    item.thumbnailImage = image;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    NSArray *indexArray = [NSArray arrayWithObject:indexPath];
    [self.tableView reloadRowsAtIndexPaths:indexArray withRowAnimation:UITableViewRowAnimationFade];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return _news.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NewsCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewsCell"
                                                            forIndexPath:indexPath];
    UIImage *defImg = [UIImage imageNamed:@"blogreading1.jpg"];
    cell.thumbnailImage.image = defImg;
    
    // Configure the cell...
    
    NewsData *item = _news[indexPath.row];
    cell.titleLabel.text = item.title;
    [cell.excerptLabel setText:item.excerpt];
    if (item.thumbnailImage) {
        cell.thumbnailImage.image = item.thumbnailImage;
    }
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    NewsData *object = _news[indexPath.row];
    [[segue destinationViewController] setNewsItem:object];
}


@end
