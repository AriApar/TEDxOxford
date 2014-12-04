//
//  WPJSONCommunicator.h
//  TEDxOxford
//
//  Created by Ari Aparikyan on 25/09/2014.
//  Copyright (c) 2014 Ari Aparikyan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WPJSONCommunicatorDelegate.h"

@interface WPJSONCommunicator : NSObject

@property (weak, nonatomic) id<WPJSONCommunicatorDelegate> delegate;

- (void)getRecentNewsByPage:(NSInteger) pageNumber;
- (void)getSpeakers;
- (void)getSchedule;
- (void)refreshNewsFromTime:(NSString *)time;
- (void)getNewsByOffset:(NSUInteger) offset;

@end
