//
//  ScheduleViewController.h
//  TEDxOxford
//
//  Created by Ari Aparikyan on 30/09/2014.
//  Copyright (c) 2014 Ari Aparikyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScheduleViewController : UIViewController

@property IBOutlet UIWebView *contentTextView;
@property UIActivityIndicatorView *activityIndicator;
- (IBAction)refresh:(UIButton *)sender;

@end
