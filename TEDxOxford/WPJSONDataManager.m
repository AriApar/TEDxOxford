//
//  WPJSONDataHandler.m
//  TEDxOxford
//
//  Created by Ari Aparikyan on 25/09/2014.
//  Copyright (c) 2014 Ari Aparikyan. All rights reserved.
//

#import "WPJSONDataManager.h"
#import "NewsDataBuilder.h"

@implementation WPJSONDataManager

- (id) init
{
    self = [super init];
    if(self) {
        _communicator = [WPJSONCommunicator new];
        _communicator.delegate = self;
    }
    return self;
}

- (void)getRecentNewsByPage:(NSInteger) pageNumber
{
    [self.communicator getRecentNewsByPage:pageNumber];
}

#pragma mark - WPJSONCommunicatorDelegate

- (void) fetchingNewsDataFailedWithError:(NSError *)error
{
    [self.delegate fetchingNewsDataFailedWithError:error];
}

- (void) receivedNewsDataJSON:(NSData *)objectNotation
{
    NSError *error = nil;
    //Initialize the data builder
    NewsDataBuilder *builder = [NewsDataBuilder new];
    builder.delegate = self;
    
    NSArray *newsItems = [builder newsDataFromJSON:objectNotation error:&error];
    
    if (error != nil) {
        [self.delegate fetchingNewsDataFailedWithError:error];
        
    } else {
        [self.delegate didReceiveNewsData:newsItems];
    }
}

#pragma mark - ImageOnScreenDelegate

- (void) prepareImageFailedWithError:(NSError *)error forItemAtIndex:(NSUInteger)index
{
    [self.delegate prepareImageFailedWithError:error forItemAtIndex:index];
}

- (void) image:(UIImage *)image readyForItemAtIndex:(NSUInteger)index
{
    [self.delegate updateImageForItemAtIndex:index withImage:image];
}
@end
