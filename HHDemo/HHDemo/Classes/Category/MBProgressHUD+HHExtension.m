//
//  MBProgressHUD+HHExtension.m
//  HHDemo
//
//  Created by 蔡万鸿 on 2017/3/15.
//  Copyright © 2017年 黄花菜. All rights reserved.
//

#import "MBProgressHUD+HHExtension.h"

@implementation MBProgressHUD (HHExtension)

+ (void)show {
    UIWindow *window  = [UIApplication sharedApplication].keyWindow;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:window animated:YES];
    hud.bezelView.color = [[UIColor blackColor] colorWithAlphaComponent:0.8f];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.userInteractionEnabled = YES;
    [hud showAnimated:YES];
}

+ (void)showHintMessage:(NSString *)message {
    [[self class] hideHUD];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:window animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.margin = 15.f;
    [hud setOffset:CGPointMake(0, 15.f)];
    hud.bezelView.color = [[UIColor blackColor] colorWithAlphaComponent:0.8f];
    hud.detailsLabel.text = message;
    hud.detailsLabel.font = [UIFont systemFontOfSize:16.f];
    hud.userInteractionEnabled = NO;
    [hud hideAnimated:YES afterDelay:2.f];
}

+ (void)showStatusWithMessage:(NSString *)message {
    [[self class] hideHUD];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:window animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.margin = 15.f;
    [hud setOffset:CGPointMake(0, 15.f)];
    hud.bezelView.color = [[UIColor blackColor] colorWithAlphaComponent:0.8f];
    hud.detailsLabel.text = message;
    hud.detailsLabel.font = [UIFont systemFontOfSize:16.f];
    hud.userInteractionEnabled = YES;
}

+ (void)hideHUD {
    UIWindow *window  = [UIApplication sharedApplication].keyWindow;
    for (UIView *view in window.subviews) {
        if ([view isKindOfClass:[self class]]) {
            [view removeFromSuperview];
        }
    }
}
@end
