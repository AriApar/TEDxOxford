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
        copy.thumbnailImage = [self.thumbnailImage copyWithZone:nil];
    }
    
    return copy;
}


- (id)initWithTitle:(NSString *)title Content:(NSString *)content PostId:(NSString *)postid Excerpt:(NSString *)excerpt ThumbnailImage:(NSString *)thumbnailImage ImageData:(NSData *)imageData
{
    self = [super init];
    if (self)
    {
        _title = title;
        _content = content;
        _postid = postid;
        _excerpt = excerpt;
        _thumbnailImage = thumbnailImage;
        _imageData = imageData;
    }
    
    return self;
}

#pragma mark - NSCoding

- (void) encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.title forKey:@"Title"];
    [encoder encodeObject:self.content forKey:@"Content"];
    [encoder encodeObject:self.postid forKey:@"PostId"];
    [encoder encodeObject:self.excerpt forKey:@"Excerpt"];
    [encoder encodeObject:self.thumbnailImage forKey:@"ThumbnailImage"];
    [encoder encodeObject:self.imageData forKey:@"ImageData"];
}

- (id)initWithCoder:(NSCoder *)decoder {
    NSString *title = [decoder decodeObjectForKey:@"Title"];
    NSString *content = [decoder decodeObjectForKey:@"Content"];
    NSString *postid = [decoder decodeObjectForKey:@"PostId"];
    NSString *excerpt = [decoder decodeObjectForKey:@"Excerpt"];
    NSString *thumbnailImage = [decoder decodeObjectForKey:@"ThumbnailImage"];
    NSData *imageData = [decoder decodeObjectForKey:@"ImageData"];
    return [self initWithTitle:title Content:content PostId:postid Excerpt:excerpt ThumbnailImage:thumbnailImage ImageData:imageData];
}


@end
