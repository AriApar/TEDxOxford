//
//  NewsDataBuilder.h
//  TEDxOxford
//
//  Created by Ari Aparikyan on 25/09/2014.
//  Copyright (c) 2014 Ari Aparikyan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ImageDownloader.h"
#import "ImageOnScreenDelegate.h"

@interface NewsDataBuilder : NSObject

@property (weak, nonatomic) id<ImageOnScreenDelegate> delegate;

- (NSMutableArray *)newsDataFromJSON:(NSData *)objectNotation error:(NSError **)error;
- (NewsData *)scheduleDataFromJSON:(NSData *)objectNotation error:(NSError **)error;
- (NSMutableArray *) speakerDataFromJSON:(NSData *)objectNotation error:(NSError **)error;

@end
