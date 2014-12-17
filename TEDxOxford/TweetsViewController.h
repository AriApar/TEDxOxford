//
//  TweetsViewController.h
//  TEDxOxford
//
//  Created by Ari Aparikyan on 10/12/2014.
//  Copyright (c) 2014 Ari Aparikyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TweetsViewController : UIViewController

@property IBOutlet UIWebView *contentTextView;
@property UIActivityIndicatorView *activityIndicator;
- (IBAction)refresh:(UIButton *)sender;

@end
