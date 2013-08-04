//
//  LYXAppDelegate.h
//  KuaiDiXIUGai
//
//  Created by 李永兴 on 13-6-20.
//  Copyright (c) 2013年 李永兴. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "gongSi.h"

@class LYXViewController;

@interface LYXAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) LYXViewController *viewController;

@property (strong ,nonatomic) gongSi * chekview;

@property (strong , nonatomic) NSString *kuaiDiGongSi;


@end
