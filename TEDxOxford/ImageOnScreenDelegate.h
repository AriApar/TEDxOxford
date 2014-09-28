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

- (void)image:(UIImage *)image readyForItemAtIndex:(NSUInteger)index;
- (void)prepareImageFailedWithError:(NSError *)error forItemAtIndex:(NSUInteger)index;

@end
