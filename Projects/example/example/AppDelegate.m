//
//  AppDelegate.m
//  example
//
//  Created by Wanqiang Ji on 12/23/13.
//  Copyright (c) 2013 http://jiwanqiang.com. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@property (nonatomic, strong) UITabBarController *tabBarController;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];

    self.tabBarController = [UITabBarController new];
    self.window.rootViewController = self.tabBarController;
    
    return YES;
}

@end
