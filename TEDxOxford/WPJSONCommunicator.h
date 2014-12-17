//
//  WPJSONCommunicator.h
//  TEDxOxford
//
//  Created by Ari Aparikyan on 25/09/2014.
//  Copyright (c) 2014 Ari Aparikyan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WPJSONCommunicatorDelegate.h"
#import "NewsData.h"
#import "ImageDownloader.h"

@interface WPJSONCommunicator : NSObject

@property (weak, nonatomic) id<WPJSONCommunicatorDelegate, ImageOnScreenDelegate> delegate;

- (void)getRecentNewsByPage:(NSInteger) pageNumber;
- (void)getSpeakers;
- (void)getSchedule;
- (void)getAboutUs;
- (void)getOurPartner;
- (void)refreshNewsFromTime:(NSString *)time;
- (void)getNewsByOffset:(NSUInteger) offset;
- (void)getImageForItem:(NewsData *) data;

@end
