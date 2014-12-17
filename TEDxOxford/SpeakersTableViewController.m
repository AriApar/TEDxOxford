//
//  SpeakersTableViewController.m
//  TEDxOxford
//
//  Created by Ari Aparikyan on 29/09/2014.
//  Copyright (c) 2014 Ari Aparikyan. All rights reserved.
//

#import "SpeakersTableViewController.h"
#import "NewsDetailViewController.h"

@interface SpeakersTableViewController () <WPJSONDataManagerDelegate> {
    NSArray *_speakers;
    WPJSONDataManager *_manager;
    BOOL _refreshing;
    UIRefreshControl *_sender;
}


@end

@implementation SpeakersTableViewController

- (void)viewDidLoad {
    _refreshing = NO;
    [super viewDidLoad];
    _manager = [[WPJSONDataManager alloc] init];
    _manager.delegate = self;
    
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.activityIndicator.hidesWhenStopped = YES;
    self.activityIndicator.center = CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height / 2);
    
    [_manager getSpeakers];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - WPJSONDataManagerDelegate

- (void) didReceiveNewsData:(NSArray *)groups
{
    _speakers = groups;
    [self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
    if(_refreshing) {
        [_sender endRefreshing];
        _refreshing = NO;
    }
}

- (void) fetchingNewsDataFailedWithError:(NSError *)error
{
    dispatch_async(dispatch_get_main_queue(), ^{
        //[self.activityIndicator stopAnimating];
        if(_refreshing) {
            [_sender endRefreshing];
            _refreshing = NO;
        }
    });
    //TODO show message to user
    NSLog(@"Error %@; %@", error, [error localizedDescription]);
}

- (void) prepareImageFailedWithError:(NSError *)error forItemAtIndex:(NSUInteger)index
{
    dispatch_async(dispatch_get_main_queue(), ^{
        //[self.activityIndicator stopAnimating];
    });
    //TODO show message to user
    NSLog(@"Error %@; %@", error, [error localizedDescription]);
}

- (void) updateImageForItemAtIndex:(NSUInteger)index withImage:(UIImage *)image
{
    //No image for speakers, do nothing.
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    if (_speakers)
    {
        [self.activityIndicator stopAnimating];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        //self.tableView.backgroundView = nil;
        return 1;
    }
    else
    {
        [self.activityIndicator startAnimating];
        self.tableView.backgroundView = self.activityIndicator;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return _speakers.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SpeakersCell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    NewsData *item = _speakers[indexPath.row];
    [cell.textLabel setText:item.title];
    
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

#pragma mark - navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    NewsData *object = _speakers[indexPath.row];
    [[segue destinationViewController] setNewsItem:object];
}

#pragma mark - Refresh

- (IBAction)refresh:(UIRefreshControl *)sender
{
    _sender = sender;
    _refreshing = YES;
    [_manager getSpeakers];
    
}
@end
