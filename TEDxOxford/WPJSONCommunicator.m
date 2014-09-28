//
//  WPJSONCommunicator.m
//  TEDxOxford
//
//  Created by Ari Aparikyan on 25/09/2014.
//  Copyright (c) 2014 Ari Aparikyan. All rights reserved.
//

#import "WPJSONCommunicator.h"

@implementation WPJSONCommunicator

- (void)getRecentNewsByPage:(NSInteger)pageNumber
{
    NSString *urlAsString = [NSString stringWithFormat:@"http://tedxoxford.co.uk/api/get_recent_posts/?count=10&page=%ld", pageNumber];
    NSURL *url = [[NSURL alloc] initWithString:urlAsString];
    NSLog(@"%@", urlAsString);
    
    [NSURLConnection sendAsynchronousRequest:[[NSURLRequest alloc] initWithURL:url] queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        
            if (error) {
                [self.delegate fetchingNewsDataFailedWithError:error];
            } else {
                [self.delegate receivedNewsDataJSON:data];
            }
        }];
}


@end
