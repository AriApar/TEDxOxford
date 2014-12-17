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
    NSString *urlAsString = @"http://tedxoxford.co.uk/api/get_posts/?include=id,title,title_plain,content,excerpt,thumbnail";
    [self sendRequestTo:urlAsString];
}

- (void)getSpeakers
{
    ////To get speakers, I created a category specific for this purpose with slug "iospeakers"
    ////If you want to adapt to next years, create a new category for yours and change the link.
    NSString *urlAsString = @"http://tedxoxford.co.uk/api/get_category_posts/?slug=iospeakers&count=40&include=title,title_plain,content,id";
    //[self sendRequestTo:urlAsString];
    
    NSLog(@"%@", urlAsString);
    NSURL *url = [[NSURL alloc] initWithString:urlAsString];
    
    [NSURLConnection sendAsynchronousRequest:[[NSURLRequest alloc] initWithURL:url] queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        if (error) {
            [self.delegate fetchingSpeakerDataFailedWithError:error];
        } else {
            [self.delegate receivedSpeakerDataJSON:data];
        }
    }];

    
}

- (void)getSchedule
{
    NSString *urlAsString = @"http://tedxoxford.co.uk/api/get_page/?id=955&include=title,title_plain,content,id";
//http://tedxoxford.co.uk/api/get_page/?id=1132&include=title,title_plain,content,id";

    NSURL *url = [[NSURL alloc] initWithString:urlAsString];
    NSLog(@"%@", urlAsString);
    
    [NSURLConnection sendAsynchronousRequest:[[NSURLRequest alloc] initWithURL:url] queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        if (error) {
            [self.delegate fetchingNewsDataFailedWithError:error];
        } else {
            [self.delegate receivedScheduleDataJSON:data];
        }
    }];
}

- (void)getAboutUs
{
    NSString *urlAsString = @"http://tedxoxford.co.uk/api/get_page/?id=1132&include=title,title_plain,content,id";
    
    NSURL *url = [[NSURL alloc] initWithString:urlAsString];
    NSLog(@"%@", urlAsString);
    
    [NSURLConnection sendAsynchronousRequest:[[NSURLRequest alloc] initWithURL:url] queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        if (error) {
            [self.delegate fetchingNewsDataFailedWithError:error];
        } else {
            [self.delegate receivedScheduleDataJSON:data];
        }
    }];
}

- (void)getOurPartner
{
    NSString *urlAsString = @"http://tedxoxford.co.uk/api/get_page/?id=933&include=title,title_plain,content,id";
    
    NSURL *url = [[NSURL alloc] initWithString:urlAsString];
    NSLog(@"%@", urlAsString);
    
    [NSURLConnection sendAsynchronousRequest:[[NSURLRequest alloc] initWithURL:url] queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        if (error) {
            [self.delegate fetchingNewsDataFailedWithError:error];
        } else {
            [self.delegate receivedScheduleDataJSON:data];
        }
    }];
}

- (void)refreshNewsFromTime:(NSString *)time
{
    if (time){
        NSString *urlAsString = [NSString stringWithFormat:@"http://tedxoxford.co.uk/api/get_posts/?since=%@&include=id,title,title_plain,content,excerpt,thumbnail", time];
        [self sendRequestTo:urlAsString];
    }
    else {
        NSString *urlAsString = @"http://tedxoxford.co.uk/api/get_posts/?include=id,title,title_plain,content,excerpt,thumbnail";
        [self sendRequestTo:urlAsString];
    }
}

- (void)getNewsByOffset:(NSUInteger)offset
{
    NSString *urlAsString = [NSString stringWithFormat:@"http://tedxoxford.co.uk/api/get_posts/?offset=%ld&include=id,title,title_plain,content,excerpt,thumbnail", offset];
    
    NSLog(@"%@", urlAsString);
    NSURL *url = [[NSURL alloc] initWithString:urlAsString];
    
    [NSURLConnection sendAsynchronousRequest:[[NSURLRequest alloc] initWithURL:url] queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        if (error) {
            [self.delegate fetchingNewsDataFailedWithError:error];
        } else {
            [self.delegate receivedNewsByOffsetJSON:data];
        }
    }];

    
}

- (void)sendRequestTo:(NSString *) urlAsString
{
    NSLog(@"%@", urlAsString);
    NSURL *url = [[NSURL alloc] initWithString:urlAsString];
    
    [NSURLConnection sendAsynchronousRequest:[[NSURLRequest alloc] initWithURL:url] queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        if (error) {
            [self.delegate fetchingNewsDataFailedWithError:error];
        } else {
            [self.delegate receivedNewsDataJSON:data];
        }
    }];
}

- (void)getImageForItem:(NewsData *)data
{
    ImageDownloader *downloader = [ImageDownloader new];
    downloader.delegate = self.delegate;
    
    [downloader getImageFromURLString:data.thumbnailImage forItemWithId:data.postid];
}


@end
