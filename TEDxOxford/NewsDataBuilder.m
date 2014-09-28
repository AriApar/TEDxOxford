//
//  NewsDataBuilder.m
//  TEDxOxford
//
//  Created by Ari Aparikyan on 25/09/2014.
//  Copyright (c) 2014 Ari Aparikyan. All rights reserved.
//

#import "NewsDataBuilder.h"
#import "NewsData.h"
#import "NSString+HTML.h"

@implementation NewsDataBuilder

- (NSArray *)newsDataFromJSON:(NSData *)objectNotation error:(NSError **)error
{
    NSError *localError = nil;
    NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:objectNotation options:0 error:&localError];
    
    if (localError != nil) {
        *error = localError;
        return nil;
    }
    
    NSMutableArray *newsData = [[NSMutableArray alloc] init];
    
    //UIImage *defImg = [UIImage imageNamed:@"defaultThumbnail"];
    
    NSArray *results = [parsedObject valueForKey:@"posts"];
    NSLog(@"Count %d", results.count);
    
    for (NSDictionary *groupDic in results) {
        NewsData *group = [[NewsData alloc] init];
        
        for (NSString *key in groupDic) {
            //Check for keys useful to NewsData
            if ([key isEqualToString:@"title_plain"]) {
                
                group.title = [groupDic valueForKey:key];
                
            }
            else if ([key isEqualToString:@"content"]) {
                
                group.content = [groupDic valueForKey:key];
                
            }
            
            else if ([key isEqualToString:@"id"]) {
                
                group.postid = [[groupDic valueForKey:key] stringValue];
                
            }
            else if ([key isEqualToString:@"excerpt"]) {
                
                group.excerpt = [[groupDic valueForKey:key] stringByConvertingHTMLToPlainText];
                
            }
            
            else if ([key isEqualToString:@"thumbnail"]) {
                if ([groupDic objectForKey:key] != [NSNull null]) {
                    NSString *imgUrl = [groupDic valueForKey:key];
                    //Initialize downloader
                    ImageDownloader *downloader = [ImageDownloader new];
                    downloader.delegate = self;
                    
                    [downloader getImageFromURLString:imgUrl forItemAtIndex:newsData.count];
                }
            }
        }
        // Add news item to array
        [newsData addObject:group];
    }
    
    return newsData;
}

#pragma mark - ImageDownloaderDelegate

- (void)receivedImage:(UIImage *)objectNotation forItemAtIndex:(NSUInteger) index
{
    [self.delegate image:objectNotation readyForItemAtIndex:index];
    
}

- (void)fetchingImageFailedWithError:(NSError *)error forItemAtIndex:(NSUInteger) index
{
    [self.delegate prepareImageFailedWithError:error forItemAtIndex:index];
}


@end