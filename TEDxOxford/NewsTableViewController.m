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
    NSMutableArray *_news;
    NSString *_lastRefreshed;
    WPJSONDataManager *_manager;
    NSInteger _pageNo;
    BOOL _refreshing;
    UIRefreshControl *_sender;
    NSDateFormatter *_dateFormat;
    NSMutableArray *_imageArray;
    UIButton *_loadMore;
    
    //Call dispatch_group_enter(group) whenever you call a manager method that gets news data.
    dispatch_group_t group;
}
- (IBAction)loadMorePosts:(UIButton *)sender;

@end

@implementation NewsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    group = dispatch_group_create();
    
    _manager = [[WPJSONDataManager alloc] init];
    _manager.delegate = self;
    _pageNo = 1;
    _refreshing = NO;
    
    _dateFormat = [[NSDateFormatter alloc] init];
    [_dateFormat setDateFormat:@"yyyy-MM-dd'%20'HH:mm:ss"];
    NSDate *now = [NSDate date];
    
    NSString *dateString = [_dateFormat stringFromDate:now];
    _lastRefreshed = dateString;
    
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.activityIndicator.hidesWhenStopped = YES;
    self.activityIndicator.center = CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height / 2);
    // Try loading old data
    [self loadDataFromDisk];
    
    if (!_news) {
        dispatch_group_enter(group);
        [_manager refreshNewsFromTime:nil];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - WPJSONDataManagerDelegate

-(void) didReceiveNewsData:(NSMutableArray *)news
{
    //Check if the new news items are different to the old ones.
    if(news.count !=0)
    {
        if(news.count < 10)
        {
            [news addObjectsFromArray:_news];
        }
        
        _news =  news;
        
        [self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.tableView.tableFooterView.hidden = NO;
            _loadMore.enabled = YES;
        });
    }
    
    if(_refreshing) {
        [_sender endRefreshing];
        _refreshing = NO;
    }
    
    dispatch_group_leave(group);
}

- (void)didReceiveNewsOffsetData:(NSArray *)groups
{
    if(groups.count !=0)
    {
        [_news addObjectsFromArray:groups];

        [self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.tableView.tableFooterView.hidden = NO;
            _loadMore.enabled = YES;
        });
        
        //dispatch_semaphore_signal(sema);
    }
    else {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.tableView.tableFooterView = nil;
            _loadMore.enabled = NO;
        });
    }
    
    dispatch_group_leave(group);
}

- (void) fetchingNewsDataFailedWithError:(NSError *)error
{
    //TODO show message to user
    NSLog(@"Error %@; %@", error, [error localizedDescription]);
}

- (void) prepareImageFailedWithError:(NSError *)error forItemWithId:(NSString *)postid
{
    //TODO show message to user
    NSLog(@"Error %@; %@", error, [error localizedDescription]);
}

- (void) updateImageForItemWithId:(NSString *)postid withImageData:(NSData *)image
{
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    //dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    //item.thumbnailImage = image;
    NSUInteger index = [_news indexOfObjectPassingTest:^BOOL(NewsData *item, NSUInteger idx, BOOL *stop){
        
        if ([postid isEqualToString:item.postid])
        {
            *stop = YES;
            return true;
        }
        return NO;
    }];
    
    if (index != NSNotFound) {
        
        //NSArray *indexArray = [NSArray arrayWithObject:indexPath];
        dispatch_async(dispatch_get_main_queue(), ^{
            //NewsData *item = _news[index];
            NewsData *data = _news[index];
            data.imageData = image;
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
            NewsCellTableViewCell *cell = (NewsCellTableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath];
            [cell.thumbnailImage setImage:[UIImage imageWithData:image]];
            
            //[self.tableView reloadRowsAtIndexPaths:indexArray withRowAnimation:UITableViewRowAnimationFade];
        });
    }
    
}

- (NSMutableArray *)getNewsData
{
    return _news;
}

-(NSString *)getLastRefreshed
{
    return _lastRefreshed;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    if (_news) {
        [self.activityIndicator stopAnimating];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        //self.tableView.backgroundView = nil;
        return 1;
        
    } else {
        self.tableView.tableFooterView.hidden = YES;

        [self.activityIndicator startAnimating];
        
        
        // Display a message when the table is empty
        /*UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
        

        messageLabel.text = @"No data is currently available. Please pull down to refresh.";
        messageLabel.textColor = [UIColor blackColor];
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = NSTextAlignmentCenter;
        messageLabel.font = [UIFont fontWithName:@"Palatino-Italic" size:20];
        [messageLabel sizeToFit];
        */
        self.tableView.backgroundView = self.activityIndicator;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    
    return 0;
}

- (void)loadDataFromDisk {
    NSString *path = @"~/Library/Cache/news";
    path = [path stringByExpandingTildeInPath];
    
    NSMutableDictionary *rootObject;
    rootObject = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    
    if ([rootObject valueForKey:@"NewsData"]) {
        _news = [rootObject valueForKey:@"NewsData"];
    }
    if ([rootObject valueForKey:@"LastRefreshed"]) {
        _lastRefreshed = [rootObject valueForKey:@"LastRefreshed"];
    }
    
    [self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
    
    NSLog(@"Data loaded");
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return _news.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NewsCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewsCell" forIndexPath:indexPath];
    UIImage *defImg = [UIImage imageNamed:@"blogreading1.jpg"];
    
    
    // Configure the cell...
    
    NewsData *item = _news[indexPath.row];
    cell.titleLabel.text = item.title;
    [cell.excerptLabel setText:item.excerpt];
    if (item.imageData)
    {
        [cell.thumbnailImage setImage:[UIImage imageWithData:item.imageData]];
    }
    else {
        [cell.thumbnailImage setImage:defImg];
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


- (IBAction)refresh:(UIRefreshControl *)sender {
    //TODO: refresh your data
    _sender = sender;    
    _refreshing = YES;
    NSString *prevRefreshTime = _lastRefreshed.copy;
    NSDate *now = [NSDate date];
    
    NSString *dateString = [_dateFormat stringFromDate:now];
    _lastRefreshed = dateString;
    
    dispatch_group_enter(group);
    [_manager refreshNewsFromTime:prevRefreshTime];
}

- (IBAction)loadMorePosts:(UIButton *)sender {
    _loadMore = sender;
    sender.enabled = NO;
    dispatch_group_enter(group);
    [_manager loadMorePostsWithOffset:_news.count];
}
@end
