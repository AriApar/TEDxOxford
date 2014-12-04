//
//  SpeakersTableViewController.h
//  TEDxOxford
//
//  Created by Ari Aparikyan on 29/09/2014.
//  Copyright (c) 2014 Ari Aparikyan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WPJSONDataManager.h"

@interface SpeakersTableViewController : UITableViewController

@property UIActivityIndicatorView *activityIndicator;
- (IBAction)refresh:(UIRefreshControl *)sender;


@end
