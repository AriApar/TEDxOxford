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

- (NSMutableArray *)newsDataFromJSON:(NSData *)objectNotation error:(NSError **)error
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
    //NSLog(@"Count %d", results.count);
    
    for (NSDictionary *groupDic in results) {
        NewsData *group = [[NewsData alloc] init];
        
        for (NSString *key in groupDic) {
            //Check for keys useful to NewsData
            if ([key isEqualToString:@"title_plain"]) {
                
                group.title = [[groupDic valueForKey:key] stringByConvertingHTMLToPlainText];
                
            }
            else if ([key isEqualToString:@"content"]) {
                
                group.content = [NSString stringWithFormat:@"<html><head><style>img{width:100%%;height:auto}iframe{width:100%%;}.aspect-ratio {position: relative;width: 100%%;height: 0;padding-bottom: 56.25%%;}.aspect-ratio iframe {width: 100%%;height: 100%%;};</style></head><body><div class=aspect-ratio>%@</div></body></html>", [[groupDic valueForKey:key]stringByDecodingHTMLEntities]];
                                 //@"<html><head><style>img{max-width:100%%;height:auto !important;width:auto !important;display:block;margin:0 auto;}iframe{max-width:100%%;height:auto !important;width:auto !important;display:block;margin:0 auto;};</style></head><body>                                 %@</body></html>", [[groupDic valueForKey:key]stringByDecodingHTMLEntities]];
                //style='margin:0; padding:0;'>
                
            }
            
            else if ([key isEqualToString:@"id"]) {
                
                group.postid = [[groupDic valueForKey:key] stringValue];
                
            }
            else if ([key isEqualToString:@"excerpt"]) {
                
                group.excerpt = [[groupDic valueForKey:key] stringByConvertingHTMLToPlainText];
                
            }
            
            else if ([key isEqualToString:@"thumbnail_images"]) {
                if ([groupDic objectForKey:key] != [NSNull null]) {
                    NSString *imgUrl = [[[groupDic valueForKey:key] valueForKey:@"full"] valueForKey:@"url"];
                    group.thumbnailImage = imgUrl;
                    
                    //Initialize downloader
                    ImageDownloader *downloader = [ImageDownloader new];
                    downloader.delegate = self.delegate;
                    
                    [downloader getImageFromURLString:imgUrl forItemWithId:[[groupDic valueForKey:@"id"] stringValue]];
                }
            }
        }
        // Add news item to array
        [newsData addObject:group];
    }
    
    return newsData;
}

- (NSMutableArray *) speakerDataFromJSON:(NSData *)objectNotation error:(NSError **)error
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
    //NSLog(@"Count %d", results.count);
    
    for (NSDictionary *groupDic in results) {
        NewsData *group = [[NewsData alloc] init];
        
        for (NSString *key in groupDic) {
            //Check for keys useful to NewsData
            if ([key isEqualToString:@"title_plain"]) {
                
                NSString *titleformat = @"TEDxOxford 2015 Speaker ";
                
                group.title = [[[groupDic valueForKey:key] stringByConvertingHTMLToPlainText] substringFromIndex:titleformat.length];
                
            }
            else if ([key isEqualToString:@"content"]) {
                
                group.content = [NSString stringWithFormat:@"<html><head><style>img{width:100%%;height:auto}iframe{width:100%%;}.aspect-ratio {position: relative;width: 100%%;height: 0;padding-bottom: 56.25%%;}.aspect-ratio iframe {width: 100%%;height: 100%%;};</style></head><body><div class=aspect-ratio>%@</div></body></html>", [[groupDic valueForKey:key]stringByDecodingHTMLEntities]];
                //@"<html><head><style>img{max-width:100%%;height:auto !important;width:auto !important;display:block;margin:0 auto;}iframe{max-width:100%%;height:auto !important;width:auto !important;display:block;margin:0 auto;};</style></head><body>                                 %@</body></html>", [[groupDic valueForKey:key]stringByDecodingHTMLEntities]];
                //style='margin:0; padding:0;'>
                
            }
            
            else if ([key isEqualToString:@"id"]) {
                
                group.postid = [[groupDic valueForKey:key] stringValue];
                
            }
            else if ([key isEqualToString:@"excerpt"]) {
                
                group.excerpt = [[groupDic valueForKey:key] stringByConvertingHTMLToPlainText];
                
            }
            
            else if ([key isEqualToString:@"thumbnail_images"]) {
                if ([groupDic objectForKey:key] != [NSNull null]) {
                    NSString *imgUrl = [[[groupDic valueForKey:key] valueForKey:@"full"] valueForKey:@"url"];
                    group.thumbnailImage = imgUrl;
                    
                    //Initialize downloader
                    ImageDownloader *downloader = [ImageDownloader new];
                    downloader.delegate = self.delegate;
                    
                    [downloader getImageFromURLString:imgUrl forItemWithId:[[groupDic valueForKey:@"id"] stringValue]];
                }
            }
        }
        // Add news item to array
        [newsData addObject:group];
    }
    
    return newsData;
}

- (NewsData *)scheduleDataFromJSON:(NSData *)objectNotation error:(NSError **)error
{
    NSError *localError = nil;
    NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:objectNotation options:0 error:&localError];
    
    if (localError != nil) {
        *error = localError;
        return nil;
    }
    
    NSDictionary *result = [parsedObject valueForKey:@"page"];
    
    NewsData *group = [[NewsData alloc] init];
    
    for (NSString *key in result) {
        //Check for keys useful to NewsData
        if ([key isEqualToString:@"title_plain"]) {
            
            group.title = [[result valueForKey:key] stringByDecodingHTMLEntities];
            
        }
        else if ([key isEqualToString:@"content"]) {
            group.content = [NSString stringWithFormat:@"<html><head><style>img{width:100%%;height:auto}iframe{width:100%%;}.aspect-ratio {position: relative;width: 100%%;height: 0;padding-bottom: 56.25%%;}.aspect-ratio iframe {width: 100%%;height: 100%%;};</style></head><body><div class=aspect-ratio>%@</div></body></html>", [[result valueForKey:key]stringByDecodingHTMLEntities]];//[result valueForKey:key];
            
        }
        
        else if ([key isEqualToString:@"id"]) {
            
            group.postid = [[result valueForKey:key] stringValue];
            
        }
        
    }
    
    return group;
}


@end