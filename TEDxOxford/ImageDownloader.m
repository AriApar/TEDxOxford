//
//  ImageDownloader.m
//  TEDxOxford
//
//  Created by Ari Aparikyan on 26/09/2014.
//  Copyright (c) 2014 Ari Aparikyan. All rights reserved.
//

#import "ImageDownloader.h"

@implementation ImageDownloader

- (void)getImageFromURLString:(NSString *)urlAsString forItemAtIndex:(NSUInteger)index
{
    NSURL *url = [[NSURL alloc] initWithString:urlAsString];
    NSLog(@"%@", urlAsString);
    
    [NSURLConnection sendAsynchronousRequest:[[NSURLRequest alloc] initWithURL:url] queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        if (error) {
            [self.delegate fetchingImageFailedWithError:error forItemAtIndex:index];
        } else {
            UIImage *image = [UIImage imageWithData:data];
            [self.delegate receivedImage:image forItemAtIndex:index];
        }
    }];
}

@end
