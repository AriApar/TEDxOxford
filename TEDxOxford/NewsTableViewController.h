//
//  NewsTableViewController.h
//  TEDxOxford
//
//  Created by Ari Aparikyan on 26/09/2014.
//  Copyright (c) 2014 Ari Aparikyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsTableViewController : UITableViewController

@property UIActivityIndicatorView *activityIndicator;
- (IBAction)refresh:(UIRefreshControl *)sender;
- (NSMutableArray *)getNewsData;
- (NSString *)getLastRefreshed;
- (void) setNews:(NSMutableArray *)news;
- (void) setLastRefreshed:(NSString *)lastRefreshed;

@end
