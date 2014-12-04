//
//  ImageOnScreenDelegate.h
//  TEDxOxford
//
//  Created by Ari Aparikyan on 26/09/2014.
//  Copyright (c) 2014 Ari Aparikyan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NewsData.h"

@protocol ImageOnScreenDelegate <NSObject>

- (void)imageData:(NSData *)image readyForItemWithId:(NSString *)postid;
- (void)fetchingImageFailedWithError:(NSError *)error forItemWithId:(NSString *)postid;

@end
