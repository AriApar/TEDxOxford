//
//  NewsDetailViewController.h
//  TEDxOxford
//
//  Created by Ari Aparikyan on 28/09/2014.
//  Copyright (c) 2014 Ari Aparikyan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsData.h"

@interface NewsDetailViewController : UIViewController

@property IBOutlet UIWebView *contentTextView;
@property IBOutlet UILabel *titleLabel;
@property NewsData *newsItem;

@end
