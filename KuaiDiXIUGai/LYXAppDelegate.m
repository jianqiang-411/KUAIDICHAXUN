//
//  LYXAppDelegate.m
//  KuaiDiXIUGai
//
//  Created by 李永兴 on 13-6-20.
//  Copyright (c) 2013年 李永兴. All rights reserved.
//

#import "LYXAppDelegate.h"

#import "LYXViewController.h"

#import <QuartzCore/QuartzCore.h>

#import "gongSi.h"

@implementation LYXAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.viewController = [[LYXViewController alloc] initWithNibName:@"LYXViewController" bundle:nil];
    
#pragma mark------------------创建导航栏第一步-------------
    
    UINavigationController * nav=[[UINavigationController alloc]initWithRootViewController:self.viewController];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(xuanzeButton) name:@"xuanzeButton" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(postNotifaction) name:@"postNotifaction" object:nil];
  
#pragma mark-----------------将导航试图作为根视图-------------------------
    
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    return YES;
}


- (void)xuanzeButton
{
    self.chekview =[[gongSi alloc]init];
    [self.viewController.navigationController pushViewController:self.chekview animated:NO];
//    self.window.rootViewController =self.chekview;
    
    
}



- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
