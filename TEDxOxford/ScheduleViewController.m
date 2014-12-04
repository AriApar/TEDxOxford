//
//  ScheduleViewController.m
//  TEDxOxford
//
//  Created by Ari Aparikyan on 30/09/2014.
//  Copyright (c) 2014 Ari Aparikyan. All rights reserved.
//

#import "ScheduleViewController.h"
#import "WPJSONDataManagerDelegate.h"
#import "WPJSONDataManager.h"

@interface ScheduleViewController () <WPJSONDataManagerDelegate> {
    WPJSONDataManager *_manager;
}


@end

@implementation ScheduleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _manager = [[WPJSONDataManager alloc] init];
    _manager.delegate = self;
    [self showLoadingScreen];
    [_manager getSchedule];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showLoadingScreen
{
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.activityIndicator.hidesWhenStopped = YES;
    [self.view addSubview:self.activityIndicator];
    self.activityIndicator.center = CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height / 2);
    [self.activityIndicator startAnimating];
}

#pragma mark - WPJSONDataManagerDelegate

- (void) didReceiveNewsData:(NSArray *)groups
{
}

- (void) fetchingNewsDataFailedWithError:(NSError *)error
{
    //TODO show message to user
    NSLog(@"Error %@; %@", error, [error localizedDescription]);
}

- (void) prepareImageFailedWithError:(NSError *)error forItemAtIndex:(NSUInteger)index
{
}

- (void) updateImageForItemAtIndex:(NSUInteger)index withImage:(UIImage *)image
{
}

- (void)didReceiveScheduleData:(NewsData *)newsData
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.activityIndicator stopAnimating];
        self.contentTextView.hidden = NO;
        [self.contentTextView loadHTMLString:newsData.content baseURL:nil];
    });
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)refresh:(UIButton *)sender
{
    self.contentTextView.hidden = YES;
    [self.activityIndicator startAnimating];
    [_manager getSchedule];
}

@end
