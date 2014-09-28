//
//  NewsData.h
//  TEDxOxford
//
//  Created by Ari Aparikyan on 24/09/2014.
//  Copyright (c) 2014 Ari Aparikyan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NewsData : NSObject

@property NSString *title;
@property NSString *content;
@property NSString *postid;
@property NSString *excerpt;
@property UIImage *thumbnailImage;

- (NewsData *)copyTextData;


@end
