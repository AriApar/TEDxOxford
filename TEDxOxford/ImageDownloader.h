//
//  ImageDownloader.h
//  TEDxOxford
//
//  Created by Ari Aparikyan on 26/09/2014.
//  Copyright (c) 2014 Ari Aparikyan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "NewsData.h"
#import "ImageOnScreenDelegate.h"

@interface ImageDownloader : NSObject

@property (nonatomic) id<ImageOnScreenDelegate> delegate;

- (void)getImageFromURLString:(NSString *)urlAsString forItemWithId:(NSString *)postid;

@end
