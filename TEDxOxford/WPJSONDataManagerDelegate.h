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
- (void)fetchingNewsDataFailedWithError:(NSError *)error;
- (void)prepareImageFailedWithError:(NSError *)error forItemAtIndex:(NSUInteger) index;
- (void)updateImageForItemAtIndex:(NSUInteger)index withImage:(UIImage *)image;

@end
