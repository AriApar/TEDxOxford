//
//  AppDelegate.m
//  TEDxOxford
//
//  Created by Ari Aparikyan on 18/09/2014.
//  Copyright (c) 2014 Ari Aparikyan. All rights reserved.
//

#import "AppDelegate.h"
#import "NewsTableViewController.h"

#define UIColorFromRGB(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
                green:((float)((rgbValue & 0x00FF00) >>  8))/255.0 \
                blue:((float)((rgbValue & 0x0000FF) >>  0))/255.0 \
                alpha:1.0]

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self loadData];
    [NSThread sleepForTimeInterval:2.0];
    // Override point for customization after application launch.
    [[UITabBar appearance] setTintColor:UIColorFromRGB(0xE62B1E)];
    [[UINavigationBar appearance] setTintColor:UIColorFromRGB(0xE62B1E)];
    
    UITabBarController *tabBarController = (UITabBarController *) self.window.rootViewController;
    tabBarController.tabBar.tintColor = UIColorFromRGB(0xE62B1E);
    
    [tabBarController.moreNavigationController.navigationBar setTintColor:UIColorFromRGB(0xE62B1E)];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    [self saveData];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
    [self saveData];
}

- (void)saveData
{
    //NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    //NSLog(path);
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    if(![[NSFileManager defaultManager] fileExistsAtPath:path]){
        [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    UITabBarController *tabBarController = (UITabBarController *) self.window.rootViewController;
    
    UINavigationController *navController = (UINavigationController *)tabBarController.viewControllers[0];
    
    NewsTableViewController *mainController = (NewsTableViewController *)  navController.viewControllers[0];
    
    NSMutableDictionary *rootObject;
    rootObject = [NSMutableDictionary dictionary];
    
    [rootObject setValue:[mainController getNewsData] forKey:@"NewsData"];
    [rootObject setValue:[mainController getLastRefreshed] forKey:@"LastRefreshed"];
    
    BOOL success = [NSKeyedArchiver archiveRootObject:rootObject toFile:[path stringByAppendingPathComponent:@"archive.data"]];
    
    //NSLog(@"Archived: %@", success ? @"Yes" : @"No");
    
    
}

- (void) loadData {
    //NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    path = [path stringByAppendingPathComponent:@"archive.data"];
    
    UITabBarController *tabBarController = (UITabBarController *) self.window.rootViewController;
    
    UINavigationController *navController = (UINavigationController *)tabBarController.viewControllers[0];
    
    NewsTableViewController *mainController = (NewsTableViewController *)  navController.viewControllers[0];
    
    if([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        NSMutableDictionary *rootObject;
        rootObject = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
        
        if ([rootObject valueForKey:@"NewsData"]) {
            NSMutableArray *news = [NSMutableArray new];
            [news addObjectsFromArray:[rootObject valueForKey:@"NewsData"]];
            [mainController setNews:news];
        }
        if ([rootObject valueForKey:@"LastRefreshed"]) {
            [mainController setLastRefreshed:[rootObject valueForKey:@"LastRefreshed"]];
        }
        
        //NSLog(@"Data loaded");
    }

    
}

@end
