//
//  ImageDownloader.m
//  TEDxOxford
//
//  Created by Ari Aparikyan on 26/09/2014.
//  Copyright (c) 2014 Ari Aparikyan. All rights reserved.
//

#import "ImageDownloader.h"

@implementation ImageDownloader

- (void)getImageFromURLString:(NSString *)urlAsString forItemWithId:(NSString *)postid
{
    NSURL *url = [[NSURL alloc] initWithString:urlAsString];
    //NSLog(@"%@", urlAsString);
    
    [NSURLConnection sendAsynchronousRequest:[[NSURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:60] queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        if (error) {
            [self.delegate prepareImageFailedWithError:error forItemWithId:postid];
        } else {
            //UIImage *image = [UIImage imageWithData:data];
            [self.delegate imageData:data readyForItemWithId:postid];
        }
    }];
}

@end
