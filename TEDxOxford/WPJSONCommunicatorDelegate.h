//
//  WPJSONCommunicatorDelegate.h
//  TEDxOxford
//
//  Created by Ari Aparikyan on 25/09/2014.
//  Copyright (c) 2014 Ari Aparikyan. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol WPJSONCommunicatorDelegate

- (void)receivedNewsDataJSON:(NSData *)objectNotation;
- (void)fetchingNewsDataFailedWithError:(NSError *)error;
- (void)receivedScheduleDataJSON:(NSData *)objectNotation;
- (void)receivedNewsByOffsetJSON:(NSData *)objectNotation;

@end
