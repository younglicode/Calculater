//
//  AppDelegate.m
//  Calculater
//
//  Created by li on 16/5/17.
//  Copyright © 2016年 li. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "UIColor+FlatUI.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    self.window.backgroundColor = [UIColor blueColor];
    
    MainViewController *mvc = [[MainViewController alloc] init];
    
    mvc.view.backgroundColor = [UIColor whiteColor];
    
    self.window.rootViewController = mvc;
    
    [self.window makeKeyAndVisible];
    
    return YES;
}


@end
