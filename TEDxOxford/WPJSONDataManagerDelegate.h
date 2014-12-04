//
//  WPJSONDataManagerDelegate.h
//  TEDxOxford
//
//  Created by Ari Aparikyan on 26/09/2014.
//  Copyright (c) 2014 Ari Aparikyan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NewsData.h"

@protocol WPJSONDataManagerDelegate

- (void)didReceiveNewsData:(NSArray *)groups;
//- (void)didReceiveSpeakerData:(NSArray *)groups;
- (void)didReceiveNewsOffsetData:(NSArray *)groups;
- (void)fetchingNewsDataFailedWithError:(NSError *)error;
//- (void)fetchingSpeakerDataFailedWithError:(NSError *)error;
- (void)prepareImageFailedWithError:(NSError *)error forItemWithId:(NSString *)postid;
- (void)updateImageForItemWithId:(NSString *)postid withImageData:(NSData *)image;
- (void)didReceiveScheduleData:(NewsData *)newsData;

@end
