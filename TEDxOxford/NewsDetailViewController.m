//
//  NewsDetailViewController.m
//  TEDxOxford
//
//  Created by Ari Aparikyan on 28/09/2014.
//  Copyright (c) 2014 Ari Aparikyan. All rights reserved.
//

#import "NewsDetailViewController.h"

@interface NewsDetailViewController () //<UIWebViewDelegate>

@end

@implementation NewsDetailViewController {
    BOOL isWebViewLoaded;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configureView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configureView
{
    self.titleLabel.text = self.newsItem.title;
    //self.contentTextView.delegate = self;
    [self.contentTextView loadHTMLString:self.newsItem.content baseURL:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

/*
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    if (!isWebViewLoaded) { isWebViewLoaded = true; return YES; }
    else return NO;
}
 */

@end
