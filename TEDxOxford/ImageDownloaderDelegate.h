//
//  ImageDownloaderDelegate.h
//  TEDxOxford
//
//  Created by Ari Aparikyan on 26/09/2014.
//  Copyright (c) 2014 Ari Aparikyan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NewsData.h"

@protocol ImageDownloaderDelegate <NSObject>

- (void)receivedImage:(UIImage *)objectNotation forItemWithId:(NSString *)postid;
- (void)fetchingImageFailedWithError:(NSError *)error forItemWithId:(NSString *)postid;

@end
