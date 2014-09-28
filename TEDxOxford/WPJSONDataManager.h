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


@interface WPJSONDataManager : NSObject<WPJSONCommunicatorDelegate, ImageOnScreenDelegate>

@property (strong, nonatomic) WPJSONCommunicator *communicator;

@property (weak, nonatomic) id<WPJSONDataManagerDelegate> delegate;

- (void)getRecentNewsByPage:(NSInteger) pageNumber;

@end
