//
//  WPJSONDataHandler.h
//  TEDxOxford
//
//  Created by Ari Aparikyan on 25/09/2014.
//  Copyright (c) 2014 Ari Aparikyan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WPJSONDataManagerDelegate.h"
#import "WPJSONCommunicatorDelegate.h"
#import "ImageOnScreenDelegate.h"
#import "WPJSONCommunicator.h"
#import "NewsDataBuilder.h"


@interface WPJSONDataManager : NSObject<WPJSONCommunicatorDelegate, ImageOnScreenDelegate>

@property (strong, nonatomic) WPJSONCommunicator *communicator;
@property (strong, nonatomic) NewsDataBuilder *builder;

@property (weak, nonatomic) id<WPJSONDataManagerDelegate> delegate;

- (void)getRecentNewsByPage:(NSInteger) pageNumber;
- (void)getSpeakers;
- (void)getSchedule;
- (void)getAboutUs;
- (void)getOurPartner;
- (void)refreshNewsFromTime:(NSString *)time;
- (void)loadMorePostsWithOffset:(NSUInteger)offset;
- (void)getImagesForItems:(NSMutableArray *)news;

@end
