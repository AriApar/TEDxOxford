//
//  NewsDataBuilder.h
//  TEDxOxford
//
//  Created by Ari Aparikyan on 25/09/2014.
//  Copyright (c) 2014 Ari Aparikyan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ImageDownloader.h"
#import "ImageDownloaderDelegate.h"
#import "ImageOnScreenDelegate.h"

@interface NewsDataBuilder : NSObject<ImageDownloaderDelegate>

@property (weak, nonatomic) id<ImageOnScreenDelegate> delegate;

- (NSArray *)newsDataFromJSON:(NSData *)objectNotation error:(NSError **)error;

@end
