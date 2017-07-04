//
//  AppDelegate.m
//  HHDemo
//
//  Created by 蔡万鸿 on 2016/11/9.
//  Copyright © 2016年 黄花菜. All rights reserved.
//

#import "AppDelegate.h"
#import "HHMainVC.h"
#import "HHMainNavVC.h"

#import "HHSortTool.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    // 1.创建window
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    // 2.显示window
    [self.window makeKeyAndVisible];
    
    // 3.显示默认界面
    HHMainVC *mainVC = [[HHMainVC alloc] init];
    HHMainNavVC *navVC = [[HHMainNavVC alloc] initWithRootViewController:mainVC];
    self.window.rootViewController = navVC;
    
    
    NSMutableArray *array = [NSMutableArray arrayWithObjects:@9,@2,@10,@7,@3,@7,@4,nil];
    
    printf("排序前:");
    [HHSortTool printArray:array];
    //快速排序
    [HHSortTool quickSort:array low:0 high:6];
    //冒泡排序
    //    [HHSortTool buddleSort:array];
    //选择排序
    //    [HHSortTool selectSort:array];
    //插入排序
//    [HHSortTool inserSort:array];
    
    printf("排序后:");
    [HHSortTool printArray:array];

    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
