//
//  NewsData.m
//  TEDxOxford
//
//  Created by Ari Aparikyan on 24/09/2014.
//  Copyright (c) 2014 Ari Aparikyan. All rights reserved.
//

#import "NewsData.h"

@implementation NewsData

- (NewsData *)copyTextData
{
    NewsData *copy = [[[self class] alloc] init];
    
    if (copy) {
        // Copy NSObject subclasses
        copy.title = [self.title copyWithZone:nil];
        copy.excerpt = [self.excerpt copyWithZone:nil];
        copy.content = [self.content copyWithZone:nil];
        copy.postid = [self.postid copyWithZone:nil];
    }
    
    return copy;
}

@end
