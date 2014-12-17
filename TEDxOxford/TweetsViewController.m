//
//  TweetsViewController.m
//  TEDxOxford
//
//  Created by Ari Aparikyan on 10/12/2014.
//  Copyright (c) 2014 Ari Aparikyan. All rights reserved.
//

#import "TweetsViewController.h"
#import "NSString+HTML.h"

@interface TweetsViewController () <UIWebViewDelegate>

@end

@implementation TweetsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.contentTextView.delegate = self;
    [self showLoadingScreen];
    [self setUpFeed];

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
}

- (void) setUpFeed
{
    self.contentTextView.hidden = YES;
    [self.activityIndicator startAnimating];
    NSString *content = @"<html><head><style>.aspect-ratio iframe {width: 100%%;} body { margin: 0; padding: 0; }</style></head><body><div class=aspect-ratio><a class=\"twitter-timeline\" href=\"https://twitter.com/search?q=tedxoxford\" data-widget-id=\"542773037305982976\" data-chrome=\"noheader\"></a><script>!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0],p=/^http:/.test(d.location)?'http':'https';if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src=p+\"://platform.twitter.com/widgets.js\";fjs.parentNode.insertBefore(js,fjs);}}(document,\"script\",\"twitter-wjs\");</script></div></body></html>";
    [self.contentTextView loadHTMLString:[content stringByDecodingHTMLEntities] baseURL:nil];
    //[self.activityIndicator stopAnimating];
    self.contentTextView.hidden = NO;
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
    [self setUpFeed];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [self.activityIndicator stopAnimating];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
    
}


@end
