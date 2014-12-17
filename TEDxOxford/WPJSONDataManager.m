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
        _builder = [NewsDataBuilder new];
        _builder.delegate = self;
    }
    return self;
}

- (void)getRecentNewsByPage:(NSInteger) pageNumber
{
    [self.communicator getRecentNewsByPage:pageNumber];
}

- (void)getSpeakers
{
    [self.communicator getSpeakers];
}

- (void)getSchedule
{
    [self.communicator getSchedule];
}

- (void)getAboutUs
{
    [self.communicator getAboutUs];
}

- (void)getOurPartner
{
    [self.communicator getOurPartner];
}

- (void)refreshNewsFromTime:(NSString *)time
{
    [self.communicator refreshNewsFromTime:time];
}

- (void)loadMorePostsWithOffset:(NSUInteger)offset
{
    [self.communicator getNewsByOffset:offset];
}

- (void)getImagesForItems:(NSMutableArray *)news
{
    for (NewsData *data in news) {
        if (!data.imageData && data.thumbnailImage)
        {
            [self.communicator getImageForItem:data];
        }
        
    }
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
    
    NSMutableArray *newsItems = [self.builder newsDataFromJSON:objectNotation error:&error];
    
    if (error != nil) {
        [self.delegate fetchingNewsDataFailedWithError:error];
        
    } else {
        [self.delegate didReceiveNewsData:newsItems];
    }
}

- (void) fetchingSpeakerDataFailedWithError:(NSError *)error
{
    [self.delegate fetchingNewsDataFailedWithError:error];
}

- (void) receivedSpeakerDataJSON:(NSData *)objectNotation
{
    NSError *error = nil;
    //Initialize the data builder
    
    NSMutableArray *newsItems = [self.builder speakerDataFromJSON:objectNotation error:&error];
    
    if (error != nil) {
        [self.delegate fetchingNewsDataFailedWithError:error];
        
    } else {
        [self.delegate didReceiveNewsData:newsItems];
    }
}

- (void)receivedNewsByOffsetJSON:(NSData *)objectNotation
{
    NSError *error = nil;
    //Initialize the data builder
    
    NSMutableArray *newsItems = [self.builder newsDataFromJSON:objectNotation error:&error];
    
    if (error != nil) {
        [self.delegate fetchingNewsDataFailedWithError:error];
        
    } else {
        [self.delegate didReceiveNewsOffsetData:newsItems];
    }

}

- (void) receivedScheduleDataJSON:(NSData *)objectNotation
{
    NSError *error = nil;
    
    NewsData *schedule = [self.builder scheduleDataFromJSON:objectNotation error:&error];
    
    
    if (error != nil) {
        [self.delegate fetchingNewsDataFailedWithError:error];
        
    } else {
        [self.delegate didReceiveScheduleData:schedule];
    }
}




#pragma mark - ImageOnScreenDelegate

- (void) prepareImageFailedWithError:(NSError *)error forItemWithId:(NSString *)postid
{
    [self.delegate prepareImageFailedWithError:error forItemWithId:postid];
}

- (void) imageData:(NSData *)image readyForItemWithId:(NSString *)postid
{
    
    [self.delegate updateImageForItemWithId:postid withImageData:image];
}
@end
